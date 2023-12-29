# frozen_string_literal: true
# typed: true

require_relative 'float'
require_relative 'vec3'

class Ray
  extend T::Sig

  sig { returns(Point3) }
  attr_reader :origin

  sig { returns(Vec3) }
  attr_reader :direction

  sig { params(origin: Point3, direction: Vec3).void }
  def initialize(origin, direction)
    @origin = origin
    @direction = direction
  end

  sig { params(t: Float).returns(Point3) }
  def at(t)
    origin + t.multiple_with_vec3(direction)
  end
end
