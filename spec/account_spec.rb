require 'account'

describe Account do

  subject(:account) { described_class.new }

  describe "#deposit" do
    it "a client should be able to deposit money" do
      account.deposit(1000)
      expect(account.balance).to eq 1000
    end
  end

  describe "#withdraw" do
    it "a client should be able to withdraw money" do
      account.deposit(1000)
      account.withdraw(500)
      expect(account.balance). to eq 500
    end

  end
end
