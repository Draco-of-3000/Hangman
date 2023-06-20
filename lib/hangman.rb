puts "Hangman Hangman Hangmaaaanneee"



class Hangman
    attr_accessor :random_word, :number_of_guesses, :display, :updated_display
    @@player_input = []

    def initialize
        @random_word = random_word
        @number_of_guesses = number_of_guesses
        @display = display
        @updated_display = updated_display
        @game_over = false 
        @wrong_guesses = []
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
        puts @random_word
    end

    def mask_random_word
        @display = @random_word.chars.map { |_| "_"}.join(" ")
        puts @display
    end

    def assign_guess_limit
        @number_of_guesses = @random_word.length * 2
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

    def validate_player_selection
        num_guesses = 14
        until @number_of_guesses == 0 || @game_over
            player_selection
            if @random_word.include?(@@player_input.last)
                unmask_word
            else
                puts "Letter mismatch, keep this up and you will be hanged"
                display_wrong_guesses
            end
            @number_of_guesses -= 1
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

    def draw_hangman(num_guesses)
        case num_guesses
        when 14, 12
          puts "   ________"
          puts "   |      |"
          puts "   |"
          puts "   |"
          puts "   |"
          puts "   |"
          puts "___|___"
        when 10, 8
          puts "   ________"
          puts "   |      |"
          puts "   |      O"
          puts "   |"
          puts "   |"
          puts "   |"
          puts "___|___"
        when 6, 4
          puts "   ________"
          puts "   |      |"
          puts "   |      O"
          puts "   |     /|\\"
          puts "   |"
          puts "   |"
          puts "___|___"
        when 2
          puts "   ________"
          puts "   |      |"
          puts "   |      O"
          puts "   |     /|\\"
          puts "   |      |"
          puts "   |"
          puts "___|___"
        when 0
          puts "   ________"
          puts "   |      |"
          puts "   |      O"
          puts "   |     /|\\"
          puts "   |      |"
          puts "   |     / \\"
          puts "___|___"
          puts "You lost! The hangman is fully drawn."
        end
    end
      
end

hangman = Hangman.new
hangman.load_and_select_word_randomly
hangman.assign_guess_limit
hangman.mask_random_word
hangman.validate_player_selection
