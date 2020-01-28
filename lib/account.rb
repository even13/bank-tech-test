class Account
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance - amount >= 0 ? @balance -= amount : raise("Insufficient funds for this operation")
  end
end
