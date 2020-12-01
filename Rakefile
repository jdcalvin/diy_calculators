require 'pry'

task :console do
  def reload
    load 'fraction.rb'
    load 'quikrete_calc.rb'
    load 'shaker_calc.rb'

  end

  def test_fraction(str)
    val = eval(str)
    f = Fraction.new(val)
    puts "#{str} is #{f.raw} or #{f}"
  end

  def test_fractions
    (1..32).each do |v|
      test_fraction("#{v}/32.0")
    end

    test_fraction "1.5"
    test_fraction "5"
    test_fraction "1.0"


  end

  reload
  binding.pry
end