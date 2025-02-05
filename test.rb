#!/usr/bin/env ruby

require 'fileutils'

# List files in the specified directory and categorize them by extension
def categorize_files(directory)
  return puts "Directory does not exist: #{directory}" unless Dir.exist?(directory)

  file_categories = Hash.new { |hash, key| hash[key] = [] }

  Dir.foreach(directory) do |file|
    next if File.directory?(file) # Skip directories
    ext = File.extname(file).downcase
    ext = 'none' if ext.empty?
    file_categories[ext] << file
  end

  puts "Files in directory '#{directory}':"
  file_categories.each do |ext, files|
    puts "[#{ext}]"
    files.each { |file| puts "  - #{file}" }
  end
end

# Execution
directory_path = ARGV[0] || '.' # Use the current directory if no argument is provided
categorize_files(directory_path)
