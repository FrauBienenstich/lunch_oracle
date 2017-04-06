class FoodOracle
  LUNCHES = ['BURGERZ', 'Anaveda', 'Cosmoveda', 'Fish House :fish:', 'Mercosy', ':hamburger: :hamburger:', 'Chez Michel :fr:', 'ottorink weinbar :wine_glass:', 'ORA', 'Lasan :halalparrot:', 'Green Rice', 'Royals Vuong', 'Alimentari e Vini :it: :pizza:'].freeze
  BURGERS = ['Did you say burgers?', 'I heard Markthalle 9 has some good burgers.', 'A burger a day keeps the doctor away.', "Isn't it Burgersday today?", "Looks like it's the perfect weather for burgers.", 'What does the burger forecast say for today?'].freeze

  def initialize(slack)
    @slack = slack
    @slack.on :hello do
      puts "Successfully connected, welcome '#{@slack.self.name}' to the '#{@slack.team.name}' team at https://#{@slack.team.domain}.slack.com."
    end

    @slack.on :message do |data|
      handle_message data
    end

    @slack.on :close do |_data|
      puts 'Connection closing, exiting.'
    end

    @slack.on :closed do |_data|
      puts 'Connection has been disconnected.'
    end
  end

  def start
    @slack.start!
  end

  private

  def handle_message(data)
    case data.text
    when /(!lunch)/
      @slack.message channel: data.channel, text: LUNCHES.sample
    when /(hungry)/
      @slack.message channel: data.channel, text: BURGERS.sample
    end
  end
end
