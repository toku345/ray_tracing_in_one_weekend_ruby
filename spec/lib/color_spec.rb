# frozen_string_literal: true
# typed: false

require 'spec_helper'

require_relative '../../lib/color'

RSpec.describe Color do
  describe '#write_color' do
    let(:input) { instance_double(IO) }

    before { allow(input).to receive(:puts) }

    it 'puts the color to IO' do
      color = described_class.new(0.5, 0.5, 0.5)

      write_color(input, color)
      expect(input).to have_received(:puts).with('127 127 127')
    end
  end
end
