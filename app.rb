#!/usr/bin/env ruby
# frozen_string_literal: true

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
      r = i.to_f / (IMAGE_WIDTH - 1)
      g = j.to_f / (IMAGE_HEIGHT - 1)
      b = 0

      ir = (255.999 * r).to_i
      ig = (255.999 * g).to_i
      ib = (255.999 * b).to_i

      puts "#{ir} #{ig} #{ib}"
    end
  end

  warn "\rDone.                 \n"
end
