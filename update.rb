require 'open-uri'
require 'json'

KEY_FILE = 'meetup_key'
API_URL = 'http://api.meetup.com'
GROUP_ID = '1611469'
TALKSDIR = 'talks'
SUBDIR = %w(slides code)
KEY = File.new(KEY_FILE, 'r').readline

def url(path, params = {})
  params[:key] = KEY
  param_string = params.collect { |k, v| "#{k}=#{v}" }.join("&")
  "#{API_URL}/#{path}?#{param_string}"
end

def folder_name(event_hash) # Mon Sep 27 17:30:00 CDT 2010
  time = event_hash["time"]
  name = event_hash["name"]
  time = time.split(' ')
  time = time[2] + time[1] + time[5]
  "#{time} - #{name}"
end

puts "Updating source from meetup.com"

data = open(url('events', :group_id => GROUP_ID)).read
data = JSON.parse(data)
data = data["results"]

data.each do |event|
  folder = File.join(TALKSDIR, folder_name(event))
  if not File.exists?(folder)
    Dir.mkdir(folder)
    SUBDIR.each do |sub|
      Dir.mkdir(File.join(folder, sub))
    end
    puts "[create] #{folder}"
  else
    puts "[exists] #{folder}"
  end
end