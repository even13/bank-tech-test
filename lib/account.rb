require_relative 'operation'
require_relative 'statement'

class Account
  attr_reader :balance

  def initialize(statement = Statement.new)
    @balance = 0
    @statement = statement
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance - amount >= 0 ? @balance -= amount : raise("Insufficient funds for this operation")
  end
end
