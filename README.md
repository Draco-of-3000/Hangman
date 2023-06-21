# Hangman
Welcome to the Hangman game! This is a text-based implementation of the classic Hangman game, where players guess letters to uncover a hidden word. This program allows you to enjoy the game while incorporating essential Object-Oriented Programming (OOP) principles. Additionally, you can save your game progress and load it later for continuous enjoyment.

**Features**
- **Visual representation of stick figure:** Players are allowed to make up to 10 mistakes before losing the game. After every two mistakes, a part of the stick figure is drawn, adding a level of suspense to the gameplay.

- **Object-Oriented Programming (OOP):** This program is built using OOP principles, which enhance code organization, reusability, and maintainability. The game logic is divided into appropriate methods, making it easy to understand and extend.

- **Save and Load Game:** Players have the option to save the game and load it later to continue playing from where they left off. When saving, the game state (including the hidden word, masked word, wrong guesses, etc.) is serialized into a YAML file (hangman_save.txt). The serialized data is then loaded back into the game to restore the saved state when the player chooses to load the game. The game state is saved in a structured format using the YAML format, allowing for easy human-readable representation and deserialization.
  
- Randomly selects a word from a dictionary of words with a length between 5 and 12 characters.

- Displays the hidden word as underscores and reveals correct guesses.
  
- Allows players to save the game and continue later.

**Requirements**
- To run the Hangman game, you need to have ruby installed on your machine

**Getting started**
- Clone the repository to your local machine:
  - $ git clone https://github.com/your-username/hangman.git

- Navigate to the project directory:
  - $ cd hangman

- Run the game:
  - $ ruby lib/hangman.rb
 - The game will start, and you can begin playing by following the on-screen instructions.

**Usage**
- The game will prompt you to enter a letter upon start
- If the letter is part of the hidden word, it will be revealed in the word's display. Otherwise, the game will display a message indicating a wrong guess.
- The game continues until you guess the word correctly, make 10 wrong guesses, or choose to save the game and exit.
- If you choose to save the game, it will be saved to a file named hangman_save.txt. You can load the saved game when starting the Hangman game again.
- The game also includes a hangman drawing that progressively appears with each two wrong guesses.

**Acknowledgements**
- The dictionary of words used in the game is sourced from the Google 10000 English repository.
- The Hangman game is a classic and well-known game. This implementation is inspired by its traditional rules and gameplay. This implementation in Ruby is created by Kelvin Acheampong.

**Enjoy the game and have fun playing Hangman!**
