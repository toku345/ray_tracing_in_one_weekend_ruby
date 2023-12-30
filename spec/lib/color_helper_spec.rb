# frozen_string_literal: true
# typed: false

require 'spec_helper'

require_relative '../../lib/color'

class ColorHelperTester
  extend ColorHelper
end

RSpec.describe ColorHelper do
  describe '.write_color' do
    let(:input) { instance_double(IO) }

    before { allow(input).to receive(:puts) }

    it 'puts the color to IO' do
      color = Color.new(0.5, 0.5, 0.5)

      ColorHelperTester.write_color(input, color)
      expect(input).to have_received(:puts).with('127 127 127')
    end
  end
end
