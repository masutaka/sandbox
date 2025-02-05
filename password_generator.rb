#!/usr/bin/env ruby

require 'securerandom'

# Generate a random password with the given length and character options
def generate_password(length = 12, use_symbols: true, use_numbers: true, use_uppercase: true)
  lowercase = ('a'..'z').to_a
  uppercase = ('A'..'Z').to_a if use_uppercase
  numbers = ('0'..'9').to_a if use_numbers
  symbols = %w[! @ # $ % ^ & * ( ) _ + - =] if use_symbols

  char_pool = lowercase + (uppercase || []) + (numbers || []) + (symbols || [])

  return "Error: No character set selected!" if char_pool.empty?

  Array.new(length) { char_pool.sample }.join
end

# Execution
length = ARGV[0] ? ARGV[0].to_i : 12
puts "Generated Password: #{generate_password(length)}"
