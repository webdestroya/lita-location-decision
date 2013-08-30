# lita-location-decision

[![Build Status](https://travis-ci.org/webdestroya/lita-location-decision.png)](https://travis-ci.org/webdestroya/lita-location-decision)
[![Code Climate](https://codeclimate.com/github/webdestroya/lita-location-decision.png)](https://codeclimate.com/github/webdestroya/lita-location-decision)
[![Coverage Status](https://coveralls.io/repos/webdestroya/lita-location-decision/badge.png)](https://coveralls.io/r/webdestroya/lita-location-decision)

**lita-location-decision** is a handler for [Lita](https://github.com/jimmycuadra/lita) that helps you make a decision about places to go.

It is heavily based on the similarly named [hubot plugin](https://github.com/github/hubot-scripts/blob/master/src/scripts/location-decision-maker.coffee).

## Installation

Add lita-location-decision to your Lita instance's Gemfile:

``` ruby
gem "lita-location-decision"
```

## Usage

``` text
Lita: remember <location> as a <group> location - Remembers the location for the group
Lita: forget <location> as a <group> location - Forgets the location from the group
Lita: forget all locations for <group> - Forgets all the locations for the group
Lita: where can we go for <group>? - Returns a list of places that exist for the group
Lita: where should we go for <group>? - Returns a randomly selected location for the group
```

## License

[MIT](http://opensource.org/licenses/MIT)
