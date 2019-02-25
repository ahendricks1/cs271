class Parser

  @@DEST = {"D" => "010",
            "M" => "001",
            "A" => "100",
            "MD" => "011",
            "AM" => "101",
            "AD" => "110",
            "AMD" => "111",
            "null" => "000"
          }

  @@COMP = {  "0" => "101010",
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
              "D|M" => "010101"
            }

  @@JUMP = { "JGT" => "001",
              "JEQ" => "010",
              "JGE" => "011",
              "JLT" => "100",
              "JNE" => "101",
              "JLE" => "110",
              "JMP" => "111",
              "null" => "000"
            }

  #Initialize the input file
  def initialize(input)
    @input_file = File.open(input)
  end

  #Parse file; Create new array, split our input file up and check for / or (
  def parse()
    @input_file.each do |line|
      new_line = ""
      line.split(//).each do |x|
        if x == "/" || x == "("
          break
        else
          new_line += x
        end
      end
      next if new_line.strip.empty?
      puts new_line
      if commandType(new_line) == "C_CMD"
        command = new_line.strip.split("=")
        puts "111".to_i + comp(command[1]) + dest(command[0]) + jump(command[2])
      else
        puts new_line.split("@")[1].to_i.to_s(2).rjust(16, "0")
      end
    end
  end

  #Command type
  def commandType(line)
    if line.strip[0] == "@"
      "A_CMD"
    else
      "C_CMD"
    end
  end

  #C-instruction
  def dest(input)
    @@DEST[input]
  end

  def comp(input)
    @@COMP[input]
  end

  def jump(input)
    if input.has_key?(input)
      @@JUMP[input]
    else
      "000"
    end
  end
end
