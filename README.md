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

If you want to get a pack's data for your project, here are the steps to do it:
- Download the ZIP file of the repository and extract it on your computer
- Open the generation and version folder you want to set your project's data to, you should see three folders named `audio`, `Data` and `graphics`
- In another window open your project's folder
- Drag and drop the three folders from the datapack directly into your project's folder, when prompted about it, answer 'replace all' to override all existing files
- OPTIONAL: If want to clean up unused files, you can open the graphics folder and delete old Pokémon sprites that are named on 3 digits (e.g. 001.png), some dex files might not be of use to you either so you can clean up there too

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

<details>
<summary>Click to expand</summary>

## Original resource pack links
- [Eevee Expo](https://eeveeexpo.com/resources/1101/)
- [Pokecommunity (Mirror)](https://www.pokecommunity.com/threads/generation-9-resource-pack-v21-1.527398/)
  
## Pokemon Battler Sprites:
- Gen 1-5 Pokemon Sprites - veekun
- Gen 6 Pokemon Sprites - All Contributors To Smogon X/Y Sprite Project
- Gen 7 Pokemon Sprites - All Contributors To Smogon Sun/Moon Sprite Project
- Gen 8 Pokemon Sprites - All Contributors To Smogon Sword/Shield Sprite Project
- PLA Pokemon Sprites - Smogon Sprite Project
Blaquaza, KingOfThe-X-Roads, KattenK, Travis, G.E.Z., SpheX, Hematite, SelenaArmorclaw
- Gen 9 Pokemon Sprites - KingOfThe-X-Roads, Mak, Caruban, jinxed, leParagon, Sopita_Yorita, Azria, Mashirosakura,
JordanosArt, Abnayami, OldSoulja, Katten, Divaruta 666, Clara, Skyflyer, AshnixsLaw, ace_stryfe

## Pokemon Icon Sprites:
- Gen 1-6 Pokemon Icon Sprites - Alaguesia, harveydentmd
- Gen 7 Pokemon Icon Sprites - Marin, MapleBranchWing, Contributors to the DS Styled Gen 7+ Repository
- Gen 8 Icon Sprites - Larry Turbo, Leparagon
- Shiny Icon Sprites - StarrWolf, Pokemon Shattered Light Team
- PLA Pokemon Icon Sprites - LuigiTKO
- Gen 9 Icon Sprites - ezerart, JordanosArt

## Pokemon Gen 9 Overworld sprites:
- Gen 1-5 Pokemon Overworlds - MissingLukey, help-14, Kymoyonian, cSc-A7X, 2and2makes5, Pokegirl4ever, Fernandojl, Silver-Skies, TyranitarDark, Getsuei-H, Kid1513, Milomilotic11, Kyt666, kdiamo11, Chocosrawlooid, Syledude, Gallanty, Gizamimi-Pichu, 2and2makes5, Zyon17,LarryTurbo, spritesstealer, LarryTurbo
- Gen 6 Pokemon Overworlds - princess-pheonix, LunarDusk, Wolfang62, TintjeMadelintje101, piphybuilder88
- Gen 7 Pokemon Overworlds - Larry Turbo, princess-pheonix
- Gen 8 Pokemon Overworlds - SageDeoxys, Wolfang62, LarryTurbo, tammyclaydon
- PLA Pokemon Overworlds - Boonzeet, DarkusShadow, princess-phoenix, Ezeart, WolfPP
- Gen 9 Pokemon Overworlds - Azria, DarkusShadow, EduarPokeN, Carmanekko, StarWolff, Caruban

## Pokemon Cries:
- Gen 1-6 Pokemon Cries - Rhyden
- Gen 7 Pokemon Cries - Marin, Rhyden
- Gen 8 Pokemon Cries - Zeak6464
- PLA Pokemon Cries - Morningdew
- Gen 9 Pokemon Cries -
Edited from Lightblade Absol's Gen 9 Cries compilation video
Edited from HeroLinik's Pokemon Scarlet and Violet - Walking Wake and Iron Leaves Cries video
Edited from HeroLinik's Pokemon Scarlet and Violet - All Teal Mask Cries video

## Item sprites:
- Gen 9 item sprites - lichenprincess, Caruban, jinxed
- PLA item sprites - AztecCroc, 3DJackArt, Caruban, lichenprincess

## Compilation of Resources:
- Gen 9 Pack - Caruban
- Gen 8/9 Resized Sprites - http404error
- Gen 8 Pack - Golisopod User, UberDunsparce
- Resource renaming, sprites alignement and sprites resizing for Pokémon Studio - Aelysya

</details>
