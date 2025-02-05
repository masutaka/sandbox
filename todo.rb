require 'json'

TODO_FILE = 'todo_list.json'

# ファイルからタスクを読み込む
def load_tasks
  return [] unless File.exist?(TODO_FILE)
  JSON.parse(File.read(TODO_FILE), symbolize_names: true)
end

# タスクをファイルに保存
def save_tasks(tasks)
  File.write(TODO_FILE, JSON.pretty_generate(tasks))
end

# タスクを追加
def add_task(description)
  tasks = load_tasks
  tasks << { id: tasks.size + 1, description: description, done: false }
  save_tasks(tasks)
  puts "タスク追加: #{description}"
end

# タスク一覧表示
def list_tasks
  tasks = load_tasks
  if tasks.empty?
    puts "タスクがありません。"
  else
    puts "TODO リスト:"
    tasks.each do |task|
      status = task[:done] ? "[完了]" : "[未完了]"
      puts "#{task[:id]}. #{status} #{task[:description]}"
    end
  end
end

# タスクを完了
def complete_task(id)
  tasks = load_tasks
  task = tasks.find { |t| t[:id] == id }
  if task
    task[:done] = true
    save_tasks(tasks)
    puts "タスク完了: #{task[:description]}"
  else
    puts "指定されたIDのタスクが見つかりません。"
  end
end

# タスクを削除
def delete_task(id)
  tasks = load_tasks
  tasks.reject! { |t| t[:id] == id }
  save_tasks(tasks)
  puts "タスク削除: ID #{id}"
end

# コマンド処理
command = ARGV[0]
case command
when "add"
  add_task(ARGV[1..].join(" "))
when "list"
  list_tasks
when "done"
  complete_task(ARGV[1].to_i)
when "delete"
  delete_task(ARGV[1].to_i)
else
  puts "使用方法: ruby todo.rb [add|list|done|delete] [タスク内容 or タスクID]"
end
