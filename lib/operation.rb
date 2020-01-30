class Operation

  attr_reader :log
  DATE = Time.now.strftime("%d/%m/%Y")

  def initialize
    @log = []
  end

  def entry(amount, balance, type)
    if type == :credit
      @log << [DATE, sprintf('%.2f', amount), '', sprintf('%.2f', balance)]
    else
      @log << [DATE, '', sprintf('%.2f', amount), sprintf('%.2f', balance)]
    end
  end

end
