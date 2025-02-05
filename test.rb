#!/usr/bin/env ruby

require 'fileutils'

# 指定したディレクトリ内のファイルを拡張子ごとに分類して表示する
def categorize_files(directory)
  return puts "ディレクトリが存在しません: #{directory}" unless Dir.exist?(directory)

  file_categories = Hash.new { |hash, key| hash[key] = [] }

  Dir.foreach(directory) do |file|
    next if File.directory?(file) # ディレクトリはスキップ
    ext = File.extname(file).downcase
    ext = 'なし' if ext.empty?
    file_categories[ext] << file
  end

  puts "ディレクトリ '#{directory}' 内のファイル一覧:"
  file_categories.each do |ext, files|
    puts "[#{ext}]"
    files.each { |file| puts "  - #{file}" }
  end
end

# 実行
directory_path = ARGV[0] || '.' # 引数がない場合はカレントディレクトリを対象
categorize_files(directory_path)
