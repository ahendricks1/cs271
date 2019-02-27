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

  #%015b % number
  #Initialize the input file
  def initialize(input)
    @input_file = File.open(input)
  end

  #Create new array with clean lines
  def clean_up()
    @lines = @input_file.readlines
    @lines.each do |line|
      line.strip!
    end
    @lines.delete_if do |line|
      line.start_with?("/") || line == ""
    end
  end

  #Choosing A or C instruction
  def commandType(line)
    if line.strip[0] == "@"
      "A_CMD"
    else
      "C_CMD"
    end
  end

  #Returns symbol or value
  def symbol()
    return
  end

  #Returns the destination mnemonic
  def dest(mnemonic)
    return @dest[mnemonic]
  end

  #Returns the computation mnemonic
  def comp(mnemonic)
    return @comp[mnemonic]
  end

  #Returns the jump mnemonic
  def jump(mnemonic)
    return @jump[mnemonic]
end
