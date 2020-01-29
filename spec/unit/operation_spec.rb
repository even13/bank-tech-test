require 'operation'
require 'timecop'

describe Operation do
  describe "#entry" do

    it "adds a deposit to the log if the type is credit" do
      Timecop.freeze do
        operation = Operation.new
        operation.entry(100, 1000, :credit)
        expect(operation.log).to eq([["#{Time.now.strftime("%d/%m/%Y")}", "100.00", "", "1000.00"]])
      end
    end

    it "adds a withdrawal to the log if the type is debit" do
      Timecop.freeze do
        operation = Operation.new
        operation.entry(100, 1000, :debit)
        expect(operation.log).to eq([["#{Time.now.strftime("%d/%m/%Y")}", "", "100.00", "1000.00"]])
      end
    end
  end
end
