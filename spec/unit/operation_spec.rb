require 'operation'

describe Operation do
  describe "#entry" do

    before do
      stub_const("Operation::DATE", "#{Time.now.strftime("%d/%m/%Y")}")
    end

    it "adds a deposit to the log if the type is credit" do
      operation = Operation.new
      operation.entry(100, 1000, :credit)
      expect(operation.log).to eq([[Operation::DATE, "100.00", "", "1000.00"]])
    end

    it "adds a withdrawal to the log if the type is debit" do
      operation = Operation.new
      operation.entry(100, 1000, :debit)
      expect(operation.log).to eq([[Operation::DATE, "", "100.00", "1000.00"]])
    end
  end
end
