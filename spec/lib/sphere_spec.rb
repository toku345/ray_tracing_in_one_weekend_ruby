# frozen_string_literal: true
# typed: false

require_relative '../../lib/sphere'
require_relative '../../lib/vec3'

RSpec.describe Sphere do
  describe '#hit' do
    it 'returns true when the ray hits the sphere' do
      s = described_class.new(Point3.new(0.0, 0.0, -1.0), 0.5)
      r = Ray.new(Point3.new(0.0, 0.0, 0.0), Vec3.new(0.0, 0.0, -1.0))
      rec = HitRecord.new(Point3.new(0.0, 0.0, -0.5), 0.5)

      expect(s.hit(r, 0.0, 1.0, rec)).to be(true)
    end

    it 'returns false when the ray does not hit the sphere' do
      s = described_class.new(Point3.new(0.0, 0.0, -1.0), 0.5)
      r = Ray.new(Point3.new(0.0, 0.0, 0.0), Vec3.new(0.0, 1.0, 0.0))
      rec = HitRecord.new(Point3.new(0.0, 0.0, -0.5), 0.5)

      expect(s.hit(r, 0.0, 1.0, rec)).to be(false)
    end
  end
end
