#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: true

require_relative 'lib/vec3'
require_relative 'lib/color'

IMAGE_WIDTH = 256
IMAGE_HEIGHT = 256

if __FILE__ == $PROGRAM_NAME
  print <<~HEADER
    P3
    #{IMAGE_WIDTH} #{IMAGE_HEIGHT}
    255
  HEADER

  IMAGE_HEIGHT.times do |j|
    $stderr.print "\rScanlines remaining: #{IMAGE_HEIGHT - j}", ' '
    $stderr.flush

    IMAGE_WIDTH.times do |i|
      pixel_color = Color.new(i.to_f / (IMAGE_WIDTH - 1), j.to_f / (IMAGE_HEIGHT - 1), 0.0)
      pixel_color.write_color($stdout)
    end
  end

  warn "\rDone.                 \n"
end
