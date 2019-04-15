require 'ripper'
require 'pp'

inputStream = "x > 5 ? 'yes' : 'no'"

puts RubyVM::InstructionSequence.compile("x > 100 ? 'foo' : 'bar'").disassemble