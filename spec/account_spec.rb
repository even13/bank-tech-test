require 'account'

describe Account do

  subject(:account) { described_class.new }

  describe "#deposit" do
    it "a client should be able to deposit money" do
      account.deposit(1000)
      expect(account.balance).to eq 1000
    end
  end
end
