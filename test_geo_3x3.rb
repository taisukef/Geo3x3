require "minitest/unit"
require "minitest/autorun"
require "./geo_3x3"

class TestGeo3x3 < MiniTest::Unit::TestCase
  include Geo3x3

  def test_decode
    assert_equal [40.0, -86.2962962962963, 6, 0.7407407407407408], decode("W28644")
    assert_equal [11.111111111111114, 105.55555555555556, 5.0, 2.2222222222222223], decode("E5379")
    assert_equal [40.0, -86.2962962962963, 6, 0.7407407407407408], decode(-28644)
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
      [40.0, -86.2962962962963]
    ].each_with_index do |params, i|
      assert_raises(ArgumentError) do
        encode(params[0], params[1], 0)
      end
      (1..9).each do |level|
        assert_equal accepts[i][level - 1], encode(params[0], params[1], level)
      end
    end
  end

  def test_coords
    assert_equal [-86.66666666666667, 39.629629629629626, -86.66666666666667, 40.370370370370374, -85.92592592592594, 40.370370370370374, -85.92592592592594, 39.629629629629626], coords("W28644")
    assert_equal [104.44444444444444, 10.000000000000004, 104.44444444444444, 12.222222222222225, 106.66666666666667, 12.222222222222225, 106.66666666666667, 10.000000000000004], coords("E5379")
    assert_equal [-86.66666666666667, 39.629629629629626, -86.66666666666667, 40.370370370370374, -85.92592592592594, 40.370370370370374, -85.92592592592594, 39.629629629629626], coords("-28644")
  end
end
