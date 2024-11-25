# GameDataPacks
A repository to store all game Data Packs for use with Pokémon Studio

## Useful links

-   License:  [English](https://github.com/PokemonWorkshop/PokemonStudio/blob/develop/LICENSE.md)  -  [Français](https://github.com/PokemonWorkshop/PokemonStudio/blob/develop/LICENSE-FR.md)
-   [GitHub project](https://github.com/orgs/PokemonWorkshop/projects/2)
-   [Pokémon Studio Wiki](https://github.com/PokemonWorkshop/PokemonStudio/wiki)
-   [Pokémon Studio Figma](https://www.figma.com/file/xglOHHLb96zfPMTXd3v8i9/Pok%C3%A9mon-Studio)
-   [Discord server](https://discord.gg/0noB0gBDd91B8pMk)
-   [Dedicated discord channel](https://discord.com/channels/143824995867557888/701413380728029194)

## Important notice
If you plan on using, modifying or doing anything related to Pokémon Studio, you must read and comply to the [license](https://github.com/PokemonWorkshop/PokemonStudio/blob/develop/LICENSE.md).

## Structure of the repository
This repository is divided in 9 folders, each of them corresponding to a Pokémon generation, and is subdivided in as many folders as there are game versions in this generation.

Each version folder is structured as follows:

|           Folder | Description                                                                                  |
| ---------------: | :------------------------------------------------------------------------------------------- |
|          `audio` | Folder containing the files for Pokémon cries                                                |
|           `Data` | Folder containing the JSON and CSV files that constitute a Pokémon Studio project's database |
|       `graphics` | Folder containing the graphic resources for Pokémon and items                                |

The `Data` folder is divided in two folders:
- The `Text` folder regroups the CSV files that contain the names and descriptions of the database entries.
- The `Studio` folder is divided in 6 sub-folders with self-explanatory names. Each of these sub-folders regroups the related JSON files.

The `graphics` folder is divided in three folders:
- The `characters` folder contains the Pokémon overworld sprites.
- The `icons` folder contains the items sprites.
- The `pokedex` folder is divided in 7 sub-folders with self-explanatory names. Each of these sub-folders contain the Pokémon sprites for battle, PC and Pokédex entries.

Here is complete representation of a generation folder structure:
```
Generation
├── Version name
│   ├── audio
│   │   └── se
│   │       └── cries
│   ├── Data
│   │   ├── Studio
│   │   │   ├── abilites
│   │   │   ├── dex
│   │   │   ├── items
│   │   │   ├── moves
│   │   │   ├── pokemon
│   │   │   └── types
│   │   └── Text
│   │       └── Dialogs
│   └── graphics
│       ├── characters
│       ├── icons
│       └── pokedex
│           ├── footprints
│           ├── pokeback
│           ├── pokebackshiny
│           ├── pokefront
│           ├── pokefrontshiny
│           ├── pokeicon
│           └── pokeiconshiny
├── Other version name
└── ...
```
This structure replicates exactly a Pokémon Studio project's structure so that people can just download and copy an entire version folder's content directly into their project.

## How to contribute

### Setting up
First, download a copy of this repository on your computer if you have not already. Depending on the permissions you have, there are two options:
- If you have the necessary permissions (e.g. you have been given collaborator rights) you can directly clone the repository
- If you don't have the necessary permissions, you can fork the repository, it will create a separate "copy" for your own use, where you will have the rights to create branches, make commits, etc.

Once you have a local copy of the repository on your computer, you will have to set up a new Pokémon Studio project. While working directly on the JSON files is possible, it is much harder.
- Create a new Pokémon Studio project
- Go into your project's folder and open `Data/Studio`
- Delete the `abilities`, `dex`, `items`, `moves`, `pokemon` and `types` folders
- Go back to the root folder of your project and copy the `Data` folder of the generation you are working on (see next part) directly into it. Make sure to overwrite any duplicate files.
- You can now work on this generation's files 

### Adding information to the datapacks
If you want to contribute by adding missing information to the datapack, you must go look at the [GitHub project](https://github.com/orgs/PokemonWorkshop/projects/2) to see which tasks need to be done. Once you decided which task you would like to do, you can ask a contributor in the [psdk-database](https://discord.com/channels/143824995867557888/701413380728029194) channel on discord to assign it to you. You will need the Team Data role to access the channel.

Once you have taken responsibility a task, here are the steps you should follow:
- Checkout the `gen-packs` branch, this is the default branch where all changes are gathered.
- Create a new branch and name it after your task. Make sure all your modifications are done on that branch.
- Modify the project you created in accordance to your chosen task.
- Once you are done, commit your changes to your task's branch. Ensure you included all the files you need before pushing!
- Create a Pull request to the `gen-packs` branch of this repository (don't forget to link the task to your request).

Once the pull request is created, other contributors will verify it. They may comment and ask to correct anything they think is an error before finally merging your work.

### Reviewing changes made by peer contributors
If you want to contribute by reviewing you can:
- Look at the pending [pull requests](https://github.com/PokemonWorkshop/GameDataPacks/pulls) and add a comment if you see anything that you think might be an error.
- Check the [GitHub project](https://github.com/orgs/PokemonWorkshop/projects/2) and ask other contributors to be assigned on a reviewing task that needs to be done.

## Graphic resources credits

TODO

<details>
<summary>Click to expand</summary>

  ### Items
  <details>
  <summary>Collapse example</summary>
  </details>

  ### Pokémon sprites
  <details>
  <summary>Collapse example</summary>
  </details>

</details>
