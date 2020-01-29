require_relative 'operation'
require_relative 'statement'

class Account

  def initialize(operation = Operation.new, statement = Statement.new)
    @balance = 0
    @operation = operation
    @statement = statement
  end

  def deposit(amount)
    @balance += amount
    @operation.entry(amount, @balance, :credit)
    @balance
  end

  def withdraw(amount)
    raise("Insufficient funds for this operation") unless @balance - amount >= 0

    @balance -= amount
    @operation.entry(amount, @balance, :debit)
    @balance
  end

  def statement
    puts @statement.print_statement(history)
  end

  private
  attr_reader :balance

  def history
    @operation.log
  end
end
