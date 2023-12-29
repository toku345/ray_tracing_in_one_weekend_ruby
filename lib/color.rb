# frozen_string_literal: true
# typed: true

require_relative 'vec3'

extend T::Sig # rubocop:disable Style/MixinUsage

Color = Vec3

sig { params(input: IO, color: Color).void }
def write_color(input, color)
  # Write the translated [0,255] value of each color component.
  ir = (255.999 * color.x).to_i
  ig = (255.999 * color.y).to_i
  ib = (255.999 * color.z).to_i

  input.puts "#{ir} #{ig} #{ib}"
end
