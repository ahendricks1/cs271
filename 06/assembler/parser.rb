require_relative 'symboltable'
class Parser

  DEST = {"D" => "010",
            "M" => "001",
            "A" => "100",
            "MD" => "011",
            "AM" => "101",
            "AD" => "110",
            "AMD" => "111",
            "null" => "000"}

  COMP = {  "0" => "0101010",
              "1" => "0111111",
              "-1" => "0111010",
              "D" => "0001100",
              "A" => "0110000",
              "!D" => "0001101",
              "!A" => "0110001",
              "-D" => "0001111",
              "-A" => "0110011",
              "D+1" => "0011111",
              "A+1" => "0110111",
              "D-1" => "0001110",
              "A-1" => "0110010",
              "D+A" => "0000010",
              "D-A" => "0010011",
              "A-D" => "0000111",
              "D&A" => "0000000",
              "D|A" => "0010101",
              "M" => "1110000",
              "!M" => "1110001",
              "-M" => "1110011",
              "M+1" => "1110111",
              "M-1" => "1110010",
              "D+M" => "1000010",
              "D-M" => "1010011",
              "M-D" => "1000111",
              "D&M" => "1000000",
              "D|M" => "1010101"}

  JUMP = { "JGT" => "001",
              "JEQ" => "010",
              "JGE" => "011",
              "JLT" => "100",
              "JNE" => "101",
              "JLE" => "110",
              "JMP" => "111"
              }

  #Initialize the input file
  def initialize(input)
    @lines = File.readlines(input)
    @symbol_table = SymbolTable.new()
    @the_array = []
  end

  #TEST
  def translate_l_instruction(instruction)
    @lines.each do |line|
      if command_type(line) == translate_l_instruction(line)
        line = line.gsub(/[()]/, "")
        @symbol_table.add_label(line, $.)
      else
        @the_array.push(line)
      end
    end
  end

  #Create new array with clean lines
  def clean_up()
    @the_array.each do |line|
      string = ""
      line.strip.split(//).each do |character|
        if character == "/"
          break
        else
          string += character
        end
      end
    end
    @lines.delete_if { |line| line.strip.start_with?("//") || line.strip == ""}
  end

  #Assemble!
  def assemble()
    @lines.each do |instruction|
      command_type(instruction)
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
    if DEST.has_key?(mnemonic)
      return DEST[mnemonic]
    else
      return "000"
    end
  end

  def comp(mnemonic)
    if COMP.has_key?(mnemonic)
      return COMP[mnemonic]
    else
      return "0000000"
    end
  end

  def jump(mnemonic)
    if JUMP.has_key?(mnemonic)
      return JUMP[mnemonic]
    else
      return "000"
    end
  end
end
