class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :in_journey

  def initialize(balance=0)
    @balance = balance
    @in_journey = false
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
    @in_journey
  end

  def touch_in
    @in_journey = true
    fail "Not enough funds on card" if @balance < MINIMUM_BALANCE
  end

  def touch_out
    @in_journey = false
  end

  private

  def exceeds_balance?
    @balance > BALANCE_LIMIT
  end

  def monetize
    "£#{@balance}"
  end
end