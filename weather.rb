#!/usr/bin/env ruby

require 'net/http'
require 'json'

API_KEY = 'your_openweathermap_api_key' # Replace with your actual API key
BASE_URL = 'https://api.openweathermap.org/data/2.5/weather'

def fetch_weather(city)
  url = "#{BASE_URL}?q=#{city}&appid=#{API_KEY}&units=metric"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)

  if data['cod'] == 200
    display_weather(data)
  else
    puts "Error: #{data['message']}"
  end
end

def display_weather(data)
  city = data['name']
  country = data['sys']['country']
  temp = data['main']['temp']
  weather = data['weather'][0]['description']

  puts "Weather in #{city}, #{country}:"
  puts "Temperature: #{temp}°C"
  puts "Condition: #{weather.capitalize}"
end

# Execution
if ARGV.empty?
  puts "Usage: ruby weather.rb [city_name]"
else
  fetch_weather(ARGV.join(' '))
end
