# frozen_string_literal: true

require 'spec_helper'

describe Kernel do
  describe '.UUID' do
    it 'is removed' do
      expect { UUID }.to raise_error(NameError)
    end
  end
end
