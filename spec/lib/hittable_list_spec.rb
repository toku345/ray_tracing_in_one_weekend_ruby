# frozen_string_literal: true
# typed: false

require_relative '../../lib/hittable_list'
require_relative '../../lib/sphere'
require_relative '../../lib/ray'

RSpec.describe HittableList do
  describe '#clear' do
    it 'clears the objects' do
      list = described_class.new(Sphere.new(Point3.new(0.0, 0.0, -1.0), 0.5))
      expect { list.clear }.to change { list.objects.size }.from(1).to(0)
    end
  end

  describe '#add' do
    it 'adds the object' do
      s = Sphere.new(Point3.new(0.0, 0.0, -1.0), 0.5)
      list = described_class.new
      expect { list.add(s) }.to change { list.objects.size }.from(0).to(1)
    end
  end

  describe '#hit' do
    context 'when the ray hits any objects' do
      let(:sphere) { Sphere.new(Point3.new(0.0, 0.0, -1.0), 0.5) }
      let(:ray) { Ray.new(Point3.new(0.0, 0.0, 0.0), Vec3.new(0.0, 0.0, -1.0)) }

      let(:expected_rec) do
        HitRecord.new(Point3.new(0.0, 0.0, -0.5), 0.5).tap do |rec|
          rec.set_face_normal(ray, Vec3.new(0.0, 0.0, 1.0))
        end
      end

      it 'returns hit_record' do
        list = described_class.new(sphere)
        expect(list.hit(ray, 0.0, Float::INFINITY)).to eq(expected_rec)
      end
    end

    context 'when the ray hits multiple objects' do
      let(:sphere) { Sphere.new(Point3.new(0.0, 0.0, -1.0), 0.5) }
      let(:sphere2) { Sphere.new(Point3.new(0.0, 0.0, -2.0), 0.5) }
      let(:ray) { Ray.new(Point3.new(0.0, 0.0, 0.0), Vec3.new(0.0, 0.0, -1.0)) }

      let(:expected_rec) do
        HitRecord.new(Point3.new(0.0, 0.0, -0.5), 0.5).tap do |rec|
          rec.set_face_normal(ray, Vec3.new(0.0, 0.0, 1.0))
        end
      end

      it 'returns the closest hit_record' do
        list = described_class.new(sphere2)
        list.add(sphere)

        expect(list.hit(ray, 0.0, Float::INFINITY)).to eq(expected_rec)
      end
    end

    context 'when the ray does not hit any objects' do
      let(:sphere) { Sphere.new(Point3.new(0.0, 0.0, -1.0), 0.5) }
      let(:ray) { Ray.new(Point3.new(0.0, 0.0, 0.0), Vec3.new(0.0, 1.0, 0.0)) }

      it 'returns nil when the ray does not hit any objects' do
        list = described_class.new(sphere)
        expect(list.hit(ray, 0.0, Float::INFINITY)).to be_nil
      end
    end
  end
end
