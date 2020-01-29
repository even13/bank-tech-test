require 'account'

describe Account do
  let(:statement) { double :statement }
  let(:operation) { double :operation }
  subject(:account) { Account.new(operation) }

  describe "#deposit" do
    it "a client should be able to deposit money" do
      allow(operation).to receive(:entry).with(1000, 1000, :credit)
      account.deposit(1000)
      expect(account.balance).to eq 1000
    end
  end

  describe "#withdraw" do
    it "a client should be able to withdraw money" do
      allow(operation).to receive(:entry).with(1000, 1000, :credit)
      allow(operation).to receive(:entry).with(500, 500, :debit)
      account.deposit(1000)
      account.withdraw(500)
      expect(account.balance).to eq 500
    end

    it "a client cannot withdraw if it will make the balance negative" do
      expect { account.withdraw(200) }.to raise_error("Insufficient funds for this operation")
    end
  end

  describe "#statement" do
    it "a client cannot print their account statement without operations" do
      allow(operation).to receive(:log) { [] }
      expect { account.statement }.to raise_error("No operations to display yet")
    end
  end

end
