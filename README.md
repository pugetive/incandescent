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
      host.pags.each do |page|
        page.page
        page.source
        page.date
        page.usage_image
        page.usage_height
        page.usage_width
        page.image
        page.iid
      end
    end

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pugetive/incandescent.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
