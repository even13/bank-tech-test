require 'account'

describe Account do
  let(:statement) { double :statement }
  let(:operation) { double :operation }
  subject(:account) { Account.new(operation, statement) }

  before do
    stub_const("Operation::DATE", "#{Time.now.strftime("%d/%m/%Y")}")
  end

  describe "#deposit" do

    it "a client should be able to deposit money" do
      allow(operation).to receive(:log) { [["30/01/2020", "1000.00", '', "1000.00"]] }
      allow(statement).to receive(:print_statement) { "date || credit || debit || balance\n" + "30/01/2020 || 1000.00 || || 1000.00\n" }
      allow(operation).to receive(:entry).with(1000, 1000, :credit)
      expect(account.deposit(1000)).to be(1000)
    end
  end

  describe "#withdraw" do

    it "a client should be able to withdraw money" do
      allow(operation).to receive(:log) { [["30/01/2020", "1000.00", '', "1000.00"], ["30/01/2020", '', "300.00", "700.00"]] }
      allow(statement).to receive(:print_statement) { "date || credit || debit || balance\n" + "30/01/2020 || || 300.00 || 700.00\n" + "30/01/2020 || 1000.00 || || 1000.00\n" }
      allow(operation).to receive(:entry).with(1000, 1000, :credit)
      allow(operation).to receive(:entry).with(200, 800, :debit)
      account.deposit(1000)
      expect(account.withdraw(200)).to be(800)
    end

    it "a client cannot withdraw if it will make the balance negative" do
      expect { account.withdraw(200) }.to raise_error("Insufficient funds for this operation")
    end
  end

  describe "#statement" do
    it "a client cannot print their account statement without operations" do
      allow(operation).to receive(:log) { [] }
      allow(statement).to receive(:print_statement).and_raise("No operations to display yet")
      expect { account.statement }.to raise_error("No operations to display yet")
    end

    it "a client sees their deposit on their statement" do
      allow(operation).to receive(:log) { [["30/01/2020", "1000.00", '', "1000.00"]] }
      allow(statement).to receive(:print_statement) { "date || credit || debit || balance\n" + "30/01/2020 || 1000.00 || || 1000.00\n" }
      allow(operation).to receive(:entry).with(1000, 1000, :credit)
      account.deposit(1000)
      expect { account.statement }.to output("date || credit || debit || balance\n30/01/2020 || 1000.00 || || 1000.00\n").to_stdout
    end

    it "a client will see their operations displayed on the statement" do
      allow(operation).to receive(:log) { [["30/01/2020", "1000.00", '', "1000.00"]] }
      allow(statement).to receive(:print_statement) { "date || credit || debit || balance\n" + "30/01/2020 || 1000.00 || || 1000.00\n" }
      allow(operation).to receive(:entry).with(1000, 1000, :credit)
      account.deposit(1000)
      expect { account.statement }.to output("date || credit || debit || balance\n30/01/2020 || 1000.00 || || 1000.00\n").to_stdout
    end

    it "a client sees their withdrawal on their statement" do
      allow(operation).to receive(:log) { [["30/01/2020", "1000.00", '', "1000.00"], ["31/01/2020", '', "300.00", "700.00"]] }
      allow(statement).to receive(:print_statement) { "date || credit || debit || balance\n" + "31/01/2020 || || 300.00 || 700.00\n" + "30/01/2020 || 1000.00 || || 1000.00\n" }
      allow(operation).to receive(:entry).with(1000, 1000, :credit)
      allow(operation).to receive(:entry).with(200, 800, :debit)
      account.deposit(1000)
      account.withdraw(200)
      expect { account.statement }.to output("date || credit || debit || balance\n31/01/2020 || || 300.00 || 700.00\n30/01/2020 || 1000.00 || || 1000.00\n").to_stdout
    end
  end

end
