# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative 'rtweekend'

require_relative 'color'
require_relative 'hittable'

class Camera
  extend T::Sig

  sig { void }
  def initialize # rubocop:disable Style/RedundantInitialize
    # TBD
  end

  sig { params(world: HittableList).void }
  def render(world)
    # TBD
  end

  private

  sig { void }
  def setup_camera
    # TBD
  end

  sig { params(r: Ray, world: HittableList).returns(Color) }
  def ray_color(r, world) # rubocop:disable Metrics/AbcSize
    rec = world.hit(r, Interval.new(0.0, INFINITY))
    return 0.5.multiple_with_vec3(T.must(rec.normal) + Color.new(1.0, 1.0, 1.0)) unless rec.nil?

    unit_direction = r.direction.unit_vector
    a = 0.5 * (unit_direction.y + 1.0)
    (1.0 - a).multiple_with_vec3(Color.new(1.0, 1.0, 1.0)) + a.multiple_with_vec3(Color.new(0.5, 0.7, 1.0))
  end
end
