# frozen_string_literal: true
# typed: false

require_relative '../../lib/float'
require_relative '../../lib/vec3'

RSpec.describe Float do
  describe '#multiple_with_vec3' do
    it 'returns the product of the float and the vector' do
      v = Vec3.new(1.0, 2.0, 3.0)
      expected = Vec3.new(2.0, 4.0, 6.0)

      expect(2.0.multiple_with_vec3(v)).to eq(expected)
    end
  end
end
