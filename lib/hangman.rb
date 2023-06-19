puts "Hangman Hangman Hangmaaaanneee"



class Hangman
    attr_accessor :random_word, :number_of_guesses
    @@player_input = []

    def initialize
        @random_word = random_word
        @number_of_guesses = number_of_guesses
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
        display = @random_word.chars.map { |_| "_"}.join(" ")
        puts display
    end

    def assign_guess_limit
        @number_of_guesses = @random_word.length
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

end

hangman = Hangman.new
hangman.load_and_select_word_randomly
hangman.mask_random_word
hangman.player_selection

