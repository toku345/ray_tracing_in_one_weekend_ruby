# frozen_string_literal: true
# typed: true

require_relative 'vec3'
require_relative 'ray'

require 'sorbet-runtime'

class HitRecord
  extend T::Sig

  attr_accessor :p, :normal, :t

  sig { params(p: Point3, normal: Vec3, t: Float).void }
  def initialize(p, normal, t)
    @p = p
    @normal = normal
    @t = t
  end
end

module Hittable
  extend T::Sig

  sig { params(r: Ray, ray_tmin: Float, ray_tmax: Float, rec: HitRecord).returns(T::Boolean) }
  def hit(r, ray_tmin, ray_tmax, rec) # rubocop:disable Lint/UnusedMethodArgument
    Kernel.raise 'Not implemented'
  end
end
