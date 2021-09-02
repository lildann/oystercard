class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  FARE = 3

  attr_reader :balance, :in_journey, :starting_station, :exit_station, :trip_history
  attr_accessor :trip

  def initialize(balance=0)
    @balance = balance
    @in_journey = false
    @trip_history = []
    @trip = {}
  end

  def top_up(money)
    @balance += money
    fail "Balance exceeded: £#{BALANCE_LIMIT}" if balance_exceeded?
    monetize
  end

  def in_journey?
    if @starting_station == nil 
      @in_journey = false 
    else 
      @in_journey = true
    end 
  end

  def touch_in(station) 
    fail "Not enough funds on card" if balance_too_low?
    @starting_station = station
  end

  def touch_out(station)
    deduct(FARE)
    @exit_station = station
    @trip[:start] = @starting_station
    @trip[:end] = @exit_station
    @starting_station = nil 
    @exit_station
    @trip_history << @trip
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