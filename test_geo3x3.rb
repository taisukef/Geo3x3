#require "minitest/unit"
require "minitest/autorun"
require "./geo3x3"

class TestGeo3x3 < MiniTest::Unit::TestCase
  include Geo3x3

  def test_decode
    assert_equal [-40.0, -86.2962962962963, 6, 0.7407407407407408], decode("W28644")
    assert_equal [-11.111111111111114, 105.55555555555556, 5.0, 2.2222222222222223], decode("E5379")
    assert_equal [-40.0, 93.7037037037037, 6, 0.7407407407407408], decode("E28644")
    assert_equal [35.6586337900162, 139.74546563023935, 14, 0.00011290058538953522], decode("E9139659937288")
  end

  def test_encode
    accepts = [
      %w(W
         W2
         W28
         W286
         W2864
         W28644
         W286445
         W2864455
         W28644555)
    ]

    [
      [-40.0, -86.2962962962963]
    ].each_with_index do |params, i|
      assert_raises(ArgumentError) do
        encode(params[0], params[1], 0)
      end
      (1..9).each do |level|
        assert_equal accepts[i][level - 1], encode(params[0], params[1], level)
      end
    end
  end
end
