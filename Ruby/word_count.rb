file = File.new("test2.txt", "r")
wordBuff = String.new 
wordList = {}
wordCount = 0
firstLetter = true

if file 
    file.each_byte {
        |ch|        # byte character

        # Pull out the words from the file
        if firstLetter && ((ch >= 'a'.ord && ch <= 'z'.ord) || 
            (ch >= 'A'.ord && ch <= 'Z'.ord))
            wordBuff << ch
            firstLetter = false
        elsif (ch >= 'a'.ord && ch <= 'z'.ord) || 
            (ch >= 'A'.ord && ch <= 'Z'.ord) || 
            (ch >= '0'.ord && ch <= '9'.ord) || 
            ch == '_'.ord || ch == '-'.ord
            wordBuff << ch
        else 
            if wordList[wordBuff]
                wordList[wordBuff] += 1
            else
                wordCount = wordCount + 1
                wordList[wordBuff] = 1
            end

            wordBuff = String.new 
            firstLetter = true
        end

        #When the next character is blank or a newline then end the word
        # if ch == ' '.ord || ch == "\n".ord
        #     if wordList[wordBuff]
        #         wordList[wordBuff] += 1
        #     else
        #         wordCount = wordCount + 1
        #         wordList[wordBuff] = 1
        #     end

        #     wordBuff = String.new 
        #     firstLetter = true
        # end
    }
else 
    puts "Unable to open"
end

# sort the word list
wordList = Hash[ wordList.sort_by { |key, val| key } ]

# print the word count and the word list 
puts "Word Count: " + wordCount.to_s
puts
wordList.each do |key, value|
    printf("Word: %-40s Freq: %d\n", key, value)
end