# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative 'rtweekend'
require_relative 'interval'
require_relative 'hittable'
require_relative 'sphere'

class HittableList
  extend T::Sig

  include Hittable

  sig { returns(T::Array[Hittable]) }
  attr_reader :objects

  sig { params(object: T.nilable(Hittable)).void }
  def initialize(object = nil)
    @objects = T.let([], T::Array[Hittable])
    @objects << object if object
  end

  sig { void }
  def clear
    @objects.clear
  end

  sig { params(object: Hittable).void }
  def add(object)
    @objects << object
  end

  sig { params(r: Ray, ray_t: Interval).returns(T.nilable(HitRecord)) }
  def hit(r, ray_t)
    closest_so_far = ray_t.max
    rec = T.let(nil, T.nilable(HitRecord))

    @objects.each do |object|
      temp_rec = object.hit(r, Interval.new(ray_t.min, closest_so_far))
      if temp_rec
        closest_so_far = temp_rec.t
        rec = temp_rec
      end
    end

    rec
  end
end
