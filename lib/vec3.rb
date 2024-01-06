# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative 'float'
require_relative 'rtweekend'

class Vec3 # rubocop:disable Metrics/ClassLength
  extend T::Sig
  extend ::RtweekendHelper

  sig { params(e0: Float, e1: Float, e2: Float).void }
  def initialize(e0 = 0.0, e1 = 0.0, e2 = 0.0)
    @e = T.let([e0, e1, e2], [Float, Float, Float])
  end

  sig { returns(Float) }
  def x
    @e[0]
  end

  sig { returns(Float) }
  def y
    @e[1]
  end

  sig { returns(Float) }
  def z
    @e[2]
  end

  sig { returns(String) }
  def to_s
    "#{x} #{y} #{z}"
  end

  sig { params(other: T.nilable(Vec3)).returns(T::Boolean) }
  def ==(other)
    x == other&.x && y == other&.y && z == other&.z
  end

  sig { returns(Vec3) }
  def -@
    Vec3.new(-x, -y, -z)
  end

  sig { params(i: Integer).returns(T.nilable(Float)) }
  def [](i)
    @e[i]
  end

  sig { params(other: Vec3).returns(Vec3) }
  def +(other)
    Vec3.new(x + other.x, y + other.y, z + other.z)
  end

  sig { params(other: Vec3).returns(Vec3) }
  def -(other)
    Vec3.new(x - other.x, y - other.y, z - other.z)
  end

  sig { params(other: T.any(Vec3, Float)).returns(Vec3) }
  def *(other) # rubocop:disable Metrics/AbcSize
    case other
    when Vec3
      Vec3.new(x * other.x, y * other.y, z * other.z)
    when Float
      Vec3.new(x * other, y * other, z * other)
    end
  end

  sig { params(other: Float).returns(Vec3) }
  def /(other)
    (1 / other).multiple_with_vec3(self)
  end

  sig { returns(Float) }
  def length
    Math.sqrt(length_squared)
  end

  sig { returns(Float) }
  def length_squared
    (x * x) + (y * y) + (z * z)
  end

  sig { params(other: Vec3).returns(Float) }
  def dot(other)
    (x * other.x) + (y * other.y) + (z * other.z)
  end

  sig { params(other: Vec3).returns(Vec3) }
  def cross(other) # rubocop:disable Metrics/AbcSize
    Vec3.new((other.y * z) - (other.z * y),
             (other.z * x) - (other.x * z),
             (other.x * y) - (other.y * x))
  end

  sig { returns(Vec3) }
  def unit_vector
    self / length
  end

  sig { returns(Vec3) }
  def random_in_unit_sphere
    loop do
      p = Vec3.random(-1.0, 1.0)
      return p if p.length_squared < 1.0
    end
  end

  sig { returns(Vec3) }
  def random_unit_vector
    random_in_unit_sphere.unit_vector
  end

  sig { returns(Vec3) }
  def random_on_hemisphere
    on_unit_sphere = random_unit_vector
    if on_unit_sphere.dot(self) > 0.0 # In the same hemisphere as the normal
      on_unit_sphere
    else
      -on_unit_sphere
    end
  end

  sig { params(min: T.nilable(Float), max: T.nilable(Float)).returns(Vec3) }
  def self.random(min = nil, max = nil)
    if min && max
      Vec3.new(random_double(min, max), random_double(min, max), random_double(min, max))
    elsif min.nil? && max.nil?
      Vec3.new(random_double, random_double, random_double)
    else
      Kernel.raise ArgumentError, 'min and max must be both nil or both not nil'
    end
  end
end

# Point3 is just an alias for Vec3, but useful for geometric clarity in the code.
Point3 = Vec3
