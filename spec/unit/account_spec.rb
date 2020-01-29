require 'account'
require 'timecop'

describe Account do
  let(:statement) { double :statement }
  let(:operation) { double :operation }
  subject(:account) { Account.new(operation) }

  describe "#deposit" do
    it "a client should be able to deposit money" do
      allow(operation).to receive(:log) { [[Time.now.strftime("%d/%m/%Y"), "1000.00", '', "1000.00"]] }
      allow(operation).to receive(:entry).with(1000, 1000, :credit)
      account.deposit(1000)
      expect { account.statement }.to output("date || credit || debit || balance\n#{Time.now.strftime("%d/%m/%Y")} || 1000.00 || || 1000.00\n").to_stdout
    end
  end

  describe "#withdraw" do
    it "a client should be able to withdraw money" do
      Timecop.freeze do
        allow(operation).to receive(:log) { [[Time.now.strftime("%d/%m/%Y"), "1000.00", '', "1000.00"], [Time.now.strftime("%d/%m/%Y"), '', "200.00", "800.00"]] }
        allow(operation).to receive(:entry).with(1000, 1000, :credit)
        allow(operation).to receive(:entry).with(200, 800, :debit)
        account.deposit(1000)
        p account.statement, "here"
        account.withdraw(200)
        p account.statement, "two"
        expect { account.statement }.to output("date || credit || debit || balance\n#{Time.now.strftime("%d/%m/%Y")} || || 200.00 || 800.00\n#{Time.now.strftime("%d/%m/%Y")} || 1000.00 || || 1000.00\n").to_stdout
      end
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

    it "a client will see their operations displayed on the statement" do
      Timecop.freeze do
        allow(operation).to receive(:log) { [[Time.now.strftime("%d/%m/%Y"), "1000.00", '', "1000.00"]] }
        allow(operation).to receive(:entry).with(1000, 1000, :credit)
        account.deposit(1000)
        expect { account.statement }.to output("date || credit || debit || balance\n#{Time.now.strftime("%d/%m/%Y")} || 1000.00 || || 1000.00\n").to_stdout
      end
    end
  end

end
