require 'erb'
require 'date'
require 'yaml'
require 'net/http'
require 'uri'

task default: [:open_instructions, :create_script, :download_input]

task :open_instructions do
  today = Date.today
  `open https://adventofcode.com/#{today.year}/day/#{today.day}`
end

task :create_script do
  today = Date.today
  template = ERB.new(File.read('./template.rb.erb'))
  day = '%02d' % today.day
  filename = "#{day}.rb"

  if !File.exist?(filename)
    File.open(filename, 'w') do |f|
      f << template.result_with_hash(day: day)
    end

    File.chmod(0755, filename)
  end
end

task :download_input do
  today = Date.today
  day = '%02d' % today.day
  filename = "#{day}.input"
  settings = YAML.load_file('./settings.yml')
  raise("Missing value for session in settings.yml") unless (session = settings['session'])
  uri = URI("https://adventofcode.com/#{today.year}/day/#{today.day}/input")
  headers = {
    'authority' => 'adventofcode.com',
    'cache-control' => 'max-age=0',
    'upgrade-insecure-requests' => '1',
    'user-agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36',
    'accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
    'referer' => "https://adventofcode.com/#{today.year}/day/#{today.day}",
    'accept-encoding' => 'gzip, deflate, br',
    'accept-language' => 'en-US,en;q=0.9,zh;q=0.8',
    'cookie' => "session=#{session}",
  }
  response = Net::HTTP.get(uri, headers)

  File.open(filename, 'w') do |f|
    f << response.body
  end
end
