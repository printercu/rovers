RSpec.describe Rovers::Cli do
  describe 'bin/solution' do
    subject { `bin/solution #{file}` }

    context 'for example 1' do
      let(:file) { 'spec/fixtures/example1.txt' }
      it { should eq <<-TXT }
1 3 N
5 1 E
      TXT
    end
  end
end
