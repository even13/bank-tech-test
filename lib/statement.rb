require_relative 'operation'

class Statement

  def initialize(operations = Operation.new)
    @operations = operations
  end

  def print_statement(history = @operations.log)
    raise("No operations to display yet") unless history[0]

    statement = history.reverse.map do |operation|
      operation.join(' || ')
    end
    (header + statement.join("\n")).gsub("||  ||", "|| ||")
  end

  private

  def header
    "date || credit || debit || balance\n"
  end

end
