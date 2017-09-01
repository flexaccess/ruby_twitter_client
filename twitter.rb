require 'twitter'
require 'optparse'

CONSUMER_KEY = '' # insert
CONSUMER_SECRET = '' # insert
ACCESS_TOKEN = '' # insert
ACCESS_TOKEN_SECRET = '' # insertZz

options = {}

OptionParser.new do |opt|
  opt.banner = "Usage twitter.rb [options]"

  opt.on('-h', 'Prints help') do
    puts opt
    exit
  end

  opt.on('--twit "MESSAGE"', 'Post twit') {|o| options[:twit] = o}
  opt.on('--timeline USER_NAME', 'Show last twits of a specified user') {|o| options[:timeline] = o}

end.parse!

client = Twitter::REST::Client.new do |config|
  config.consumer_key = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
  config.access_token = ACCESS_TOKEN
  config.access_token_secret = ACCESS_TOKEN_SECRET
end

if options.key?(:twit)
  client.update(options[:twit])
  i = 0
  print "Posting "
  loop do
    print "< "
    sleep 0.2
    i += 1
    break if i >= 5
  end
  print "Done!"
  puts
  abort
end

def def_twit(twitt)
  twitt.each do |twit|
    puts twit.text
    puts "by @#{twit.user.screen_name}, #{twit.created_at}"
    puts "-"*40
  end
end

if options.key?(:timeline)
  puts "Timeline User: #{options[:timeline]}"

  opts = {count: 7, include_rts: true}

  twits = client.user_timeline(options[:timeline], opts)
  puts
  def_twit(twits)
else
  puts "My Timeline:"
  twits = client.home_timeline({count: 5})
  def_twit(twits)
end