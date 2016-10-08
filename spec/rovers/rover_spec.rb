RSpec.describe Rovers::Rover do
  let(:instance) { plateau.add_rover(*position) }
  let(:plateau) { Rovers::Plateau.new(plateau_width, plateau_length) }
  let(:plateau_width) { 5 }
  let(:plateau_length) { 5 }
  let(:position) { [x, y, orientation] }
  let(:x) { 2 }
  let(:y) { 1 }
  let(:orientation) { 'E' }

  describe '#initialize' do
    let(:subject) { instance }
    its(:plateau) { should eq plateau }
    its(:x) { should eq x }
    its(:y) { should eq y }
    its(:orientation) { should eq orientation }
    its(:position) { should eq position }

    context 'when orientation is invalid' do
      let(:orientation) { 'A' }
      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe 'turn_left' do
    subject { -> { instance.turn_left } }

    it 'changes orientation counterclockwise' do
      {
        'E' => 'N',
        'N' => 'W',
        'W' => 'S',
        'S' => 'E',
      }.each do |from, to|
        should change(instance, :orientation).from(from).to(to)
      end
      should change(instance, :orientation).from('E').to('N')
    end
  end

  describe 'turn_right' do
    subject { -> { instance.turn_right } }

    it 'changes orientation clockwise' do
      {
        'E' => 'S',
        'S' => 'W',
        'W' => 'N',
        'N' => 'E',
      }.each do |from, to|
        should change(instance, :orientation).from(from).to(to)
      end
      should change(instance, :orientation).from('E').to('S')
    end
  end

  describe '#move' do
    subject { -> { instance.move } }

    context 'when orientation is E' do
      let(:orientation) { 'E' }
      it { should change(instance, :x).by(1) }
      it { should_not change(instance, :y) }
    end

    context 'when orientation is W' do
      let(:orientation) { 'W' }
      it { should change(instance, :x).by(-1) }
      it { should_not change(instance, :y) }
    end

    context 'when orientation is N' do
      let(:orientation) { 'N' }
      it { should change(instance, :y).by(1) }
      it { should_not change(instance, :x) }
    end

    context 'when orientation is S' do
      let(:orientation) { 'S' }
      it { should change(instance, :y).by(-1) }
      it { should_not change(instance, :x) }
    end
  end

  describe '#process_instructions' do
    subject { -> { instance.process_instructions(instructions) } }
    let(:instructions) { 'LMRMMRR' }
    it { should change(instance, :x).by(2) }
    it { should change(instance, :y).by(1) }
    it { should change(instance, :orientation).to('W') }

    context 'when moving around' do
      let(:instructions) { 'MLMMRMRMMMRMMRM' }
      it { should_not change(instance, :x) }
      it { should_not change(instance, :y) }
      it { should change(instance, :orientation).to('N') }
    end

    context 'for example 1' do
      let(:position) { [1, 2, 'N'] }
      let(:instructions) { 'LMLMLMLMM' }
      it { should change(instance, :position).to([1, 3, 'N']) }
    end

    context 'for example 2' do
      let(:position) { [3, 3, 'E'] }
      let(:instructions) { 'MMRMMRMRRM' }
      it { should change(instance, :position).to([5, 1, 'E']) }
    end

    context 'when invalid instruction is given' do
      let(:instructions) { 'LRMALRM' }
      it { should raise_error(described_class::InvalidInstruction) }
    end
  end
end
