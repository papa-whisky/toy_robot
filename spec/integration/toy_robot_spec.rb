require_relative '../../lib/toy_robot'

RSpec.describe ToyRobot do
  describe '.run' do
    subject { ToyRobot.run }

    before do
      # Allow loop to run the required number of times only
      stub = allow(ToyRobot).to receive(:loop)
      inputs.length.times { stub.and_yield }

      allow(ToyRobot).to receive(:gets).and_return(*inputs)
    end

    context 'with inputs PLACE 0,0,NORTH MOVE REPORT' do
      let(:inputs) { %W[PLACE\ 0,0,NORTH\n MOVE\n REPORT\n] }
      specify { expect { subject }.to output("0,1,NORTH\n").to_stdout }
    end

    context 'with inputs PLACE 0,0,NORTH LEFT REPORT' do
      let(:inputs) { %W[PLACE\ 0,0,NORTH\n LEFT\n REPORT\n] }
      specify { expect { subject }.to output("0,0,WEST\n").to_stdout }
    end

    context 'with inputs PLACE 1,2,EAST MOVE MOVE LEFT MOVE REPORT' do
      let(:inputs) do
        %W[PLACE\ 1,2,EAST\n MOVE\n MOVE\n LEFT\n MOVE\n REPORT\n]
      end

      specify { expect { subject }.to output("3,3,NORTH\n").to_stdout }
    end
  end
end
