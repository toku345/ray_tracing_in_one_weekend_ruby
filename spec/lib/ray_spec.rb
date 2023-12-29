# frozen_string_literal: true
# typed: false

require_relative '../../lib/ray'
require_relative '../../lib/vec3'

RSpec.describe Ray do
  describe '#at' do
    it 'returns the point at the given t' do
      origin = Point3.new(1.0, 2.0, 3.0)
      direction = Vec3.new(2.0, 2.0, 2.0)
      ray = described_class.new(origin, direction)

      expect(ray.at(3.0)).to eq(Vec3.new(7.0, 8.0, 9.0))
    end
  end
end
