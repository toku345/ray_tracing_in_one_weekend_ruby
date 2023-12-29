# frozen_string_literal: true
# typed: true

require_relative 'vec3'

require 'sorbet-runtime'

class Float
  extend T::Sig

  sig { params(other: Vec3).returns(Vec3) }
  def multiple_with_vec3(other)
    Vec3.new(self * other.x, self * other.y, self * other.z)
  end
end
