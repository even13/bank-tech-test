class Operation

  attr_reader :log

  def initialize
    @log = []
  end

  def entry(amount, balance, type)
    if type == :credit
      @log << [Time.now.strftime("%d/%m/%Y"), sprintf('%.2f', amount), '', sprintf('%.2f', balance)]
    else
      @log << [Time.now.strftime("%d/%m/%Y"), '', sprintf('%.2f', amount), sprintf('%.2f', balance)]
    end
  end

end
