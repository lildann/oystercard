class Oystercard

  BALANCE_LIMIT = 90
  attr_reader :balance

  def initialize(balance=0)
    @balance = balance
  end

  def top_up(money)
    @balance += money
    raise "Top up amount exceeds £#{BALANCE_LIMIT}" if exceeds_balance?
    monetize
  end

  def deduct(fare)
    @balance -= fare
    monetize
  end

  def in_journey?
    false
  end

  def touch_in
    true
  end

  private

  def exceeds_balance?
    @balance > BALANCE_LIMIT
  end

  def monetize
    "£#{@balance}"
  end
end