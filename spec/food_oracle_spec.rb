require_relative '../lib/food_oracle'

RSpec.describe FoodOracle do
  let(:oracle) { FoodOracle.new slack }
  let(:slack) { double(:slack, start!: nil, on: nil) }

  it 'sends a lunch suggestion on "!lunch"' do
    message = double(:message, text: '!lunch', channel: '1')
    allow(slack).to receive(:on).with(:message).and_yield(message)

    expect(slack).to receive(:message) do |args|
      expect(args[:channel]).to eq('1')
      expect(FoodOracle::LUNCHES).to include(args[:text])
    end

    oracle.start
  end

  it 'sends a burger comment on "hungry"' do
    message = double(:message, text: 'i am hungry', channel: '1')
    allow(slack).to receive(:on).with(:message).and_yield(message)

    expect(slack).to receive(:message) do |args|
      expect(args[:channel]).to eq('1')
      expect(FoodOracle::BURGERS).to include(args[:text])
    end

    oracle.start
  end
end
