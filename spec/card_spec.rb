require 'card'
describe Oystercard do 

  context 'I want money on my card' do

    it 'checks that a new oystercard is created with a balance of 0' do
      expect(subject.balance).to eq 0
    end

  end

  context 'I want to add money to my card' do

    it 'adds money to balance' do 
      subject.top_up(10)
      expect(subject).to respond_to(:top_up).with(1).argument
      expect(subject.balance).to eq(10)
    end

    

  end

end