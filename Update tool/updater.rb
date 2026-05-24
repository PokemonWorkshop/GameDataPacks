require 'json'
require 'fileutils'

# JSON data of the settings file
$settings = JSON.parse(File.read('settings.json'))

# Paths to the user's project folder and the pack folder
pokemon_folder_path = File.join('Data', 'Studio', 'pokemon')
$source_path = File.join($settings['source_path'].to_s, pokemon_folder_path)
$pack_path = File.join('..', "Gen #{$settings['generation_number']}", $settings['version'].to_s, pokemon_folder_path)

# List of Pokémon to update
$pokemon_list = $settings['pokemon_list'].map { |name| name.sub(/^:/, '').downcase }

# Name of the backup folder
$current_backup_folder = File.join('backup', Time.now.strftime('%Y-%m-%d_%H-%M-%S'))

# User's choice of preset data to update, 5 means the data is cherry-picked
$main_choice = nil

# List of data to update
$data_to_update = []

# Data presets
$basic_data_preset = %w[height weight type1 type2 abilities baseHp baseAtk baseDfe baseSpd baseAts baseDfs evHp evAtk evDfe evSpd evAts evDfs]
$specie_data_preset = %w[evolutions itemHeld femaleRate babyDbSymbol babyForm moveSet]
$complex_data_preset = %w[experienceType baseExperience catchRate baseLoyalty breedGroups hatchSteps]
$all_data_preset = ($basic_data_preset + $specie_data_preset + $complex_data_preset).flatten

# Ask the user if they want to update everything or choose which data individually
def ask_main_choice
  choice = -1
  until [1, 2, 3, 4, 5, 6].include?(choice)
    puts 'Available modes:'
    puts '1 - Update everything'
    puts '2 - Update basic data (height, weight, types, stats, EVs, abilities)'
    puts '3 - Update specie data (evolutions, items, female rate, baby symbol, baby form, movepool)'
    puts '4 - Update complex data (base exp, exp type, catch rate, base happiness, egg groups, hatch steps)'
    puts '5 - Choose individually'
    puts '6 - Exit'
    print 'Enter your choice: '
    choice = gets.chomp
    choice = choice.to_i if choice.match?(/^\d+$/)
    choice = 1 if choice == ''
  end

  return $main_choice = choice unless choice == 6

  puts 'Exiting...'
  exit
end

# Ask the user which data they want to update individually
def ask_data_to_update
  puts <<~HELP
    Available data to update:
    Basic data (0 for all Basic data): 1 - measurements, 2 - types 3 - abilities 4 - base stats 5 - EVs
    Specie data (10 for all Specie data): 11 - evolutions, 12 - items, 13 - female rate, 14 - baby info, 15 - movepool
    Complex data (20 for all Complex data): 21 - experience info, 22 - catch rate, 23 - base happiness, 24 - egg info
    Please enter the numbers of the data you want to update, separated by spaces. Press Enter to finish
    Your choices:
  HELP

  user_choices = gets.chomp.split.map(&:to_i)

  user_choices.each do |choice|
    case choice
    when 0
      $data_to_update << $basic_data_preset
    when 10
      $data_to_update << $specie_data_preset
    when 20
      $data_to_update << $complex_data_preset
    else
      $data_to_update <<
        case choice
        when 1 then %w[height weight]
        when 2 then %w[type1 type2]
        when 3 then 'abilities'
        when 4 then %w[baseHp baseAtk baseDfe baseSpd baseAts baseDfs]
        when 5 then %w[evHp evAtk evDfe evSpd evAts evDfs]
        when 11 then 'evolutions'
        when 12 then 'itemHeld'
        when 13 then 'femaleRate'
        when 14 then %w[babyDbSymbol babyForm]
        when 15 then 'moveSet'
        when 21 then %w[experienceType baseExperience]
        when 22 then 'catchRate'
        when 23 then 'baseLoyalty'
        when 24 then %w[breedGroups hatchSteps]
        end
    end
  end

  $data_to_update.flatten!.uniq!
end

# Prepare choices variables by asking the user what they want the program to do
def prepare_choices
  ask_main_choice
  case $main_choice
  when 1
    $data_to_update = $all_data_preset
  when 2
    $data_to_update = $basic_data_preset
  when 3
    $data_to_update = $specie_data_preset
  when 4
    $data_to_update = $complex_data_preset
  when 5
    ask_data_to_update
  end
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

# Update all the data of all the forms, leaving IDs and maker's custom forms unchanged
# @param user_data [Hash] the user's data
# @param pack_data [Hash] the pack's data
def update_everything(user_data, pack_data)
  forms = []

  user_data['forms'].each do |form|
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

  user_data['forms'] = forms
  return user_data
end

# Main loop updating the data
def update
  $pokemon_list.each do |name|
    file_name = "#{name}.json"
    next unless check_files_existence(file_name)

    maker_file = File.join($source_path, file_name)
    FileUtils.cp(maker_file, File.join($current_backup_folder, file_name))

    user_data = JSON.parse(File.read(maker_file))
    pack_data = JSON.parse(File.read(File.join($pack_path, file_name)))
    next unless user_data && pack_data

    updated_data = user_data.dup

    user_data['forms'].each do |form|
      matching_form = []
      pack_data['forms'].each { |pack_form| matching_form = pack_form if pack_form['form'] == form['form'] }
      $data_to_update.each { |data| form[data] = matching_form[data] } unless matching_form == []
    end

    save_json(file_name, updated_data)
    puts "Finished processing #{name} file!"
  end
end

def main
  prepare_choices
  prepare_folders
  update
end

main
