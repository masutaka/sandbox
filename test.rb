#!/usr/bin/env ruby

require 'pathname'

# Categorize files in the given directory by their extensions
def categorize_files(directory)
  return puts "Directory does not exist: #{directory}" unless Dir.exist?(directory)

  Pathname(directory).children.each_with_object(Hash.new { |h, k| h[k] = [] }) do |file, categories|
    next if file.directory?

    ext = file.extname.downcase
    ext = 'none' if ext.empty?
    categories[ext] << file.basename.to_s
  end
end

# Display categorized files
def display_categories(directory)
  categories = categorize_files(directory)
  return unless categories

  puts "Files in directory '#{directory}':"
  categories.each do |ext, files|
    puts "[#{ext}]"
    files.each { |file| puts "  - #{file}" }
  end
end

# Execution
directory_path = ARGV[0] || '.'
display_categories(directory_path)
