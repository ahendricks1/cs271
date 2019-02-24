class SymbolTable

  currentSymbolAddress = 16
  table = { "SP" => "0",
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

  currentSymbolAddress = 16

  def addEntry(symbol, address)
    table.contains(symbol) == false
      table.store(symbol, currentSymbolAddress)
      currentSymbolAddress += 1
    else
      address
    end

  def contains(symbol)
    table.has_key?(symbol)
  end

  def getAddress(symbol)
    if table.has_key?(symbol)
      table[symbol]
    else
      puts "That address doesn't exist!"
    end

end
