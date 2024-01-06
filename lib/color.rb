# frozen_string_literal: true
# typed: strict

require_relative 'vec3'
require_relative 'interval'

Color = Vec3

module ColorHelper
  extend T::Sig

  sig { params(input: IO, pixel_color: Color, samples_per_pixel: Integer).void }
  def write_color(input, pixel_color, samples_per_pixel) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    r = pixel_color.x
    g = pixel_color.y
    b = pixel_color.z

    # Divide the color by the number of samples.
    scale = 1.0 / samples_per_pixel
    r *= scale
    g *= scale
    b *= scale

    # Write the translated [0,255] value of each color component.
    intensity = Interval.new(0.000, 0.999)
    ir = (256 * intensity.clamp(r)).to_i
    ig = (256 * intensity.clamp(g)).to_i
    ib = (256 * intensity.clamp(b)).to_i

    input.puts "#{ir} #{ig} #{ib}"
  end
end
