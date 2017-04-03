require 'slack-ruby-client'
require 'pry'

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  config.logger = Logger.new(STDOUT)
  config.logger.level = Logger::INFO
  fail 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts "Successfully connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
end

client.on :message do |data|
  puts data
  case data.text
  when /(!lunch)/
    client.message channel: data.channel, text: ["BURGERZ", "Anaveda", "Cosmoveda", "Fish House :fish:", "Mercosy", ":hamburger: :hamburger:", "Chez Michel :fr:", "ottorink weinbar :wine_glass:", "ORA", "Lasan :halalparrot:"].sample
  when /(lunch)|(hungry)/
    client.message channel: data.channel, text: ["Did you say burgers?", "I heard Markthalle 9 has some good burgers.", "A burger a day keeps the doctor away.", "Isn't it Burgersday today?", "Looks like it's the perfect weather for burgers.", "What does the burger forecast say for today?"].sample
  end
end

client.on :close do |_data|
  puts 'Connection closing, exiting.'
end

client.on :closed do |_data|
  puts 'Connection has been disconnected.'
end

client.start!