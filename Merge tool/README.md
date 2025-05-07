# Datapack Merge Tool

This small ruby program allows you to cherry-pick data from a pack and a version of your choice to update your existing files without having to do some potentially dangerous file manipulation. For now it only allows to update the moveset of Pokémon, but later it will come with an interactive part and more options.

## How to set up the tool

In the folder, you will find a file named `settings.json`, open it with a text editor.
It is composed of the following fields:
- `source_path`: Put here the absolute path to your Pokémon Studio project. It should point to where the `project.studio` file is.
- `generation_number`: Set here the generation you want to copy data from.
- `version`: Set here the version you want to copy data from.
- `pokemon_list`: Set here the list of DbSymbols of Pokémon you want to update. Some Pokémon names contains special characters, like Type:null or Farfetch'd, in these case the special character is replaced by an underscore '_'. In doubt, you can copy the DbSymbol of a Pokémon directly from Studio, there is an icon for that next to the Pokémon's name. You can leave the column ':' at the start, the program will ignore it.

## How to use the tool

You need Ruby installed on your computer to make the program work, if you don't have it you can get it [here](https://rubyinstaller.org/).
By double-clicking on the `launch.bat` file, you will start the program. Once the process is finished, you can open the folders `backup` and `output`.
The `output` folder will contain a new set of files that have been updated with the data from the packs, these are the ones you will want to copy in your project. Each time you lauch the tool, this folder will be emptied, don't leave anything you don't want to lose here.
The `backup` folder will contain your files as they were before you launched the program, this is in case you tested the generated files and for any reason wanted to go back.

The program will only affect forms that exist on both your side and the packs' side. Meaning if a form of a Pokémon is present in one side but not the other, it will be ignored.

### Credits

Developer:
- Aelysya

Testers:
- Flo
- Atlas