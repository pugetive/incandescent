describe 'VCR Rspec Integration' do

  def make_get_request
    Faraday.get('https://jsonplaceholder.typicode.com/posts/1').body
  end

  def make_post_request
    conn = Faraday.new(url: 'https://jsonplaceholder.typicode.com')
    conn.post do |req|
      req.url '/posts'
      req.headers['Content-Type'] = 'application/json'
      req.body = '{ "title": "Todds Title", "body": "Todds Body" }'
    end
  end

  it 'records a get request to a generic test API service' do
    VCR.use_cassette('vcr-example-get-test') do
      response = make_get_request
      expect(response['title']).not_to be_nil
      expect(response['body']).not_to be_nil
      expect(response['todd']).to be_nil
    end
  end

  it 'records a post request to a generic test API service' do
    VCR.use_cassette('vcr-example-post-test') do
      response = make_post_request
    end
  end

  it "records the '/api/add' request to the incandescent service" do
    VCR.use_cassette('vcr-incandescent-api-add-test') do
      client = Incandescent::Client.new(ENV['INCANDESCENT_UID'], ENV['INCANDESCENT_API_KEY'])
      client.add_image_url('https://c2.staticflickr.com/2/1164/1001998842_cdfc7708da_z.jpg?zz=1')
      client.initiate_search
    end
  end


end
