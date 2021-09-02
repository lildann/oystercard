require 'card'
describe Oystercard do

  it { is_expected.to respond_to(:top_up).with(1).argument }
  it { is_expected.to respond_to(:touch_in).with(1).argument } 
  it { is_expected.to respond_to(:touch_out) }

  let(:station) { "Waterloo" }

  context 'card balance' do
    it 'starts with a balance of 0' do
      expect(subject.balance).to eq 0
    end

    it 'adds money to balance' do 
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'error when balance exceeds £90 limit' do
      expect(described_class::BALANCE_LIMIT).to eq 90
      expect { subject.top_up(91) }.to raise_error "Balance exceeded: £#{described_class::BALANCE_LIMIT}"
    end
  end

  context "when travelling" do
    it 'if not on journey' do
      expect(subject).not_to be_in_journey
    end

    it 'error if balance is too low to start journey' do
      expect { subject.touch_in(station) }.to raise_error "Not enough funds on card"
      expect(subject).not_to be_in_journey
    end

    it 'touch in, user is on journey' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'touch out, user is not on journey' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'deducts fare when touching out' do
      subject.top_up(10)
      subject.touch_in(station)
      expect{ subject.touch_out }.to change{ subject.balance }.by(-described_class::FARE)
    end

    it 'stores starting station when touching in' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.starting_station).to eq(station)
    end
  end
end



    
  # before do
  #   subject.top_up(described_class::BALANCE_LIMIT)
  # end


  # Tests no longer needed for #deduct method - moved to private method (protected)
    # it { is_expected.to respond_to(:deduct).with(1).argument }  
    # it 'deducts money from balance' do
    #   subject.top_up(10)
    #   subject.deduct(5)
    #   expect(subject.balance).to eq(5)
    # end