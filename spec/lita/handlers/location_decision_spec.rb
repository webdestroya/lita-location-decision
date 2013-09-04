require "spec_helper"

describe Lita::Handlers::LocationDecision, lita_handler: true do
  it { routes_command("remember taco bell as a lunch location").to(:remember_location) }
  it { routes_command("forget taco bell as a lunch location").to(:forget_location) }
  it { routes_command("forget all locations for lunch").to(:forget_all_locations) }
  it { routes_command("forget all lunch locations").to(:forget_all_locations) }

  it { routes_command("where can we go for lunch?").to(:list_locations) }
  it { routes_command("where should we go for lunch?").to(:choose_location) }

  it { routes_command("where can we go for lunch").to(:list_locations) }
  it { routes_command("where should we go for lunch").to(:choose_location) }

  # it "checks the parser" do
  #   send_command "remember taco bell as a lunch location"
  #   expect(replies.last).to_not be_nil
  #   expect(replies.last).to eq("No cities match your search query")
  # end


  it "checks the system" do
    send_command "remember taco bell as a lunch location"
    expect(replies.last).to_not be_nil
    expect(replies.last).to eq("I have added taco bell to the list of lunch locations.")

    send_command "where can we go for lunch?"
    expect(replies.last).to_not be_nil
    expect(replies.last).to eq("I know about the following lunch locations: taco bell")

    send_command "where should we go for lunch?"
    expect(replies.last).to_not be_nil
    expect(replies.last).to eq("I think you should go to taco bell for lunch.")

    send_command "forget all lunch locations"
    expect(replies.last).to_not be_nil
    expect(replies.last).to include("I have removed all lunch locations.")
  end

  it "checks an forget all with no locations" do 
    send_command "forget all lunch locations"
    expect(replies.last).to_not be_nil
    expect(replies.last).to include("I do not know about any lunch locations.")
  end
end
