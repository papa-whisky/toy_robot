require_relative '../../../lib/toy_robot/input'

RSpec.describe ToyRobot::Input do
  describe '#command' do
    subject { described_class.new(input).command }

    context 'with input MOVE' do
      let(:input) { 'MOVE' }
      it { is_expected.to eq('MOVE') }
    end

    context 'with input PLACE 0,0,NORTH' do
      let(:input) { 'PLACE 0,0,NORTH' }
      it { is_expected.to eq('PLACE') }
    end
  end

  describe '#params' do
    subject { described_class.new(input).params }

    context 'with input MOVE' do
      let(:input) { 'MOVE' }
      it { is_expected.to be_nil }
    end

    context 'with input PLACE 0,0,NORTH' do
      let(:input) { 'PLACE 0,0,NORTH' }
      it { is_expected.to eq(x: 0, y: 0, bearing: 'NORTH') }
    end
  end
end
