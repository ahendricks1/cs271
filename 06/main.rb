load "assembler/parser.rb"
load "assembler/code.rb"
load "assembler/symboltable.rb"

parser = Parser.new(ARGV[0])
parser.clean_up()
