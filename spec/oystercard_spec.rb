require 'oystercard'
# require 'money'

# in spec/oystercard_spec.rb
describe Oystercard do

  let(:station) {double:station}

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect{ subject.top_up(1) }.to change{ subject.balance }.by 1
    end

    it 'raises error if maximum balance limit of $90 reached' do
      subject.top_up(90)
      expect { subject.top_up(1) }.to raise_error 'Cannot input that amount! Maximum balance of $90 will be exceeded'
    end
  end

  describe '#touch_in' do

    it 'should not allow user onto train if card balance does not have minimum fare' do
      expect { subject.touch_in(station) }.to raise_error 'not enough funds (minimum fare £1)'
    end

    it 'Oystercard should remember entry station after #touch_in' do
      subject.top_up(1)
      subject.touch_in(station=nil)
      expect(subject.entry_station).to eq(station)
    end

  end

  describe '#touch_out' do
    # it 'should return nil if not in journey' do
    #   expect(subject.touch_out(:station)).to be nil
    # end

    it 'should charge minimum fare when touching out' do
      subject.top_up(1)
      expect {subject.touch_out(station)}.to change{subject.balance}.by(-1)
    end

    it 'should receive exit_station argument' do
      subject.touch_out(station)
      expect(subject.exit_station).to eq(station)
    end
  end

  describe '#journey' do 
    it 'should record the entry and exit station' do 
      expect(subject.journey).to eq({@entry_station => @exit_station})
    end 

    it 'should check that the card has an empty list of journeys by default' do
      expect(subject.list).to eq([])
    end

    it 'should write a test that checks that touching in and out creates one journey' do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journey).to be_an_instance_of(Hash)
    end

  end

  describe '#in_journey?' do
    it 'should return true if in journey' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.in_journey?).to be true
    end

    it 'should return false if not in journey' do
      subject.touch_out(station)
      expect(subject.in_journey?).to be false
    end
  end


end


  # describe '#deduct' do
  #   it 'should deduct money from balance' do
  #   subject.top_up(10)
  #   subject.deduct(5)
  #   expect(subject.balance).to eq(5)
  #   end
  # end

# ISSUE COMMENTS - NameError: uninitialized constant Oystercard
# File path = ./spec/oystercard_spec
# LINE OF ERROR = # ./spec/oystercard_spec.rb:2:in `<top (required)>'
