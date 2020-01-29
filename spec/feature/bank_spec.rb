require 'timecop'

describe 'Bank account' do
  let(:operation_test) { Operation.new }
  let(:account_test) { Account.new(operation_test) }
  let(:statement_test) { Statement.new(operation_test) }

  it "returns a balance of 1000 for a deposit of 1000" do
    expect(account_test.deposit(1000)).to eq 1000
  end

  it "returns a balance of 1000 for a deposit of 2000 followed by a withdrawal of 1000" do
    account_test.deposit(2000)
    expect(account_test.withdraw(1000)).to eq 1000
  end

  it "raises an error when trying to withdraw more than you have" do
    account_test.deposit(500)
    expect { account_test.withdraw(1000) }.to raise_error("Insufficient funds for this operation")
  end

  it "the statement is displayed with operations in the right order" do
    Timecop.freeze do
      account_test.deposit(1000)
      account_test.deposit(2000)
      account_test.withdraw(500)
      expect { account_test.statement }.to output("date || credit || debit || balance\n#{Time.now.strftime("%d/%m/%Y")} || || 500.00 || 2500.00\n#{Time.now.strftime("%d/%m/%Y")} || 2000.00 || || 3000.00\n#{Time.now.strftime("%d/%m/%Y")} || 1000.00 || || 1000.00\n").to_stdout
    end
  end
end
