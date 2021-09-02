class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 3

  attr_reader :balance, :in_journey#, :entry_station

  def initialize(balance=0)
    @balance = balance
    @in_journey = false
  end

  def top_up(money)
    @balance += money
    fail "Balance exceeded: £#{BALANCE_LIMIT}" if balance_exceeded?
    monetize
  end

  def in_journey?
    @in_journey
  end

  def touch_in(station) #added test that touch_in should receive 1 argument
    fail "Not enough funds on card" if balance_too_low?
    @in_journey = true
    # @entry_station = station 
  end

  def touch_out
    @in_journey = false
    deduct(FARE)
  end

  private

  def deduct(fare)
    @balance -= fare
    monetize
  end

  def balance_exceeded?
    @balance > BALANCE_LIMIT
  end

  def balance_too_low?
    @balance < MINIMUM_BALANCE
  end

  def monetize
    "£#{@balance}"
  end
end