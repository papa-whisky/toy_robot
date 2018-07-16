require_relative '../../../lib/toy_robot/simulator'

RSpec.describe ToyRobot::Simulator do
  let(:simulator) { described_class.new }
  let(:robot) { simulator.instance_variable_get(:@robot) }

  describe '#execute' do
    let(:params) { nil }
    subject { simulator.execute(command: command, params: params) }

    context 'when robot is not placed' do
      before { allow(robot).to receive(:placed?).and_return(false) }

      context 'with PLACE command' do
        let(:command) { 'PLACE' }

        context 'with valid coordinates' do
          let(:params) { { x: 0, y: 3, bearing: 'NORTH' } }

          it 'calls :place on the robot' do
            expect(robot).to receive(:place).with(position: params)
            subject
          end
        end

        context 'with invalid coordinates' do
          let(:params) { { x: 4, y: -1, bearing: 'NORTH' } }

          it 'does not call :place on the robot' do
            expect(robot).to_not receive(:place)
            subject
          end
        end
      end

      %w[MOVE LEFT RIGHT REPORT].each do |invalid_command|
        context "with #{invalid_command} command" do
          let(:command) { invalid_command }

          it "does not call :#{invalid_command.downcase} on the robot" do
            expect(robot).to_not receive(invalid_command.downcase.to_sym)
            subject
          end
        end
      end
    end

    context 'when robot is placed' do
      before { allow(robot).to receive(:placed?).and_return(true) }

      context 'with PLACE command' do
        let(:command) { 'PLACE' }

        context 'with valid coordinates' do
          let(:params) { { x: 2, y: 0, bearing: 'SOUTH' } }

          it 'calls :place on the robot' do
            expect(robot).to receive(:place).with(position: params)
            subject
          end
        end

        context 'with invalid coordinates' do
          let(:params) { { x: 5, y: 1, bearing: 'EAST' } }

          it 'does not call :place on the robot' do
            expect(robot).to_not receive(:place)
            subject
          end
        end
      end

      context 'with MOVE command' do
        let(:command) { 'MOVE' }

        [{ x: 0, y: -1 }, { x: 5, y: 3 }].each do |invalid_coords|
          context 'when move would result in invalid coordinates' do
            before do
              allow(robot).to receive(:position_after_move)
                .and_return(invalid_coords)
            end

            it 'does not call :move on the robot' do
              expect(robot).to_not receive(:move)
              subject
            end
          end
        end

        [{ x: 0, y: 1 }, { x: 3, y: 4 }].each do |valid_coords|
          context 'when move would result in valid coordinates' do
            before do
              allow(robot).to receive(:position_after_move)
                .and_return(valid_coords)
            end

            it 'calls :move on the robot' do
              expect(robot).to receive(:move)
              subject
            end
          end
        end
      end

      %w[LEFT RIGHT REPORT].each do |valid_command|
        context "with #{valid_command} command" do
          let(:command) { valid_command }

          it "calls :#{valid_command.downcase} on the robot" do
            expect(robot).to receive(valid_command.downcase.to_sym)
            subject
          end
        end
      end
    end
  end
end
