class SymbolTable

  TABLE = { "SP" => "0",
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
              "R15" => "15",
            "SCREEN" => "16384",
              "KBD" => "24576"

            }

  def initialize()
    @currentSymbol = 16
  end

  def add_entry(symbol)
    if TABLE.has_key?(symbol)
      return ("%016b" % TABLE[symbol])
    else
      TABLE[symbol] = @currentSymbol
      @currentSymbol += 1
      return ("%016b" % TABLE[symbol])
    end
  end

  def add_label(symbol, address)
    TABLE[symbol] = address
    return ("%016b" % TABLE[symbol])
  end

  def get_table()
    return TABLE
  end

  def get_address(symbol)
    return TABLE[symbol]
  end

end
