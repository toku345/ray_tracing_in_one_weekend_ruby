# frozen_string_literal: true
# typed: strict

require_relative 'vec3'
require_relative 'ray'

require 'sorbet-runtime'

class HitRecord
  extend T::Sig

  sig { returns(Point3) }
  attr_accessor :p

  sig { returns(T.nilable(Vec3)) }
  attr_reader :normal

  sig { returns(Float) }
  attr_accessor :t

  sig { returns(T.nilable(T::Boolean)) }
  attr_accessor :front_face

  sig { params(p: Point3, t: Float).void }
  def initialize(p = Point3.new, t = 0.0)
    @p = p
    @t = t
    @normal = T.let(nil, T.nilable(Vec3))
    @front_face = T.let(nil, T.nilable(T::Boolean))
  end

  sig { params(r: Ray, outward_normal: Vec3).void }
  def set_face_normal(r, outward_normal)
    # Sets the hit record normal vector.
    # NOTE: the parameter `outward_normal` is assumed to have unit length.

    @front_face = r.direction.dot(outward_normal).negative?
    @normal = @front_face ? outward_normal : -outward_normal
  end

  sig { params(other: HitRecord).returns(T::Boolean) }
  def ==(other)
    @p == other.p && @t == other.t && @normal == other.normal && @front_face == other.front_face
  end
end

module Hittable
  extend T::Sig

  sig { params(r: Ray, ray_tmin: Float, ray_tmax: Float).returns(T.nilable(HitRecord)) }
  def hit(r, ray_tmin, ray_tmax) # rubocop:disable Lint/UnusedMethodArgument
    Kernel.raise 'Not implemented'
  end
end
