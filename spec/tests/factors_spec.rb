require 'spec_helper'

describe Factors do
  context 'Factors tests' do
    let(:fact) {Factors.new([10, 5, 2, 20])}
    let(:factors) {fact.factors}
    let(:reverse_factors) {fact.reverse_factors}

    it 'should return the right factors for the input' do
      expect(factors[10]).to eq [5,2]
      expect(factors[5]).to eq []
      expect(factors[2]).to eq []
      expect(factors[20]).to eq [10, 5, 2]
    end

    it 'should return the right reverse factors for the input' do
      expect(reverse_factors[10]).to eq [20]
      expect(reverse_factors[5]).to eq [10, 20]
      expect(reverse_factors[2]).to eq [10, 20]
      expect(reverse_factors[20]).to eq []
    end
  end
end
