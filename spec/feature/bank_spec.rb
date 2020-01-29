require 'timecop'

describe 'Bank account' do
  let(:operation_test) { Operation.new }
  let(:account_test) { Account.new(operation_test) }
  let(:statement_test) { Statement.new(operation_test) }

  it "returns a balance of 1000 for a deposit of 1000" do
    expect(account_test.deposit(1000)).to eq 1000
  end

end
