require "lita"

module Lita
  module Handlers

    # Provides a location decision helper
    class LocationDecision < Handler

      route %r{^remember\s+(.+)\s+as a(?:|n)\s+(.+)\s+location\s*$}i,
        :remember_location, command: true,
        help: {"location-decision" => "For instructions on using the location decision plugin, refer to: https://github.com/webdestroya/lita-location-decision"}

      route %r{^forget\s+(.+)\s+as a(?:|n)\s+(.+)\s+location\s*$}i,
        :forget_location, command: true

      route %r{^forget\s+all\s+locations\s+for\s+(.+)\s*$}i,
        :forget_all_locations, command: true

      route %r{^forget\s+all\s+(.+)\s+locations\s*$}i,
        :forget_all_locations, command: true

      route %r{^where\s+can\s+(?:.+)\s+go\s+for\s+(.+?)\s*(?:|\?)\s*$}i,
        :list_locations, command: true

      route %r{^where\s+should\s+(?:.+)\s+go\s+for\s+(.+?)\s*(?:|\?)\s*$}i,
        :choose_location, command: true



      def remember_location(response)
        location = response.matches[0][0]
        group = response.matches[0][1]

        locations = get_locations(group)

        locations = [] if locations.nil?

        locations << location

        update_locations group, locations

        response.reply "I have added #{location} to the list of #{group} locations."
      end

      def forget_location(response)
        location = response.matches[0][0]
        group = response.matches[0][1]

        locations = get_locations(group)

        if locations.nil?
          response.reply no_locations(group)
          return
        end

        locations.reject! {|item| item.downcase.eql?(location.downcase) }

        update_locations group, locations

        response.reply "I have removed #{location} from the list of #{group} locations."
      end

      def forget_all_locations(response)
        group = response.matches[0][0]

        count = redis.del("location-decision:#{group}")

        if count == 1
          response.reply "I have removed all #{group} locations."
        else
          response.reply "I do not know about any #{group} locations."
        end
      end

      def list_locations(response)
        group = response.matches[0][0]

        locations = get_locations(group)

        if locations.nil?
          response.reply no_locations(group)
          return
        end

        response.reply "I know about the following #{group} locations: #{locations.join(', ')}"
      end

      def choose_location(response)
        group = response.matches[0][0]

        locations = get_locations(group)

        if locations.nil?
          response.reply no_locations(group)
          return
        end

        location = locations.shuffle.first

        response.reply "I think you should go to #{location} for #{group}."
      end

      private

      def no_locations(group)
        "No #{group} locations have been added."
      end

      def get_locations(group)
        return nil unless redis.exists("location-decision:#{group}")

        MultiJson.load(redis.get("location-decision:#{group}"))
      end

      def update_locations(group, locations)

        # Only compare them by lowercase
        locations.uniq! { |item| item.downcase }

        redis.set "location-decision:#{group}", MultiJson.dump(locations)
      end

    end

    Lita.register_handler(LocationDecision)
  end
end
