#!/usr/bin/env ruby

require 'securerandom'

class PasswordGenerator
  DEFAULT_LENGTH = 12
  SYMBOLS = %w[! @ # $ % ^ & * ( ) _ + - =].freeze

  def initialize(length: DEFAULT_LENGTH, use_symbols: true, use_numbers: true, use_uppercase: true)
    @length = length
    @char_pool = build_character_pool(use_symbols, use_numbers, use_uppercase)
  end

  def generate
    return "Error: No character set selected!" if @char_pool.empty?

    Array.new(@length) { @char_pool[SecureRandom.rand(@char_pool.length)] }.join
  end

  private

  def build_character_pool(use_symbols, use_numbers, use_uppercase)
    lowercase = ('a'..'z').to_a
    uppercase = ('A'..'Z').to_a if use_uppercase
    numbers = ('0'..'9').to_a if use_numbers
    symbols = SYMBOLS if use_symbols

    lowercase + (uppercase || []) + (numbers || []) + (symbols || [])
  end
end

# Execution
length = (ARGV[0] || PasswordGenerator::DEFAULT_LENGTH).to_i
generator = PasswordGenerator.new(length: length)
puts "Generated Password: #{generator.generate}"
