require 'spec_helper'
require 'uri'

describe Incandescent::Page do

  before do
    client    = Incandescent::Client.new(ENV['INCANDESCENT_UID'], ENV['INCANDESCENT_API_KEY'])
    @image_url = 'https://c2.staticflickr.com/2/1164/1001998842_cdfc7708da_z.jpg?zz=1'

    VCR.use_cassette('Client#initiate_search') do
      client.add_image_url(@image_url)
      client.initiate_search
    end

    VCR.use_cassette('Client#get_results') do
      @hosts = client.get_results
    end
  end


  describe '#page' do
    let(:page) { @hosts.sample.pages.sample }

    it 'returns  the page where a matching image was found' do
      expect(page.page).to match DOMAIN_REGEX
      expect(page.page).to match URI::regexp
    end

  end

  describe '#source' do
    let(:page) { @hosts.sample.pages.sample }

    it 'returns a search source label from the known list of sources' do
      expect(Incandescent::Page::SOURCES.include?(page.source)).to be true
    end

  end

  describe '#date' do
    let(:page) { @hosts.sample.pages.sample }

    it 'returns a timestamp denoting when the image was found' do
      expect(page.date.to_s).to match /\A\d{10}\z/
    end

  end

  describe '#usage_image' do
    let(:page) { @hosts.sample.pages.sample }

    it 'returns a URL of the discovered image' do
      expect(page.usage_image).to match URI::regexp
    end
  end

  describe '#usage_height' do
    let(:page) { @hosts.sample.pages.sample }

    it 'returns the height of the discovered image' do
      expect(page.usage_height.to_i).to be > 0
    end
  end

  describe '#usage_width' do
    let(:page) { @hosts.sample.pages.sample }

    it 'returns the width of the discovered image' do
      expect(page.usage_width.to_i).to be > 0
    end
  end

  describe '#image' do
    let(:page) { @hosts.sample.pages.sample }

    it 'returns the URL of the original image to search' do
      expect(page.image).to match @image_url
    end
  end

  describe '#iid' do
    let(:page) { @hosts.sample.pages.sample }

    it 'returns the Incandescent ID for the match' do
      expect(page.iid).to match /\A\d+\z/
    end

  end

end