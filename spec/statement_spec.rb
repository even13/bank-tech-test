require 'statement'

describe Statement do
  let(:operation) { Operation.new(10, 110) }
  subject(:statement) { described_class.new }

  describe "#record" do
    it "records all operations" do
      statement.record << operation
      expect(statement.record).to eq [operation]
    end
  end
end
