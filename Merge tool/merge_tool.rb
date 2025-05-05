require 'json'
require 'fileutils'

settings = JSON.parse(File.read('settings.json'))
source_path = File.join(settings['source_path'].to_s, 'Data', 'Studio', 'pokemon')
pack_path = File.join("../Gen #{settings['generation_number']}", settings['version'].to_s, 'Data', 'Studio', 'pokemon')
pokemon_list = settings['pokemon_list'].map { |name| name.sub(/^:/, '').downcase }

backup_dir = 'backup'
output_dir = 'output'
Dir.glob(File.join(output_dir, '*')).each do |file|
  FileUtils.rm_rf(file) unless File.basename(file) == '.gitkeep'
end

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
    puts "#{pack_file} missing in the packs, please verify your settings file."
    return false
  end

  true
end

puts 'Starting merge process...'

pokemon_list.each do |name|
  file_name = "#{name}.json"
  maker_file = File.join(source_path, file_name)
  pack_file = File.join(pack_path, file_name)

  next unless check_files_existence(maker_file, pack_file)

  FileUtils.cp(maker_file, File.join(backup_dir, file_name))

  user_data = JSON.parse(File.read(maker_file))
  pack_data = JSON.parse(File.read(pack_file))
  next unless user_data && pack_data

  merged = user_data.dup
  pack_forms = pack_data['forms']

  merged['forms'].each do |form|
    matching_form_moveset = []
    pack_forms.each do |pack_form|
      matching_form_moveset = pack_form['moveSet'] if pack_form['form'] == form['form']
    end

    form['moveSet'] = matching_form_moveset if matching_form_moveset != []
  end

  save_json(File.join(output_dir, file_name), merged)
  puts "#{file_name} generated!"
end

puts 'Merge process finished!'
