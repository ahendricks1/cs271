load "assembler/symboltable.rb"
class Parser

  @dest = {"D" => "010",
            "M" => "001",
            "A" => "100",
            "MD" => "011",
            "AM" => "101",
            "AD" => "110",
            "AMD" => "111",
            "null" => "000"}

  @comp = {  "0" => "101010",
              "1" => "111111",
              "-1" => "111010",
              "D" => "001100",
              "A" => "110000",
              "!D" => "001101",
              "!A" => "110001",
              "-D" => "001111",
              "-A" => "110011",
              "D+1" => "011111",
              "A+1" => "110111",
              "D-1" => "001110",
              "A-1" => "110010",
              "D+A" => "000010",
              "D-A" => "010011",
              "A-D" => "000111",
              "D&A" => "000000",
              "D|A" => "010101",
              "M" => "110000",
              "!M" => "110001",
              "-M" => "110011",
              "M+1" => "110111",
              "M-1" => "110010",
              "D+M" => "000010",
              "D-M" => "010011",
              "M-D" => "000111",
              "D&M" => "000000",
              "D|M" => "010101"}

  @jump = { "JGT" => "001",
              "JEQ" => "010",
              "JGE" => "011",
              "JLT" => "100",
              "JNE" => "101",
              "JLE" => "110",
              "JMP" => "111"
              }

  #Initialize the input file
  def initialize(input)
    @input_file = File.open(input)
    @symbol_table = SymbolTable.new()
  end

  #Create new array with clean lines
  def clean_up()
    @lines = @input_file.readlines
    @lines.each do |line|
      line.strip!
    end
    @lines.delete_if do |line|
      line.start_with?("/") || line == ""
      main_computation(line)
    end
  end

  def main_computation(line)
    command_type(line)
  end

  #A or C instruction
  def command_type(instruction)
    if instruction.strip[0] == "@"
      translate_a_instruction(instruction)
    else
      translate_c_instruction(instruction)
    end
  end

  def translate_a_instruction(instruction)
    clean_instruction = instruction.strip.split("@")
    if clean_instruction.split("@")[1].to_i.to_s == clean_instruction.split("@")[1]
      return ("%015b" % instruction)
    else
      @symbol_table.add_entry(instruction)
    end
  end

  def translate_c_instruction(instruction)
    if instruction.include?(";")
      instruction.split(";")
      return ("111" + comp(instruction[1]) + dest(instruction[0]) + jump(instruction[2]))
    else
      instruction.split("=")
      return ("111" + comp(instruction[1]) + dest(instruction[0]) + "000")
    end
  end

  #Returns symbol or value
  def symbol()
    return
  end

  #Returns the mnemonics value
  def dest(mnemonic)
    return @dest.fetch(mnemonic)
  end

  def comp(mnemonic)
     return @comp.fetch(mnemonic)
  end

  def jump(mnemonic)
    return @jump.fetch(mnemonic)
  end
end
