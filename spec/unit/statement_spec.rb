require 'statement'

describe Statement do
  let(:operation) { double :operation }
  subject(:statement) { Statement.new(operation) }

  before do
    stub_const("Operation::DATE", "#{Time.now.strftime("%d/%m/%Y")}")
  end

  context "display client statement" do

    describe "print_statement" do
      it "shows operations under the header in reverse chronological order" do
        allow(operation).to receive(:log) { [["#{Operation::DATE}", "1000.00", '', "1000.00"],
                                           ["#{Operation::DATE}", "2000.00", '', "3000.00"],
                                           ["#{Operation::DATE}", "", "500.00", "2500.00"]]
        }
        statement = Statement.new(operation)
        expect(statement.print_statement).to eq("date || credit || debit || balance\n#{Operation::DATE} || || 500.00 || 2500.00\n#{Operation::DATE} || 2000.00 || || 3000.00\n#{Operation::DATE} || 1000.00 || || 1000.00")
      end

      it "will not allow printing the statement unless there are operations to show" do
        allow(operation).to receive(:log) { [] }
        statement = Statement.new(operation)
        expect { statement.print_statement }.to raise_error("No operations to display yet")
      end
    end
  end
end
