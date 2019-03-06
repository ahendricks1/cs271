require_relative 'symboltable'
require_relative 'code'

class Parser

  #Initialize the input file
  def initialize(asm_filename)
    @lines = File.readlines(asm_filename)
    @hack_file = File.open(hack_filename(asm_filename), "w")
    @symbol_table = SymbolTable.new()
  end

  def hack_filename(asm_filename)
    "TODO.hack"
  end

  #TEST
  def translate_l_instruction(instruction)
    exit("Should not be called yet.")
  end

  #Create new array with clean lines
  def clean_up()
    @lines.delete_if { |line| line.strip.start_with?("//") || line.strip == ""}
  end

  #Assemble!
  def assemble()
    @lines.each do |instruction|
      @hack_file << command_type(instruction) << "\n"
    end
  end

  #A or C instruction
  def command_type(instruction)
    if instruction[0] == "@"
      translate_a_instruction(instruction[1])
    elsif instruction.strip[0] == "("
      translate_l_instruction(instruction)
    else
      translate_c_instruction(instruction)
    end
  end

  def translate_a_instruction(instruction)
    clean_instruction = instruction.strip.split("@")
    if instruction.match(/^[\d]/)
      return ("%016b" % instruction)
    else
      @symbol_table.add_entry(instruction)
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
