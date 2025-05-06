require 'json'
require 'fileutils'

def save_json(path, data)
  json = JSON.pretty_generate(data)
  json.gsub!(/\[\s+\]/, '[]')

  File.write(path, json)
end

def check_files_existence(maker_file, pack_file)
  unless File.exist?(maker_file)
    puts "#{maker_file} missing in your project, please verify your settings file."
    return false
  end

  unless File.exist?(pack_file)
    puts "#{pack_file} missing in the chosen version, please verify your settings file and that the Pokémon exists in this version."
    return false
  end

  true
end

def ask_choice
  choice = 0

  until [1, 2].include?(choice.to_i)
    puts 'Choose a mode:'
    puts '1 - Merge Pokémon movepools'
    puts '2 - Merge everything'
    print 'Enter your choice: '
    choice = gets.chomp
  end

  choice.to_i
end

def merge_movepools(pokemon_list, source_path, pack_path)
  pokemon_list.each do |name|
    file_name = "#{name}.json"
    maker_file = File.join(source_path, file_name)
    pack_file = File.join(pack_path, file_name)
    next unless check_files_existence(maker_file, pack_file)

    FileUtils.cp(maker_file, File.join('backup', file_name))

    user_data = JSON.parse(File.read(maker_file))
    pack_data = JSON.parse(File.read(pack_file))
    next unless user_data && pack_data

    merged_data = user_data.dup

    merged_data['forms'].each do |form|
      matching_form = []
      pack_data['forms'].each do |pack_form|
        matching_form = pack_form['moveSet'] if pack_form['form'] == form['form']
      end

      form['moveSet'] = matching_form if matching_form != []
    end

    save_json(File.join('output', file_name), merged_data)
    puts "#{file_name} generated!"
  end
end

def merge_forms(pokemon_list, source_path, pack_path)
  pokemon_list.each do |name|
    file_name = "#{name}.json"
    maker_file = File.join(source_path, file_name)
    pack_file = File.join(pack_path, file_name)
    next unless check_files_existence(maker_file, pack_file)

    FileUtils.cp(maker_file, File.join('backup', file_name))

    user_data = JSON.parse(File.read(maker_file))
    pack_data = JSON.parse(File.read(pack_file))
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

    save_json(File.join('output', file_name), merged_data)
    puts "#{file_name} generated!"
  end
end

def main
  settings = JSON.parse(File.read('settings.json'))
  source_path = File.join(settings['source_path'].to_s, 'Data', 'Studio', 'pokemon')
  pack_path = File.join("../Gen #{settings['generation_number']}", settings['version'].to_s, 'Data', 'Studio', 'pokemon')
  pokemon_list = settings['pokemon_list'].map { |name| name.sub(/^:/, '').downcase }

  Dir.glob(File.join('output', '*')).each do |file|
    FileUtils.rm_rf(file) unless File.basename(file) == '.gitkeep'
  end

  case ask_choice
  when 1
    puts 'Merging movepools...'
    merge_movepools(pokemon_list, source_path, pack_path)
    puts 'Merging movepools process finished!'
  when 2
    puts 'Merging forms...'
    merge_forms(pokemon_list, source_path, pack_path)
    puts 'Merging forms process finished!'
  else
    puts 'This should not happen, exiting.'
    exit
  end
end

main
