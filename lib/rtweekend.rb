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
end
