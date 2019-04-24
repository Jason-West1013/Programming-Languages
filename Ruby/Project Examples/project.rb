$filename = "test3.txt"

document = Array.new
fileObj = File.new($filename, "r")

while(line = fileObj.gets)
    document.push(line)
end

puts "Total lines: #{document.length}" 

fileObj.close 