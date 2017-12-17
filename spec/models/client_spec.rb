require 'spec_helper'

describe Incandescent::Client do

  describe '#add_image_url' do
    let(:client)    { Incandescent::Client.new(ENV['INCANDESCENT_UID'], ENV['INCANDESCENT_API_KEY']) }
    let(:image_url) { 'https://c2.staticflickr.com/2/1164/1001998842_cdfc7708da_z.jpg?zz=1' }

    it 'adds an image URL into the queue' do
      client.add_image_url(image_url)

      expect(client.image_urls.size).to eq 1
      expect(client.image_urls.first).to eq image_url
    end

    it 'throws an error if image extension is unrecognized'

  end

  describe '#initiate_search' do
    let(:client)    { Incandescent::Client.new(ENV['INCANDESCENT_UID'], ENV['INCANDESCENT_API_KEY']) }
    let(:image_url) { 'https://c2.staticflickr.com/2/1164/1001998842_cdfc7708da_z.jpg?zz=1' }

    context 'with no images added to the queue' do
      it 'throws an empty image list exception' do
        expect{ client.initiate_search }.to raise_error
      end
    end

    context 'with at least one image in the queue' do
      it 'should create an Incandescent project ID' do
        initiate_search

        expect(client.project_id).to match /\w+/
      end
    end

  end

  describe '#get_results' do
    let(:client)    { Incandescent::Client.new(ENV['INCANDESCENT_UID'], ENV['INCANDESCENT_API_KEY']) }
    let(:image_url) { 'https://c2.staticflickr.com/2/1164/1001998842_cdfc7708da_z.jpg?zz=1' }
    it 'should return a list of Incandescent matches' do
      initiate_search
      hosts = get_results

      expect(hosts.size).to be > 0
      expect(hosts.first.pages.size).to be > 0
      expect(hosts.first.pages.first.source).to match /google/i
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