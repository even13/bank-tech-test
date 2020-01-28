require_relative 'operation'

class Statement
  attr_reader :record

  def initialize(operations = Operation.new)
    @operations = operations
  end

  def header
    "date || credit || debit || balance\n"
  end

  def print_statement
    statement = @operations.log.map do |operation|
      operation.join(' || ')
    end
    (header + statement.join("\n")).gsub("||  ||", "|| ||")
  end
end
