class Oystercard

  def initialize(balance=0)
    @balance = balance
  end

  attr_reader :balance

  def top_up(money)
    @balance += money
    "£#{@balance}"
  end
end