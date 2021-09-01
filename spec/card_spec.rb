require 'card'
describe Oystercard do

  it { is_expected.to respond_to(:top_up).with(1).argument }
  it { is_expected.to respond_to(:deduct).with(1).argument }
  it { is_expected.to respond_to(:touch_in) }
  it { is_expected.to respond_to(:touch_out) }

  context 'money on card' do
    it 'starts with a balance of 0' do
      expect(subject.balance).to eq 0
    end

    it 'adds money to balance' do 
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end

    it 'raises an error when the top up amount exceeds the £90 limit' do
      expect(described_class::BALANCE_LIMIT).to eq 90
      expect { subject.top_up(91) }.to raise_error "Top up amount exceeds £#{described_class::BALANCE_LIMIT}"
    end

    it 'deducts money from balance' do
      subject.top_up(10)
      subject.deduct(5)
      expect(subject.balance).to eq(5)
    end
  end

  context "when travelling" do
    # before do
    #   subject.top_up(described_class::BALANCE_LIMIT)
    # end
    
    it 'when not on a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'raise error if balance is to low to start journey' do
      expect { subject.touch_in }.to raise_error "Not enough funds on card"
      expect(subject).not_to be_in_journey
      #raising error 
    end

    it 'touching in, user is on a journey' do
      expect(subject).to be_in_journey
    end

    it 'touching out, user is not on a journey' do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

end
