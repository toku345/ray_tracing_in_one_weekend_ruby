# frozen_string_literal: true
# typed: false

require_relative '../../lib/hittable'

RSpec.describe HitRecord do
  describe '#set_face_normal' do
    context 'when the ray hits the outside of the sphere' do
      let(:hit_record) { described_class.new(Point3.new(0.0, 0.0, -0.5), Vec3.new(0.0, 0.0, 1.0), 0.5) }
      let(:r) { Ray.new(Point3.new(0.0, 0.0, 0.0), Vec3.new(0.0, 0.0, -1.0)) }

      it 'sets the front_face attribute to true' do
        hit_record.set_face_normal(r, Vec3.new(0.0, 0.0, 1.0))
        expect(hit_record.front_face).to be(true)
      end

      it 'sets the normal' do
        hit_record.set_face_normal(r, Vec3.new(0.0, 0.0, 1.0))
        expect(hit_record.normal).to eq(Vec3.new(0.0, 0.0, 1.0))
      end
    end

    context 'when the ray hits the inside of the sphere' do
      it 'sets the front_face attribute to false' do
        hit_record = described_class.new(Point3.new(0.0, 0.0, -0.5), Vec3.new(0.0, 0.0, 1.0), 0.5)
        r = Ray.new(Point3.new(0.0, 0.0, 0.0), Vec3.new(0.0, 0.0, 1.0))
        hit_record.set_face_normal(r, Vec3.new(0.0, 0.0, 1.0))
        expect(hit_record.front_face).to be(false)
      end

      it 'sets the normal' do
        hit_record = described_class.new(Point3.new(0.0, 0.0, -0.5), Vec3.new(0.0, 0.0, 1.0), 0.5)
        r = Ray.new(Point3.new(0.0, 0.0, 0.0), Vec3.new(0.0, 0.0, 1.0))
        hit_record.set_face_normal(r, Vec3.new(0.0, 0.0, 1.0))
        expect(hit_record.normal).to eq(Vec3.new(0.0, 0.0, -1.0))
      end
    end
  end
end
