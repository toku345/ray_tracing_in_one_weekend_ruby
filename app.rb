#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: true

require_relative 'lib/color'
require_relative 'lib/ray'
require_relative 'lib/vec3'

module App
  extend ColorHelper

  class << self
    extend T::Sig

    sig { params(center: Point3, radius: Float, r: Ray).returns(Float) }
    def hit_sphere(center, radius, r) # rubocop:disable Metrics/AbcSize
      oc = r.origin - center
      a = r.direction.length_squared
      half_b = oc.dot(r.direction)
      c = oc.length_squared - (radius * radius)
      discriminant = (half_b * half_b) - (a * c)

      return -1.0 if discriminant.negative?

      (-half_b - Math.sqrt(discriminant)) / a
    end

    sig { params(r: Ray).returns(Color) }
    def ray_color(r) # rubocop:disable Metrics/AbcSize
      t = hit_sphere(Point3.new(0.0, 0.0, -1.0), 0.5, r)
      if t > 0.0
        n = (r.at(t) - Vec3.new(0.0, 0.0, -1.0)).unit_vector
        return 0.5.multiple_with_vec3(Color.new(n.x + 1, n.y + 1, n.z + 1))
      end

      unit_direction = r.direction.unit_vector
      a = 0.5 * (unit_direction.y + 1.0)
      (1.0 - a).multiple_with_vec3(Color.new(1.0, 1.0, 1.0)) + a.multiple_with_vec3(Color.new(0.5, 0.7, 1.0))
    end

    sig { void }
    def main # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      # Image
      aspect_ratio = 16.0 / 9.0
      image_width = 400

      # Calculate the image height, and ensure that is' at least 1.
      image_height = (image_width / aspect_ratio).to_i
      image_height = 1 if image_height < 1

      # Camera
      focal_legth = 1.0
      viewport_height = 2.0
      viewport_width = viewport_height * (image_width.to_f / image_height)
      camera_center = Point3.new(0.0, 0.0, 0.0)

      # Calculate the vectors across the horizontal and down the vertical viewport edges.
      viewport_u = Vec3.new(viewport_width, 0.0, 0.0)
      viewport_v = Vec3.new(0.0, -viewport_height, 0.0)

      # Calculate the horizonal and vertical delta vectors from pixel to pixel.
      pixel_delta_u = viewport_u / image_width.to_f
      pixel_delta_v = viewport_v / image_height.to_f

      # Calculate the location of the upper left pixel.
      viewport_upper_left =
        camera_center - Vec3.new(0.0, 0.0, focal_legth) - (viewport_u / 2.0) - (viewport_v / 2.0)
      pixel100_loc = viewport_upper_left + 0.5.multiple_with_vec3(pixel_delta_u + pixel_delta_v)

      # Render

      print <<~HEADER
        P3
        #{image_width} #{image_height}
        255
      HEADER

      image_height.times do |j|
        $stderr.print "\rScanlines remaining: #{image_height - j}", ' '
        $stderr.flush

        image_width.times do |i|
          pixel_center =
            pixel100_loc + i.to_f.multiple_with_vec3(pixel_delta_u) + j.to_f.multiple_with_vec3(pixel_delta_v)
          ray_direction = pixel_center - camera_center
          r = Ray.new(camera_center, ray_direction)

          pixel_color = ray_color(r)
          write_color($stdout, pixel_color)
        end
      end

      warn "\rDone.                 \n"
    end
  end
end

App.main if __FILE__ == $PROGRAM_NAME
