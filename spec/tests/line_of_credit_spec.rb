require 'spec_helper'
require 'date'

describe LineOfCredit do
  let(:loc) {LineOfCredit.new(1000, 0.35)}
  let(:draw_date) {Date.parse('2015-09-04')}
  context 'Scenario 1' do

    before do
      loc.draw(500, draw_date)
    end

    it 'should return the right interest charges after 30 days' do
      expect(loc.interest(draw_date + 30)).to eq 14.38
    end

    it 'should return the right payoff total after 30 days' do
      expect(loc.total_payoff(draw_date + 30)).to eq 514.38
    end
  end

  context 'Scenario 2' do
    before do
      loc.draw(500, draw_date)
      loc.pay(200, draw_date + 15)
      loc.draw(100, draw_date + 25)
    end

    it 'should return the right interest charges after 30 days' do
      expect(loc.interest(draw_date + 30)).to eq 11.99
    end

    it 'should return the right payoff total after 30 days' do
      expect(loc.total_payoff(draw_date + 30)).to eq 411.99
    end

  end
end
