# PokeStar



## Authors
- **Simon BIHAIS**
- **Cécile TESSIER**

---

## Version
- **Flutter**: 83.0.2
- **Dart**: 241.18808

---

## Features

### Home Page
- **Pokémon List**: Displays the complete list of Pokémon.
- **Search**: A search bar to find a specific Pokémon by name or number.
- **Top Bar Navigation**:
  - **PokéStar** Logo: Redirects to the settings page.
  - **PokéStar** Text (on the right): Redirects to the favorites page.
  - **Pokédex** Text (on the left): Indicates the current page.

### Pokémon Details
- **Description**: Displays details about the Pokémon (name, type, etc.).
- **Evolutions**: View previous and next evolutions.
- **Stats**: Displays the Pokémon's stats.
- **Interactive Slider**: Navigate between "Description," "Evolutions," and "Stats" sections using a three-choice slider.
- **Side Navigation**: Arrows to move to the next or previous Pokémon.
- **Favorites**: Add or remove a Pokémon from favorites using a star icon at the top right.

### Favorites Page
- **Favorites List**: Displays Pokémon marked as favorites.
- **Top Bar**: Identical to the home page, with **PokéStar** selected.
- **Navigation**: Displays only favorited Pokémon, with options for searching and viewing details.

---

## API Used
- **PokeAPI**:

  - `https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json`:  
    Used to retrieve Pokémon images.

  - `https://pokeapi.co/api/v2/pokemon-species/`:  
    Provides detailed information about Pokémon species, including descriptions, habitats, and evolutions.

  - `https://pokeapi.co/api/v2/pokemon/`:  
    Used to fetch technical details about Pokémon, such as stats, types, and abilities.

  These APIs provide comprehensive data for displaying Pokémon, their characteristics, evolutions, and images.

---

## Application Screenshots

### Home Page
![Home Page Screenshot](assets/screenshots/Screenshot_20250114_223237.png "Home Page")

### Pokémon Details
![Pokémon Details Screenshot](assets/screenshots/Screenshot_20250114_223618.png "Pokémon Details")

### Favorites Page
![Favorites Page Screenshot](assets/screenshots/Screenshot_20250114_223444.png "Favorites Page")