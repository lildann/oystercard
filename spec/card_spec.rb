require 'card'
describe Oystercard do

  context 'when putting money on my card' do

    it 'starts with a balance of 0' do
      expect(subject.balance).to eq 0
    end

    it 'adds money to balance' do 
      expect(subject).to respond_to(:top_up).with(1).argument
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end

    it 'raises an error when the top up amount exceeds the £90 limit' do
      expect(described_class::BALANCE_LIMIT).to eq 90
      expect { subject.top_up(91) }.to raise_error "Top up amount exceeds £#{described_class::BALANCE_LIMIT}"
    end

  end

  context "when deducting money from my card" do

    it 'deducts money from my balance' do
      expect(subject).to respond_to(:deduct).with(1).argument
      subject.top_up(10)
      subject.deduct(5)
      expect(subject.balance).to eq(5)
    end

  end

  context "when travelling" do
    
    it 'when not on a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'when card touches in user is on a journey' do
      expect(subject).to respond_to(:touch_in)
      subject.touch_in 
      expect(subject).to be_in_journey
    end

    it 'when card touches out, user is not on a journey' do
      expect(subject).to respond_to(:touch_out)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

end
