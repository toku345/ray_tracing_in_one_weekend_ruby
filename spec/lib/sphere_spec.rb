# frozen_string_literal: true
# typed: false

require_relative '../../lib/sphere'
require_relative '../../lib/vec3'

RSpec.describe Sphere do
  describe '#hit' do
    it 'returns hit_record when the ray hits the sphere' do
      s = described_class.new(Point3.new(0.0, 0.0, -1.0), 0.5)
      r = Ray.new(Point3.new(0.0, 0.0, 0.0), Vec3.new(0.0, 0.0, -1.0))

      expected_rec = HitRecord.new(Point3.new(0.0, 0.0, -0.5), 0.5)
      expected_rec.set_face_normal(r, Vec3.new(0.0, 0.0, 1.0))

      expect(s.hit(r, Interval.new(0.0, 1.0))).to eq(expected_rec)
    end

    it 'returns nil when the ray does not hit the sphere' do
      s = described_class.new(Point3.new(0.0, 0.0, -1.0), 0.5)
      r = Ray.new(Point3.new(0.0, 0.0, 0.0), Vec3.new(0.0, 1.0, 0.0))

      expect(s.hit(r, Interval.new(0.0, 1.0))).to be_nil
    end
  end
end
