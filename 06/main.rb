require_relative 'assembler/parser'
require_relative 'assembler/symboltable'

parser = Parser.new(ARGV[0])
parser.first_pass
parser.assemble
