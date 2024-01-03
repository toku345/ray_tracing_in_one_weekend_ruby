# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative 'rtweekend'

class Interval
  extend T::Sig

  sig { returns(Float) }
  attr_reader :min

  sig { returns(Float) }
  attr_reader :max

  # NOTE: Default interval is empty.
  sig { params(min: Float, max: Float).void }
  def initialize(min = +INFINITY, max = -INFINITY)
    @min = min
    @max = max
  end

  sig { params(x: Float).returns(T::Boolean) }
  def contains(x)
    @min <= x && x <= @max
  end

  sig { params(x: Float).returns(T::Boolean) }
  def surrounds(x)
    @min < x && x < @max
  end
end

EMPTY = Interval.new(+INFINITY, -INFINITY)
UNIVERSE = Interval.new(-INFINITY, +INFINITY)
