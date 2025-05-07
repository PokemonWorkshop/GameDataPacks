require 'json'
require 'fileutils'

$settings = JSON.parse(File.read('settings.json'))
pokemon_folder_path = File.join('Data', 'Studio', 'pokemon')
$source_path = File.join($settings['source_path'].to_s, pokemon_folder_path)
$pack_path = File.join('..', "Gen #{$settings['generation_number']}", $settings['version'].to_s, pokemon_folder_path)
$pokemon_list = $settings['pokemon_list'].map { |name| name.sub(/^:/, '').downcase }
$current_backup_folder = File.join('backup', Time.now.strftime('%Y-%m-%d_%H-%M-%S'))

# Ask the user what they want the program to do
def ask_choice
  choice = 0

  until [1, 2, 3].include?(choice.to_i)
    puts 'Choose a mode:'
    puts '1 - Merge Pokémon movepools'
    puts '2 - Merge everything'
    puts '3 - Exit'
    print 'Enter your choice: '
    choice = gets.chomp
  end

  choice.to_i
end

# Create backup and output folders if needed
# Clean the content of the output folder
# Clean the oldest backups and the empty ones
def prepare_folders
  FileUtils.mkdir('output') unless Dir.exist?('output')
  FileUtils.mkdir('backup') unless Dir.exist?('backup')

  Dir.glob(File.join('output', '*')).each do |file|
    FileUtils.rm_rf(file)
  end

  backup_dirs = Dir.children('backup').map { |f| File.join('backup', f) }.select { |path| File.directory?(path) }.sort_by { |path| File.mtime(path) }
  backup_dirs[0...(backup_dirs.size - 10)].each { |old_dir| FileUtils.rm_rf(old_dir) } unless backup_dirs.size < 10

  FileUtils.mkdir($current_backup_folder)
end

# Save the newly generated JSON file in the output folder and in the user's source folder
# @param file_name [String] the name of the file to save
# @param data [Hash] the data to save in the file
def save_json(file_name, data)
  json = JSON.pretty_generate(data)
  json.gsub!(/\[\s+\]/, '[]')

  File.write(File.join('output', file_name), json)
  File.write(File.join($source_path, file_name), json)
end

# Verify if a file is present in both the pack and in the user's source folder
# @param file_name [String] the name of the file to check
# @return [Boolean] true if both files exist, false otherwise
def check_files_existence(file_name)
  unless File.exist?(File.join($source_path, file_name))
    puts "#{file_name} missing in your project, please verify your settings file."
    return false
  end

  unless File.exist?(File.join($pack_path, file_name))
    puts "#{file_name} missing in the chosen version, please verify your settings file and that the Pokémon exists in this version."
    return false
  end

  true
end

def merge_movepools
  $pokemon_list.each do |name|
    file_name = "#{name}.json"
    next unless check_files_existence(file_name)

    maker_file = File.join($source_path, file_name)
    FileUtils.cp(maker_file, $current_backup_folder)

    user_data = JSON.parse(File.read(maker_file))
    pack_data = JSON.parse(File.read(File.join($pack_path, file_name)))
    next unless user_data && pack_data

    merged_data = user_data.dup

    merged_data['forms'].each do |form|
      matching_form = []
      pack_data['forms'].each do |pack_form|
        matching_form = pack_form['moveSet'] if pack_form['form'] == form['form']
      end

      form['moveSet'] = matching_form if matching_form != []
    end

    save_json(file_name, merged_data)
    puts "#{file_name} generated!"
  end
end

def merge_forms
  $pokemon_list.each do |name|
    file_name = "#{name}.json"
    next unless check_files_existence(file_name)

    maker_file = File.join($source_path, file_name)
    FileUtils.cp(maker_file, File.join($current_backup_folder, file_name))

    user_data = JSON.parse(File.read(maker_file))
    pack_data = JSON.parse(File.read(File.join($pack_path, file_name)))
    next unless user_data && pack_data

    merged_data = user_data.dup
    forms = []

    merged_data['forms'].each do |form|
      matching_form = []
      pack_data['forms'].each do |pack_form|
        matching_form = pack_form if pack_form['form'] == form['form']
      end

      if matching_form == []
        forms << form
      else
        matching_form['formTextId'] = form['formTextId']
        forms << matching_form
      end
    end

    merged_data['forms'] = forms

    save_json(file_name, merged_data)
    puts "#{file_name} generated!"
  end
end

def main
  user_choice = ask_choice

  case user_choice
  when 1
    prepare_folders
    puts 'Merging movepools...'
    merge_movepools
    puts 'Merging movepools process finished!'
  when 2
    prepare_folders
    puts 'Merging forms...'
    merge_forms
    puts 'Merging forms process finished!'
  else
    puts 'Exiting...'
    exit
  end
end

main
