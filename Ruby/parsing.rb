require 'ripper'
require 'pp'

inputStream = "x > 5 ? 'yes' : 'no'"

pp Ripper.tokenize(inputStream)
