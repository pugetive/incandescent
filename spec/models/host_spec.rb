require 'spec_helper'

describe Incandescent::Host do

  describe '#name' do
    let(:client)    { Incandescent::Client.new(ENV['INCANDESCENT_UID'], ENV['INCANDESCENT_API_KEY']) }
    let(:image_url) { 'https://c2.staticflickr.com/2/1164/1001998842_cdfc7708da_z.jpg?zz=1' }

    it 'should return the domain for this host' do
      initiate_search
      hosts = get_results

      hosts.each do |host|
        expect(host.name).to match /[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
      end
    end

  end

  describe '#pages' do
    let(:client)    { Incandescent::Client.new(ENV['INCANDESCENT_UID'], ENV['INCANDESCENT_API_KEY']) }
    let(:image_url) { 'https://c2.staticflickr.com/2/1164/1001998842_cdfc7708da_z.jpg?zz=1' }
    it "returns an array of Page items" do
      initiate_search
      hosts = get_results

      expect(hosts.sample.pages.size).to be > 0
      expect(hosts.sample.pages.first).to be_an_instance_of(Incandescent::Page)
    end
  end

  def initiate_search
    VCR.use_cassette('Client#initiate_search') do
      client.add_image_url(image_url)
      client.initiate_search
    end
  end

  def get_results
    VCR.use_cassette('Client#get_results') do
      client.get_results
    end
  end


end