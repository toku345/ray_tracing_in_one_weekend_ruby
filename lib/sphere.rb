# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative 'hittable'
require_relative 'interval'

class Sphere
  extend T::Sig

  include Hittable

  sig { params(center: Point3, radius: Float).void }
  def initialize(center, radius)
    @center = center
    @radius = radius
  end

  sig { params(r: Ray, ray_t: Interval).returns(T.nilable(HitRecord)) }
  def hit(r, ray_t) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    oc = r.origin - @center
    a = r.direction.length_squared
    half_b = oc.dot(r.direction)
    c = oc.length_squared - (@radius * @radius)

    discriminant = (half_b * half_b) - (a * c)
    return if discriminant.negative?

    sqrtd = Math.sqrt(discriminant)

    # Find the nearest root that lies in the acceptable range.
    root = (-half_b - sqrtd) / a
    unless ray_t.surrounds(root)
      root = (-half_b + sqrtd) / a
      return unless ray_t.surrounds(root)
    end

    rec = HitRecord.new(r.at(root), root)
    outward_normal = (rec.p - @center) / @radius
    rec.set_face_normal(r, outward_normal)
    rec
  end
end
