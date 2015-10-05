require 'yaml'

class Factors

  attr_reader :input

  CACHE = YAML::load(File.open("cache.yml")) rescue {factors:{}, reverse_factors: {}}

  def initialize(input)
    @input = input
  end

  def factors
    output = {}
    input.each do |num|
      all_factors_of_num = get_factors(num)
      factors_of_num_in_input = []
      input.each do |n|
        if all_factors_of_num.include?(n)
          factors_of_num_in_input << n
        end
      end
      output[num] = factors_of_num_in_input
    end
    File.open("cache.yml","w") do |f|
      f.write(YAML::dump(CACHE))
    end
    output
  end

  def reverse_factors
    output = {}
    input.each do |num|
      output[num] = get_reverse_factors(num)
    end
    output
  end

  private

    def get_factors(num)
      CACHE[:factors].fetch(num) do
        factors = []
        2.upto(num/2) do |i|
          if (num % i) == 0
            factors << i
          end
        end
        CACHE[:factors][num] = factors
        factors
      end
    end

    def get_reverse_factors(num)
      CACHE[:reverse_factors].fetch(num) do
        rev_factors = []
        input.each do |n|
          rev_factors << n if get_factors(n).include?(num)
        end
        CACHE[:reverse_factors][num] = rev_factors
        rev_factors
      end
    end
end
