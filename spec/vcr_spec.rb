describe 'VCR Rspec Integration' do

  def make_http_request
    VCR.use_cassette('vcr-test') do
      Faraday.get('https://jsonplaceholder.typicode.com/posts/1').body
    end
  end

  it 'records an http request' do
    response = make_http_request
    expect(response['title']).not_to be_nil
    expect(response['body']).not_to be_nil
    expect(response['todd']).to be_nil
  end

end
