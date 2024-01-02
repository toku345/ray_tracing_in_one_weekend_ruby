# frozen_string_literal: true
# typed: false

require_relative '../../lib/rtweekend'

class RtweekendHelperTester
  extend RtweekendHelper
end

RSpec.describe RtweekendHelper do
  describe '#degrees_to_radians' do
    it 'converts degrees to radians' do
      expect(RtweekendHelperTester.degrees_to_radians(90.0)).to eq(PI / 2.0)
    end
  end
end
