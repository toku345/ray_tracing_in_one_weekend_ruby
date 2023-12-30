# frozen_string_literal: true
# typed: true

require_relative 'vec3'

Color = Vec3

module ColorHelper
  extend T::Sig

  sig { params(input: IO, pixel_color: Color).void }
  def write_color(input, pixel_color)
    # Write the translated [0,255] value of each color component.
    ir = (255.999 * pixel_color.x).to_i
    ig = (255.999 * pixel_color.y).to_i
    ib = (255.999 * pixel_color.z).to_i

    input.puts "#{ir} #{ig} #{ib}"
  end
end
