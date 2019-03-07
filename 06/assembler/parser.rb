require_relative 'symboltable'
require_relative 'code'

class Parser
  attr_accessor :lines

  #Initialize the input file
  def initialize(asm_filename)
    @lines = File.readlines(asm_filename)
    @hack_file = File.open(hack_filename(asm_filename), "w")
    @symbol_table = SymbolTable.new()
  end

  def hack_filename(asm_filename)
    asm_filename.split(".")[0] + ".hack"
  end

  #Handling labels, not quite right, needs review
  def handle_label(instruction)
    rom_location = 0
    @lines.each do |instruction|
      if instruction[0] != "("
        rom_location += 1
      else
        instruction
      end
    end
  end

  #Create new array with clean lines
  def clean_up()
    @lines.each { |line| line.delete!(' ') }
    @lines.delete_if { |line| line.start_with?("//") }
    @lines.each { | line| line.chomp! }
    @lines.delete_if { |line| line.empty? }
    @lines = @lines.map { |line| line.split("//")[0] }
  end

  #Assemble!
  def assemble()
    @lines.each do |instruction|
      @hack_file << command_type(instruction) << "\n"
    end
  end

  #A or C instruction
  def command_type(instruction)
    instruction = instruction.strip
    if instruction[0] == "@"
      translate_a_instruction(instruction)
    elsif instruction.strip[0] == "("
      handle_label(instruction)
    else
      translate_c_instruction(instruction)
    end
  end

  def translate_a_instruction(instruction)
    if instruction.strip.split("@")[1].to_i.to_s == instruction.strip.split("@")[1]
      return ("%016b" % instruction.strip.split("@")[1])
    else
      @symbol_table.add_entry(instruction.strip.split("@")[1])
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
