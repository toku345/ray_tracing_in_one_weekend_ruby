# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative 'rtweekend'

require_relative 'color'
require_relative 'hittable'

class Camera
  extend T::Sig

  include ColorHelper

  sig { params(aspect_ratio: Float, image_width: Integer).void }
  def initialize(aspect_ratio: 1.0, image_width: 100) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    @aspect_ratio = aspect_ratio
    @image_width = image_width

    @image_height = T.let((@image_width / @aspect_ratio).to_i, Integer)
    @image_height = 1 if @image_height < 1

    @center = T.let(Point3.new(0.0, 0.0, 0.0), Point3)

    # Determine the dimensions.
    focal_length = 1.0
    viewport_height = 2.0
    viewport_width = viewport_height * (@image_width.to_f / @image_height)

    # Calculate the vectors across the horizontal and down the vertical viewport edges.
    viewport_u = Vec3.new(viewport_width, 0.0, 0.0)
    viewport_v = Vec3.new(0.0, -viewport_height, 0.0)

    # Calculate the horizonal and vertical delta vectors from pixel to pixel.
    @pixel_delta_u = T.let(viewport_u / @image_width.to_f, Vec3)
    @pixel_delta_v = T.let(viewport_v / @image_height.to_f, Vec3)

    # Calculate the location of the upper left pixel.
    @viewport_upper_left =
      T.let(@center - Vec3.new(0.0, 0.0, focal_length) - (viewport_u / 2.0) - (viewport_v / 2.0),
            Vec3)
    @pixel00_loc =
      T.let(@viewport_upper_left + 0.5.multiple_with_vec3(@pixel_delta_u + @pixel_delta_v), Point3)
  end

  sig { params(world: HittableList).void }
  def render(world) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    print <<~HEADER
      P3
      #{@image_width} #{@image_height}
      255
    HEADER

    @image_height.times do |j|
      $stderr.print "\rScanlines remaining: #{@image_height - j}", ' '
      $stderr.flush

      @image_width.times do |i|
        pixel_center =
          @pixel00_loc + i.to_f.multiple_with_vec3(@pixel_delta_u) + j.to_f.multiple_with_vec3(@pixel_delta_v)
        ray_direction = pixel_center - @center
        r = Ray.new(@center, ray_direction)

        pixel_color = ray_color(r, world)
        write_color($stdout, pixel_color)
      end
    end

    warn "\rDone.                 \n"
  end

  private

  sig { params(r: Ray, world: HittableList).returns(Color) }
  def ray_color(r, world) # rubocop:disable Metrics/AbcSize
    rec = world.hit(r, Interval.new(0.0, INFINITY))
    return 0.5.multiple_with_vec3(T.must(rec.normal) + Color.new(1.0, 1.0, 1.0)) unless rec.nil?

    unit_direction = r.direction.unit_vector
    a = 0.5 * (unit_direction.y + 1.0)
    (1.0 - a).multiple_with_vec3(Color.new(1.0, 1.0, 1.0)) + a.multiple_with_vec3(Color.new(0.5, 0.7, 1.0))
  end
end
