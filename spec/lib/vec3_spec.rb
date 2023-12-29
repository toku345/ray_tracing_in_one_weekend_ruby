# frozen_string_literal: true
# typed: false

require_relative '../../lib/vec3'

RSpec.describe Vec3 do
  describe '#x' do
    it 'returns the x component of the vector' do
      expect(described_class.new(1.0, 2.0, 3.0).x).to eq(1.0)
    end
  end

  describe '#y' do
    it 'returns the y component of the vector' do
      expect(described_class.new(1.0, 2.0, 3.0).y).to eq(2.0)
    end
  end

  describe '#z' do
    it 'returns the z component of the vector' do
      expect(described_class.new(1.0, 2.0, 3.0).z).to eq(3.0)
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the vector' do
      expect(described_class.new(1.0, 2.0, 3.0).to_s).to eq('1.0 2.0 3.0')
    end
  end

  describe '#==' do
    it 'returns true when the vectors are equal' do
      v1 = described_class.new(1.0, 2.0, 3.0)
      v2 = described_class.new(1.0, 2.0, 3.0)

      expect(v1 == v2).to be(true)
    end

    it 'returns false when the vectors are not equal' do
      v1 = described_class.new(1.0, 2.0, 3.0)
      v2 = described_class.new(4.0, 5.0, 6.0)

      expect(v1 == v2).to be(false)
    end
  end

  describe '#-@' do
    it 'returns the negated vector' do
      expect(-described_class.new(1.0, 2.0, 3.0)).to eq(described_class.new(-1.0, -2.0, -3.0))
    end
  end

  describe '#[]' do
    it 'returns the component at the given index' do
      expect(described_class.new(1.0, 2.0, 3.0)[1]).to eq(2.0)
    end
  end

  describe '#+' do
    it 'returns the sum of the two vectors' do
      v1 = described_class.new(1.0, 2.0, 3.0)
      v2 = described_class.new(4.0, 5.0, 6.0)
      expected = described_class.new(5.0, 7.0, 9.0)

      expect(v1 + v2).to eq(expected)
    end
  end

  describe '+=' do
    it 'adds the given vector to the current vector' do
      v1 = described_class.new(1.0, 2.0, 3.0)
      v2 = described_class.new(4.0, 5.0, 6.0)
      expected = described_class.new(5.0, 7.0, 9.0)

      v1 += v2
      expect(v1).to eq(expected)
    end
  end

  describe '#-' do
    it 'returns the difference of the two vectors' do
      v1 = described_class.new(1.0, 2.0, 3.0)
      v2 = described_class.new(4.0, 6.0, 8.0)
      expected = described_class.new(-3.0, -4.0, -5.0)

      expect(v1 - v2).to eq(expected)
    end
  end

  describe '-=' do
    it 'subtracts the given vector from the current vector' do
      v1 = described_class.new(1.0, 2.0, 3.0)
      v2 = described_class.new(4.0, 6.0, 8.0)
      expected = described_class.new(-3.0, -4.0, -5.0)

      v1 -= v2
      expect(v1).to eq(expected)
    end
  end

  describe '#*' do
    context 'when the other is a vector' do
      it 'returns the product of the two vectors' do
        v1 = described_class.new(1.0, 2.0, 3.0)
        v2 = described_class.new(4.0, 5.0, 6.0)
        expected = described_class.new(4.0, 10.0, 18.0)

        expect(v1 * v2).to eq(expected)
      end
    end

    context 'when the other is a scalar' do
      it 'returns the product of the vector and the scalar' do
        v = described_class.new(1.0, 2.0, 3.0)
        expected = described_class.new(2.0, 4.0, 6.0)

        expect(v * 2.0).to eq(expected)
      end
    end
  end

  describe '*=' do
    context 'when the other is a vector' do
      it 'multiplies the current vector by the given vector' do
        v1 = described_class.new(1.0, 2.0, 3.0)
        v2 = described_class.new(4.0, 5.0, 6.0)
        expected = described_class.new(4.0, 10.0, 18.0)

        v1 *= v2
        expect(v1).to eq(expected)
      end
    end

    context 'when the other is a scalar' do
      it 'multiplies the current vector by the given scalar' do
        v = described_class.new(1.0, 2.0, 3.0)
        expected = described_class.new(2.0, 4.0, 6.0)

        v *= 2.0
        expect(v).to eq(expected)
      end
    end
  end

  describe '#/' do
    it 'returns the quotient of the vector and the scalar' do
      v = described_class.new(2.0, 4.0, 6.0)
      expected = described_class.new(1.0, 2.0, 3.0)

      expect(v / 2.0).to eq(expected)
    end
  end

  describe '#/=' do
    it 'divides the current vector by the given scalar' do
      v = described_class.new(2.0, 4.0, 6.0)
      expected = described_class.new(1.0, 2.0, 3.0)

      v /= 2.0
      expect(v).to eq(expected)
    end
  end

  describe '#length' do
    it 'returns the length of the vector' do
      v = described_class.new(1.0, 2.0, 3.0)

      expect(v.length).to eq(Math.sqrt(14.0))
    end
  end

  describe '#length_squared' do
    it 'returns the squared length of the vector' do
      v = described_class.new(1.0, 2.0, 3.0)

      expect(v.length_squared).to eq(14.0)
    end
  end

  describe '#dot' do
    it 'returns the dot product of the two vectors' do
      v1 = described_class.new(1.0, 2.0, 3.0)
      v2 = described_class.new(4.0, 5.0, 6.0)
      expected = 32.0

      expect(v1.dot(v2)).to eq(expected)
    end
  end

  describe '#cross' do
    it 'returns the cross product of the two vectors' do
      v1 = described_class.new(1.0, 2.0, 3.0)
      v2 = described_class.new(4.0, 5.0, 6.0)
      expected = described_class.new(3.0, -6.0, 3.0)

      expect(v1.cross(v2)).to eq(expected)
    end
  end

  describe '#unit_vector' do
    it 'returns a unit vector in the same direction as the given vector' do
      v = described_class.new(3.0, 6.0, 9.0)
      expected = described_class.new(0.2672612419124244, 0.5345224838248488, 0.8017837257372732)

      expect(v.unit_vector).to eq(expected)
    end
  end
end
