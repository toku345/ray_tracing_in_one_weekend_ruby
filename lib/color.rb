# frozen_string_literal: true
# typed: true

require_relative 'vec3'

class Color < Vec3
  extend T::Sig

  sig { params(input: IO).void }
  def write_color(input)
    # Write the translated [0,255] value of each color component.
    ir = (255.999 * x).to_i
    ig = (255.999 * y).to_i
    ib = (255.999 * z).to_i

    input.puts "#{ir} #{ig} #{ib}"
  end
end
