class SymbolTable

  currentSymbolAddress = 16
  @table = { "SP" => "0",
              "LCL" => "1",
              "ARG" => "2",
              "THIS" => "3",
              "THAT" => "4",
              "R0" => "0",
              "R1" => "1",
              "R2" => "2",
              "R3" => "3",
              "R4" => "4",
              "R5" => "5",
              "R6" => "6",
              "R7" => "7",
              "R8" => "8",
              "R9" => "9",
              "R10" => "10",
              "R11" => "11",
              "R12" => "12",
              "R13" => "13",
              "R14" => "14",
              "R15" => "15"
            }

  def addEntry(symbol, address)
    if table.contains(symbol)
      return @table[symbol]
    else
      table.store(symbol, currentSymbolAddress)
      currentSymbolAddress += 1
    end
  end

  def contains(symbol)
    return table.has_key?(symbol)
  end

  def getAddress(address)
    if table.has_value?(address)
      return @table[address]
    else
      puts "That address doesn't exist!"
    end
  end

end
