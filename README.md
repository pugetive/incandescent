# Incandescent

Ruby wrapper for reverse image search via the [Incadescent API](http://incandescent.xyz/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'incandescent'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install incandescent

## Usage

    client = Client.new(uid, api_key)
    client.add_image_url('http://example.com/image.jpg')
    client.initiate_search

    hosts = client.get_results
    hosts.each do |host|
      host.name   # pinterest.com
      host.pages.each do |page|
        page.page          # http://thief.example.com/my-stolen-photos.html
        page.source        # google OR bing OR <etc>
        page.date          # Unix timestamp
        page.usage_image   # URL for the discovered image
        page.usage_height  # Pixel height of discovered image
        page.usage_width   # Pixel width of discovered image
        page.image         # URL for the original image to search with
        page.iid           # Incandescent ID for the original image
      end
    end

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pugetive/incandescent.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
