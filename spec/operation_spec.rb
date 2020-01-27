require 'operation'
require 'timecop'

describe Operation do

  it "credits the user's account by 10" do
    Timecop.freeze do
      operation = Operation.new(10, 110)
      expect(operation.amount).to eq 10
      expect(operation.balance).to eq 110
      expect(operation.date).to eq Time.now
    end
  end

  it "debits the user's account by 10" do
    Timecop.freeze do
      operation = Operation.new(-10, 90)
      expect(operation.amount).to eq(-10)
      expect(operation.balance).to eq 90
      expect(operation.date).to eq Time.now
    end
  end
end
