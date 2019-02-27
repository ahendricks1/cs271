class Code

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

  def translate(instruction)
    if instruction.start_with?("@")
      translate_a_instruction(instruction)
    else
      translate_c_instruction(instruction)
    end
  end

  def translate_a_instruction(instruction)
    clean_instruction = instruction.split("@")
    return ("%015b" % instruction)
  end

  def translate_c_instruction(instruction)
    if instruction.include?(";")
      instruction.delete("=", ";")
      return "111" + @comp(clean_instruction[1]) + @dest(clean_instruction[0]) + @jump(clean_instruction[2])
    else
      instruction.split("=")
      return "111" + @comp(clean_instruction[1]) + @dest(clean_instruction[0]) + "000"
    end
  end
