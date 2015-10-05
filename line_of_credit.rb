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
    interest.round(2)
  end

  def total_payoff(date)
    (balance + interest(date)).round(2)
  end
end


class Transaction
  attr_accessor :amount, :date

  def initialize(amount, date)
    @amount = amount
    @date = date
  end
end
