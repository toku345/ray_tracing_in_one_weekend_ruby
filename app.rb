#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strict

require_relative 'lib/rtweekend'

require_relative 'lib/camera'
require_relative 'lib/hittable_list'
require_relative 'lib/sphere'

module App
  extend ColorHelper
  extend RtweekendHelper

  class << self
    extend T::Sig

    sig { void }
    def main
      world = HittableList.new

      world.add(Sphere.new(Point3.new(0.0, 0.0, -1.0), 0.5))
      world.add(Sphere.new(Point3.new(0.0, -100.5, -1.0), 100.0))

      cam = Camera.new(
        aspect_ratio: 16.0 / 9.0,
        image_width: 400,
        samples_per_pixel: 100,
        max_depth: 50
      )

      cam.render(world)
    end
  end
end

App.main if __FILE__ == $PROGRAM_NAME
