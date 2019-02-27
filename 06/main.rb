load "assembler/parser.rb"

assembler =Parser.new(ARGV[0])
assembler.clean_up()
