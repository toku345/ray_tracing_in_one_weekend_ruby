# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

require_relative 'hittable'

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

  sig { params(r: Ray, ray_tmin: Float, ray_tmax: Float).returns(T.nilable(HitRecord)) }
  def hit(r, ray_tmin, ray_tmax)
    closest_so_far = ray_tmax
    rec = T.let(nil, T.nilable(HitRecord))

    @objects.each do |object|
      rec = object.hit(r, ray_tmin, closest_so_far)
      closest_so_far = rec.t if rec
    end

    rec
  end
end
