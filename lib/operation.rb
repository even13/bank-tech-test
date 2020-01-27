class Operation

  attr_reader :amount, :balance, :date

  def initialize(amount, balance)
    @amount = amount
    @balance = balance
    @date = Time.now
  end

end
