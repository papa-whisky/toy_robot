require_relative '../../../lib/toy_robot/input'

RSpec.describe ToyRobot::Input do
  let(:input) { described_class.new(user_input) }

  describe '#command' do
    subject { input.command }

    context 'with user input MOVE' do
      let(:user_input) { 'MOVE' }
      it { is_expected.to eq('MOVE') }
    end

    context 'with user input PLACE 0,0,NORTH' do
      let(:user_input) { 'PLACE 0,0,NORTH' }
      it { is_expected.to eq('PLACE') }
    end
  end

  describe '#params' do
    subject { input.params }

    context 'with user input MOVE' do
      let(:user_input) { 'MOVE' }
      it { is_expected.to be_nil }
    end

    context 'with user input PLACE 0,0,NORTH' do
      let(:user_input) { 'PLACE 0,0,NORTH' }
      it { is_expected.to eq(x: 0, y: 0, bearing: 'NORTH') }
    end
  end

  describe '#valid?' do
    subject { input.valid? }

    context 'with valid user input' do
      valid_inputs = %w[PLACE\ 3,2,SOUTH MOVE LEFT RIGHT REPORT]

      valid_inputs.each do |valid_input|
        context "with user input #{valid_input}" do
          let(:user_input) { valid_input }
          it { is_expected.to eq true }
        end
      end
    end

    context 'with invalid input' do
      invalid_inputs = \
        %w[FOO BAR move PLACE PLACE\ one,two,NORTH PLACE\ 0,1,UP RIGHT\ MOVE]

      invalid_inputs.each do |invalid_input|
        context "with user input #{invalid_input}" do
          let(:user_input) { invalid_input }
          it { is_expected.to eq false }
        end
      end
    end
  end
end
