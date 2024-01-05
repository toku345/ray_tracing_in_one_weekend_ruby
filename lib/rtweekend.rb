# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative 'ray'
require_relative 'vec3'

INFINITY = Float::INFINITY
PI = 3.1415926535897932385

module RtweekendHelper
  extend T::Sig

  sig { params(degrees: Float).returns(Float) }
  def degrees_to_radians(degrees)
    degrees * PI / 180.0
  end

  sig { params(min: T.nilable(Float), max: T.nilable(Float)).returns(Float) }
  def random_double(min = nil, max = nil)
    if min && max
      # Returns a random real in [min,max).
      Random.rand(min...max)
    elsif min.nil? && max.nil?
      # Returns a random real in [0,1).
      Random.rand(0.0...1.0)
    else
      Kernel.raise ArgumentError, 'Invalid arguments to random_double.'
    end
  end
end
