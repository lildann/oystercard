class Oystercard

  def initialize(balance=0)
    @balance = balance
    puts "hello Lilly"
  end

  attr_reader :balance
end