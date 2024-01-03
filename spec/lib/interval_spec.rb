# frozen_string_literal: true
# typed: false

require_relative '../../lib/interval'

RSpec.describe Interval do
  describe '#initialize' do
    context 'when no arguments are given' do
      it 'creates an empty interval' do
        expect(described_class.new.contains(0.0)).to be(false)
      end
    end
  end

  describe '#contains' do
    context 'when the value is in the interval' do
      it 'returns true' do # rubocop:disable RSpec/MultipleExpectations
        expect(described_class.new(0.0, 1.0).contains(0.0)).to be(true)
        expect(described_class.new(0.0, 1.0).contains(1.0)).to be(true)
      end
    end

    context 'when the value is not in the interval' do
      it 'returns false' do # rubocop:disable RSpec/MultipleExpectations
        expect(described_class.new(0.0, 1.0).contains(-0.1)).to be(false)
        expect(described_class.new(0.0, 1.0).contains(1.1)).to be(false)
      end
    end
  end

  describe '#surrounds' do
    context 'when the interval surrounds the other interval' do
      it 'returns true' do # rubocop:disable RSpec/MultipleExpectations
        expect(described_class.new(0.0, 1.0).surrounds(0.1)).to be(true)
        expect(described_class.new(0.0, 1.0).surrounds(0.9)).to be(true)
      end
    end

    context 'when the interval does not surround the other interval' do
      it 'returns false' do # rubocop:disable RSpec/MultipleExpectations
        expect(described_class.new(0.0, 1.0).surrounds(0.0)).to be(false)
        expect(described_class.new(0.0, 1.0).surrounds(1.0)).to be(false)
      end
    end
  end
end
