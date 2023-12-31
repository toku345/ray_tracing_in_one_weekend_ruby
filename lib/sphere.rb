# frozen_string_literal: true
# typed: true

require_relative 'hittable'

require 'sorbet-runtime'

class Sphere
  extend T::Sig

  include Hittable

  sig { params(center: Point3, radius: Float).void }
  def initialize(center, radius)
    @center = center
    @radius = radius
  end

  sig { params(r: Ray, ray_tmin: Float, ray_tmax: Float, rec: HitRecord).returns(T::Boolean) }
  def hit(r, ray_tmin, ray_tmax, rec) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    oc = r.origin - @center
    a = r.direction.length_squared
    half_b = oc.dot(r.direction)
    c = oc.length_squared - (@radius * @radius)

    discriminant = (half_b * half_b) - (a * c)
    return false if discriminant.negative?

    sqrtd = Math.sqrt(discriminant)

    # Find the nearest root that lies in the acceptable range.
    root = (-half_b - sqrtd) / a
    if root <= ray_tmin || ray_tmax <= root
      root = (-half_b + sqrtd) / a
      return false if root <= ray_tmin || ray_tmax <= root
    end

    rec.t = root
    rec.p = r.at(rec.t)
    outward_normal = (rec.p - @center) / @radius
    rec.set_face_normal(r, outward_normal)

    true
  end
end
