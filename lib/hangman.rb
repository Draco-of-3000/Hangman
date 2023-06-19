puts "Hangman Hangman Hangmaaaanneee"



class Hangman
    attr_accessor :random_word, :number_of_guesses

    def initialize
        @random_word = random_word
        @number_of_guesses = number_of_guesses
    end

    def load_and_select_word_randomly
        contents = File.open('google-10000-english-no-swears.txt', 'r') do |file|
            file.each_line do |line|
                words = line.split(' ')
                words.select! { |word| word.length >= 5 && word.length <= 12}
                @random_word = words.sample
                break if @random_word
            end
        end
    
        puts @random_word
    end
end

hangman = Hangman.new
hangman.load_and_select_word_randomly

