require_relative 'symboltable'
require_relative 'code'

class Parser
  attr_accessor :lines

  #Initialize the input file
  def initialize(asm_filename)
    @lines = File.readlines(asm_filename)
    @hack_file = File.open(hack_filename(asm_filename), "w")
    @symbol_table = SymbolTable.new()
    @rom_location = 0
  end

  def hack_filename(asm_filename)
    asm_filename.split(".")[0] + ".hack"
  end

  def first_pass()
    clean_up
    @lines.each do |instruction|
      handle_label(instruction)
    end
    puts SymbolTable::TABLE
  end

  #Label handling
  def handle_label(instruction)
      if instruction[0] == "("
        clean_label = instruction.strip.gsub(/[()]/, "")
        @symbol_table.add_label(clean_label, @rom_location)
      else
        @rom_location += 1
      end
  end

  #Assemble!
  def assemble()
    @lines.delete_if { |line| line.start_with?("(") }
    @lines.each do |instruction|
      @hack_file << command_type(instruction) << "\n"
    end
    puts SymbolTable::TABLE
  end

  #Create new array with clean lines
  def clean_up()
    @lines.each { |line| line.delete!(' ') }
    @lines.delete_if { |line| line.start_with?("//") }
    @lines.each { | line| line.chomp! }
    @lines.delete_if { |line| line.empty? }
    @lines = @lines.map { |line| line.split("//")[0] }
  end

  #A or C instruction
  def command_type(instruction)
    instruction = instruction.strip
    if instruction[0] == "@"
      translate_a_instruction(instruction)
    else
      translate_c_instruction(instruction)
    end
  end

  def translate_a_instruction(instruction)
    if instruction.strip.split("@")[1].to_i.to_s == instruction.strip.split("@")[1]
      return ("%016b" % instruction.strip.split("@")[1])
    else
      return @symbol_table.add_entry(instruction.strip.split("@")[1])
    end
  end

  def translate_c_instruction(instruction)
    if instruction.strip.include?(";")
      pieces = instruction.strip.split(";")
      return ("111" + comp(pieces[0]) + "000" + jump(pieces[1]))
    else
      pieces = instruction.strip.split("=")
      return ("111" + comp(pieces[1]) + dest(pieces[0]) + "000")
    end
  end

  #Returns the mnemonics value
  def dest(mnemonic)
    if Code::DEST.has_key?(mnemonic)
      return Code::DEST[mnemonic]
    else
      return "000"
    end
  end

  def comp(mnemonic)
    if Code::COMP.has_key?(mnemonic)
      return Code::COMP[mnemonic]
    else
      return "0000000"
    end
  end

  def jump(mnemonic)
    if Code::JUMP.has_key?(mnemonic)
      return Code::JUMP[mnemonic]
    else
      return "000"
    end
  end
end
