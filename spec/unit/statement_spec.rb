require 'statement'
require 'timecop'

describe Statement do
  let(:operation) { double :operation }
  subject(:statement) { Statement.new(operation) }

  context "display client statement" do

    describe "print_statement" do
      it "shows operations under the header in reverse chronological order" do
        Timecop.freeze do
          allow(operation).to receive(:log) { [["#{Time.now.strftime("%d/%m/%Y")}", "1000.00", '', "1000.00"],
                                             ["#{Time.now.strftime("%d/%m/%Y")}", "2000.00", '', "3000.00"],
                                             ["#{Time.now.strftime("%d/%m/%Y")}", "", "500.00", "2500.00"]]
          }
          statement = Statement.new(operation)
          expect(statement.print_statement).to eq("date || credit || debit || balance\n#{Time.now.strftime("%d/%m/%Y")} || || 500.00 || 2500.00\n#{Time.now.strftime("%d/%m/%Y")} || 2000.00 || || 3000.00\n#{Time.now.strftime("%d/%m/%Y")} || 1000.00 || || 1000.00")
        end
      end

      it "will not allow printing the statement unless there are operations to show" do
        allow(operation).to receive(:log) { [] }
        statement = Statement.new(operation)
        expect { statement.print_statement }.to raise_error("No operations to display yet")
      end
    end
  end
end
