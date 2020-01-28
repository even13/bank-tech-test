require 'statement'
require 'timecop'

describe Statement do
  let(:operation) { double :operation }
  let(:account) { double "account" }
  subject(:statement) { described_class.new }

  context "display client statement" do
    describe "#header" do
      it "shows only the header if no operations yet" do
        expect(statement.header).to eq "date || credit || debit || balance\n"
      end

      it "shows operations under the header" do
        Timecop.freeze do
          allow(operation).to receive(:log) { [["#{Time.now.strftime("%d/%m/%Y")}", "1000.00", '', "1000.00"],
                                             ["#{Time.now.strftime("%d/%m/%Y")}", "2000.00", '', "3000.00"],
                                             ["#{Time.now.strftime("%d/%m/%Y")}", "", "500.00", "2500.00"]]
          }
          statement = Statement.new(operation)
          expect(statement.print_statement).to eq("date || credit || debit || balance\n#{Time.now.strftime("%d/%m/%Y")} || 1000.00 || || 1000.00\n#{Time.now.strftime("%d/%m/%Y")} || 2000.00 || || 3000.00\n#{Time.now.strftime("%d/%m/%Y")} || || 500.00 || 2500.00")
        end
      end
    end
  end
end
