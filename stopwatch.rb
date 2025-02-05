#!/usr/bin/env ruby

require 'time'

class Stopwatch
  def initialize
    @start_time = nil
    @end_time = nil
  end

  def start
    if running?
      puts "Stopwatch is already running!"
    else
      @start_time = Time.now
      @end_time = nil
      puts "Stopwatch started..."
    end
  end

  def stop
    if running?
      @end_time = Time.now
      puts "Stopwatch stopped. Elapsed time: #{elapsed_time} seconds"
    else
      puts "Stopwatch is not running!"
    end
  end

  def elapsed_time
    return 0 unless @start_time
    (@end_time || Time.now) - @start_time
  end

  def running?
    !@start_time.nil? && @end_time.nil?
  end
end

# Execution
stopwatch = Stopwatch.new

loop do
  puts "\nCommands: start | stop | exit"
  print "Enter command: "
  input = gets.chomp.downcase

  case input
  when "start"
    stopwatch.start
  when "stop"
    stopwatch.stop
  when "exit"
    puts "Exiting stopwatch..."
    break
  else
    puts "Invalid command!"
  end
end
