require_relative 'symboltable'
class Parser


  #Initialize the input file
  def initialize(input)
    @lines = File.readlines(input)
    @hack_file = File.open("Prog.hack", "w")
    @symbol_table = SymbolTable.new()
    @new_array = []
  end

  #TEST
  def translate_l_instruction(instruction)
    if command_type(instruction) == translate_l_instruction(instruction)
      instruction = instruction.gsub(/[()]/, "")
      @symbol_table.add_label(line, $.)
    else
      @new_array.push(line)
    end
  end

  #Create new array with clean lines
  def clean_up()
    @lines.delete_if { |line| line.strip.start_with?("//") || line.strip == ""}
    @new_array.each do |line|
      string = ""
      line.strip.split(//).each do |character|
        if character == "/"
          break
        else
          string += character
        end
      end
    end
  end

  #Assemble!
  def assemble()
    @lines.each do |instruction|
      puts command_type(instruction)
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
