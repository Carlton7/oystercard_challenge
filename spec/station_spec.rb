require 'station'

describe Station do
    subject { described_class.new('aldgate', 3) }

    it 'will initialize with a name' do
        expect(subject.station_name).to eq('aldgate')
    end

    it 'will initialize with a zone' do
        expect(subject.zone).to eq(3)
    end
end 