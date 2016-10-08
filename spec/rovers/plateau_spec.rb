RSpec.describe Rovers::Plateau do
  let(:instance) { described_class.new(width, length) }
  let(:width) { 7 }
  let(:length) { 10 }

  subject { instance }
  its(:width) { should eq width }
  its(:length) { should eq length }
  its(:rovers) { should eq [] }

  describe '#add_rover' do
    subject { -> { instance.add_rover(*args) } }
    let(:args) { [3, 4, 'E'] }
    let(:rover) { double(:rover) }
    before { expect(Rovers::Rover).to receive(:new).with(instance, *args) { rover } }
    it { should change(instance, :rovers).from([]).to([rover]) }
    its(:call) { should eq rover }
  end
end
