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

  context "is the user on a journey" do
    
    it 'when not on a journey' do
      expect(subject.in_journey?).to eq false
    end

    it 'when card touches in' do
      expect(subject).to respond_to(:touch_in)
      expect{ subject.touch_in }.to change(subject.in_journey?).to true
    end
  end

end


end
