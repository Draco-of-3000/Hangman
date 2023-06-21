require 'yaml'

puts "Hangman Hangman Hangmaaaanneee"



class Hangman
    attr_accessor :random_word, :display, :updated_display, :wrong_guesses, :wrong_guess_count
    @@player_input = []

    def initialize
        @random_word = random_word
        @display = display
        @updated_display = updated_display
        @game_over = false 
        @wrong_guesses = []
        @wrong_guess_count = 0

        puts "Welcome To Hangman!"

        if File.exist?('hangman_save.txt')
            load_game_option = prompt_load_game_option

            if load_game_option == 'yes'
                load_game
            else
                start_new_game
            end
        else
            start_new_game
        end
    end

    def prompt_load_game_option
        puts "Do you want to load a saved game? Type 'yes' or 'no'"
        input = gets.chomp.downcase 

        until input == 'yes' || input == 'no'
            puts "Invalid input. Do you want to load a saved game? Type 'yes' or 'no'"
            input = gets.chomp.downcase
        end

        input
    end

    def load_and_select_word_randomly
        words = []

        File.open('google-10000-english-no-swears.txt', 'r') do |file|
            file.each_line do |line|
                words += line.split(' ')
            end
        end

        filtered_words = words.select! { |word| word.length >= 5 && word.length <= 12}
        @random_word = filtered_words.sample
    end

    def mask_random_word
        @display = @random_word.chars.map { |_| "_"}.join(" ")
        puts @display
    end

    def player_selection
        puts "Input a letter"
        input = gets.chomp.downcase
        until input.length == 1 && input.match?(/[a-z]/)
            puts "Invalid input. Please type a single letter"
            input = gets.chomp.downcase
        end
        @@player_input.push(input)
    end

    def query_save_game
        if @wrong_guess_count < 10 && @wrong_guess_count > 1
          puts "Do you want to save the game? Type 'yes' or 'no'"
          input = gets.chomp.downcase
      
          until input == "yes" || input == "no"
            puts "Invalid input. Do you want to save the game? Type 'yes' or 'no'"
            input = gets.chomp.downcase
          end
      
          if input == 'yes'
            save_game
          end
        end
    end
      

    def validate_player_selection
        num_guesses = @number_of_guesses
        guess_count = 0

        until @wrong_guess_count == 10 || @game_over
            player_selection
            query_save_game
            if @random_word.include?(@@player_input.last)
                unmask_word
            else
                puts "Letter mismatch, keep this up and you will be hanged"
                @wrong_guess_count += 1
                guess_count += 1
                display_wrong_guesses
                draw_hangman(guess_count)
            end
        end
    end

    def display_wrong_guesses
        @wrong_guesses.push(@@player_input.last)
        puts "Wrongly guessed letters: #{@wrong_guesses}"
    end

    def unmask_word
        @updated_display = @random_word.chars.map do |letter|
            if @@player_input.include?(letter)
                letter
            else
                "_"
            end
        end

        @display = updated_display.join(" ")
        puts @display

        declare_victory if updated_display.join == @random_word 
    end

    def declare_victory
        puts "Congratulations, you guessed the word right and outwitted the executioner!"
        @game_over = true
    end

    def draw_hangman(guess_count)
        case guess_count
        when 2
          puts "   ________"
          puts "   |      |"
          puts "   |"
          puts "   |"
          puts "   |"
          puts "   |"
          puts "___|___"
        when 4
          puts "   ________"
          puts "   |      |"
          puts "   |      O"
          puts "   |"
          puts "   |"
          puts "   |"
          puts "___|___"
        when 6
          puts "   ________"
          puts "   |      |"
          puts "   |      O"
          puts "   |     /|\\"
          puts "   |"
          puts "   |"
          puts "___|___"
        when 8
          puts "   ________"
          puts "   |      |"
          puts "   |      O"
          puts "   |     /|\\"
          puts "   |      |"
          puts "   |"
          puts "___|___"
        when 10
          puts "   ________"
          puts "   |      |"
          puts "   |      O"
          puts "   |     /|\\"
          puts "   |      |"
          puts "   |     / \\"
          puts "___|___"
          puts "You failed! You have been hanged by the executioner."
        end
    end

    def save_game
        save_data = {
            random_word: @random_word,
            display: @display,
            updated_display: @updated_display,
            wrong_guesses: @wrong_guesses,
            wrong_guess_count: @wrong_guess_count,
            player_input: @@player_input
        }

        File.open('hangman_save.txt', 'w') do |file|
            file.puts save_data.to_yaml
        end

        puts "Game saved successfully"
    end

    def load_game
        saved_data = YAML.load_file('hangman_save.txt')

        @random_word = saved_data[:random_word]
        @display = saved_data[:display]
        @updated_display = saved_data[:updated_display]
        @wrong_guesses = saved_data[:wrong_guesses]
        @wrong_guess_count = saved_data[:wrong_guess_count]
        @@player_input = saved_data[:player_input]

        puts "Game loaded successfully"

        continue_game
    rescue Errno::ENOENT
        puts "No saved game found"
    end

    def continue_game
        if @random_word.nil?
          load_and_select_word_randomly
          mask_random_word
        end
        @display = updated_display.join(" ")
        puts @display


        puts @wrong_guess_count
        display_wrong_guesses
        validate_player_selection
    end 
    
    def start_new_game
        load_and_select_word_randomly
        mask_random_word
        validate_player_selection
    end  
end

hangman = Hangman.new
