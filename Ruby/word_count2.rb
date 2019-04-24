# WCF and WFF in Ruby
# Uses a hash (dictionary) to store the frequency table and 
# regular expressions to filter out words from the file. 

# Open file and set global variables 
file = File.new("test2.txt", "r")
wordList = {}
wordCount = 0

# scan through each line of the file 
if file 
    file.each_line {
        |line|
        words = line.split(/[^a-zA-Z0-9_-]/)        # split each line at a non-accepted character
        for word in words
            if word =~ /^[^0-9_-][a-zA-Z0-9_-]/     # check words format using regular expression
                wordCount = wordCount + 1
                if wordList[word]                   # check if word is in the word hash, if so increment frequency
                    wordList[word] += 1
                else 
                    wordList[word] = 1
                end
            end
        end
    }
else
    puts "Unable to open."
end

# sort hash alphabetically by key (word)
wordList = Hash[ wordList.sort_by { |key, val| key } ]

# print the word count and frequency table
puts "Word Count: " + wordCount.to_s
puts
wordList.each do |key, value|
    printf("Word: %-40s Freq: %d\n", key, value)
end
