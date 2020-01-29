require_relative 'operation'
require_relative 'statement'

class Account
  attr_reader :balance

  def initialize(operation = Operation.new)
    @balance = 0
    @operation = operation
  end

  def deposit(amount)
    @balance += amount
    @operation.entry(amount, @balance, :credit)
    @balance
  end

  def withdraw(amount)
    @balance - amount >= 0 ? @balance -= amount : raise("Insufficient funds for this operation")
    @operation.entry(amount, @balance, :debit)
    @balance
  end
end
