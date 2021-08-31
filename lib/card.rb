class Oystercard

  BALANCE_LIMIT = 90

  def initialize(balance=0)
    @balance = balance
  end

  attr_reader :balance

  def top_up(money)
    @balance += money
    raise "Top up amount exceeds maximum balance" if exceeds_balance?(money)
    "£#{@balance}"
  end

  private

  def exceeds_balance?(top_up_amount)
    @balance + top_up_amount > BALANCE_LIMIT
  end
end