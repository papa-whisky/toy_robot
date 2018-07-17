require_relative '../../../lib/toy_robot/robot'

RSpec.describe ToyRobot::Robot do
  let(:robot) { described_class.new }

  describe '#place' do
    let(:position) { { x: 1, y: 2, bearing: 'EAST' } }
    subject { robot.place(position: position) }

    it 'sets the x position' do
      expect { subject }.to change(robot, :x_pos).from(nil).to(position[:x])
    end

    it 'sets the y position' do
      expect { subject }.to change(robot, :y_pos).from(nil).to(position[:y])
    end

    it 'sets the bearing' do
      expect { subject }.to change(robot, :bearing)
        .from(nil).to(position[:bearing])
    end
  end

  describe '#move' do
    before { robot.place(position: { x: 2, y: 2, bearing: bearing }) }
    subject { robot.move }

    movements = [
      { bearing: 'NORTH', changes: :y_pos, difference: 1 },
      { bearing: 'EAST', changes: :x_pos, difference: 1 },
      { bearing: 'SOUTH', changes: :y_pos, difference: -1 },
      { bearing: 'WEST', changes: :x_pos, difference: -1 }
    ]

    movements.each do |movement|
      context "when facing #{movement[:bearing]}" do
        let(:bearing) { movement[:bearing] }

        it "changes #{movement[:changes]} by #{movement[:difference]}" do
          expect { subject }.to change(robot, movement[:changes])
            .by(movement[:difference])
        end
      end
    end
  end

  describe '#left' do
    before { robot.place(position: { x: 2, y: 2, bearing: bearing }) }
    subject { robot.left }

    turns = [
      { initial: 'NORTH', final: 'WEST' },
      { initial: 'EAST', final: 'NORTH' },
      { initial: 'SOUTH', final: 'EAST' },
      { initial: 'WEST', final: 'SOUTH' }
    ]

    turns.each do |turn|
      context "when facing #{turn[:initial]}" do
        let(:bearing) { turn[:initial] }

        it 'turns left' do
          expect { subject }.to change(robot, :bearing)
            .from(turn[:initial]).to(turn[:final])
        end
      end
    end
  end

  describe '#right' do
    before { robot.place(position: { x: 2, y: 2, bearing: bearing }) }
    subject { robot.right }

    turns = [
      { initial: 'NORTH', final: 'EAST' },
      { initial: 'EAST', final: 'SOUTH' },
      { initial: 'SOUTH', final: 'WEST' },
      { initial: 'WEST', final: 'NORTH' }
    ]

    turns.each do |turn|
      context "when facing #{turn[:initial]}" do
        let(:bearing) { turn[:initial] }

        it 'turns right' do
          expect { subject }.to change(robot, :bearing)
            .from(turn[:initial]).to(turn[:final])
        end
      end
    end
  end

  describe '#report' do
    before { robot.place(position: { x: 3, y: 4, bearing: 'EAST' }) }
    subject { robot.report }

    specify { expect { subject }.to output("3,4,EAST\n").to_stdout }
  end

  describe '#placed?' do
    subject { robot.placed? }

    context 'when robot is placed' do
      before { robot.place(position: { x: 0, y: 3, bearing: 'SOUTH' }) }
      it { is_expected.to eq true }
    end

    context 'when robot is not placed' do
      it { is_expected.to eq false }
    end
  end

  describe '#position_after_move' do
    before { robot.place(position: { x: 2, y: 2, bearing: bearing }) }
    subject { robot.position_after_move }

    movements = [
      { bearing: 'NORTH', result: { x: 2, y: 3 } },
      { bearing: 'EAST', result: { x: 3, y: 2 } },
      { bearing: 'SOUTH', result: { x: 2, y: 1 } },
      { bearing: 'WEST', result: { x: 1, y: 2 } }
    ]

    movements.each do |movement|
      context "when facing #{movement[:bearing]}" do
        let(:bearing) { movement[:bearing] }

        it { is_expected.to eq movement[:result] }
      end
    end
  end
end
