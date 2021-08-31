class Oystercard

  BALANCE_LIMIT = 90

  def initialize(balance=0)
    @balance = balance
  end

  attr_reader :balance

  def top_up(money)
    @balance += money
    raise "Top up amount exceeds £#{BALANCE_LIMIT}" if exceeds_balance?
    "£#{@balance}"
  end

  private

  def exceeds_balance?
    @balance > BALANCE_LIMIT
  end
end