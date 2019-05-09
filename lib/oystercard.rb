class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :list
  CAPACITY = 90
  MINIMUM_FARE = 1


  def initialize
    @balance = 0
    @list = []

  end

  def top_up(money)
    fail 'Cannot input that amount! Maximum balance of $90 will be exceeded' if full? or @balance + money > CAPACITY
    @balance += money
  end

  def touch_in(station)
    fail 'not enough funds (minimum fare £1)' if @balance < MINIMUM_FARE 
    @entry_station = station
    @station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @exit_station = station
  end

  def in_journey?
    @entry_station == nil ? false : true
  end

  def journey 
    journey = Hash.new
    @journey = journey.merge(@station => @exit_station)
  end

  def list_of_journeys
    @list << @journey
  end 

  private
  def deduct(money)
    @balance -= money
  end

  def full?
    @balance > CAPACITY
  end

end
