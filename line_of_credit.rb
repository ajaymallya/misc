require 'date'

class LineOfCredit

  attr_accessor :balance
  attr_reader :transactions, :credit_limit, :apr

  def initialize(credit_limit, apr)
    @credit_limit = credit_limit
    @apr = apr
    @transactions = []
    @balance = 0
  end

  def draw(amount, date)
    transactions << Transaction.new(amount, date)
    self.balance += amount
    raise "Balance is over credit limit" if balance > credit_limit
  end

  def pay(amount, date)
    transactions << Transaction.new(amount * -1, date)
    self.balance -= amount
    raise "You have paid too much. Your balance is now negative" if balance < 0
  end

  def interest(date)
    current_balance = balance
    interest = 0
    last_date = date
    transactions.reverse.each do |tr|
      num_days = last_date - tr.date
      interest += current_balance * apr / 365 * num_days
      last_date = tr.date
      current_balance -= tr.amount
    end
    interest
  end

  def total_payoff(date)
    balance + interest(date)
  end
end


class Transaction
  attr_accessor :amount, :date

  def initialize(amount, date)
    @amount = amount
    @date = date
  end
end


puts "Scenario 1"
loc = LineOfCredit.new(1000, 0.35)
draw_date = Date.parse('2015-09-04')

puts "Drawing $500"
loc.draw(500, draw_date)

puts "Interest at the end of 30 days is: #{loc.interest(draw_date + 30)}"
puts "Total payoff at the end of 30 days is: #{loc.total_payoff(draw_date + 30)}"

puts "\n\n"
puts "Scenario 2"
loc = LineOfCredit.new(1000, 0.35)

puts "Drawing $500"
loc.draw(500, draw_date)

puts "Paying back $200 after 15 days"
loc.pay(200, draw_date + 15)

puts "Drawing $100 after 25 days"
loc.draw(100, draw_date + 25)

puts "Interest at the end of 30 days is: #{loc.interest(draw_date + 30)}"
puts "Total payoff at the end of 30 days is: #{loc.total_payoff(draw_date + 30)}"
