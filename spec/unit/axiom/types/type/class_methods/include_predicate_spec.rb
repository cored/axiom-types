require 'spec_helper'

describe Axiom::Types::Type, '.include?' do
  subject { object.include?(value) }

  let(:value) { Object.new }

  context 'when the value matches the type constraint' do
    let(:object) { Class.new(described_class) }

    it { should be(true) }
  end

  context 'when the value does not match the type constraint' do
    let(:object) do
      Class.new(described_class) do
        constraint(proc { false })
      end
    end

    it { should be(false) }
  end

  context 'when the constraint does not return a boolean' do
    let(:object) do
      Class.new(described_class) do
        constraint(proc { nil })
      end
    end

    specify 'an exception is raised' do
      expect { subject }.to raise_error(
        TypeError,
        'constraint must return true or false, but was nil'
      )
    end
  end
end