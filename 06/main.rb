load "assembler/parser.rb"

parser = Parser.new(ARGV[0])
parser.parse()
