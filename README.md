
[<img src="https://secure.travis-ci.org/intridea/green_onion.png" />](http://travis-ci.org/#!/intridea/green_onion) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/intridea/green_onion)

# GreenOnion

Regression issues in the view make you cry.

GreenOnion is a testing library for the UI only. It alerts you when the appearance of a view has changed, let's you know the percentage of total change, and allows you to visualize the areas that have been changed. It fits right into your test suite, and is dependent on familiar tools like Capybara.

## Documentation

[RDoc](http://rdoc.info/gems/green_onion/frames)

## Installation

If you want to use [capybara-webkit](https://github.com/thoughtbot/capybara-webkit), you'll need to get Qt built in your testing environment. [Follow these steps](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit) and `gem install capybara-webkit` to get it up and running. Overwise, you can just use `:driver => 'selenium'` in the configuration block.

Add this line to your application's Gemfile:

    gem 'green_onion'

And then execute:

    bundle

Or install it yourself as:

    gem install green_onion

## Usage

### Command Line Interface

#### Skinning

To just run a comparison between skins in your shell, you can use the command below:

    green_onion skin <url> [options]

Options
* `<url>` - is the screen you want tested. Must include http://, example - 'http://yourSite.com'
* `--dir=DIR` - the directory that GreenOnion will store all skins. The namespace for skins is {URI name}.png (original), {URI name}_fresh.png (testing), and {URI name}_diff.png. The default directory will be './spec/skins'
* `--method=[p, v, vp]` - the method in which you'd like to compare the skins. `p` is for percentage, `v` is for visual. The default is visual and percentage.
* `--threshold=[1-100]` is the percentage of acceptable change that the screenshots can take. This number can always be overwritten for an instance.
* `--width=[number]` is the width of the browser window. The default width is 1024. (only when using capybara-webkit)
* `--height=[number]` is the height of the browser window. The default height is 768. (only when using capybara-webkit)
* `--driver=DRIVER` is the browser driver for Capybara. It is `webkit` by default, but you can also pass in `selenium`.

#### Generating skinner file

To generate a "skinner" file, which will test a Rails application with the routes without params included (this is an area that could be worked on a lot more :) ); use the command below:

    green_onion generate [options]

* `--url=URL` - the domain that you will be testing your Rails app. The default is "http://localhost:3000".
* `--dir=DIR` - the directory in which you would like to generate the skinner. The default is "spec/skinner.rb"

### Adding GreenOnion to integration tests with RSpec

For adding GreenOnion to your integration tests in RSpec, add `require 'green_onion'` to your spec_helper.rb file. Place this block in the file also:

    GreenOnion.configure do |c|
      c.skins_dir = 'your/path/to/skins'
      c.skin_name = {
        :match => /[\/]/, 
        :replace => "_", 
        :prefix => nil,
        :root => "root" 
      }
      c.driver = :webkit
      c.dimensions = { 
        :width => 1440, 
        :height => 768 
      }
      c.threshold = 20
    end

* `skins_dir` is the directory that GreenOnion will store all skins. The namespace for skins is {URI name}.png (original), {URI name}_fresh.png (testing), and {URI name}_diff.png. The default directory will be './spec/skins'
* `skin_name` is a hash that defines the skin namespace. The options include:
    * `:match` - a regex pattern that will replace characters from the URI. The default pattern will match to all "/" in a URI.
    * `:replace` - the string that replaces what is matched. These options are just abstractions of String.gsub in GreenOnion::Screenshot.
    * `:prefix` - a value that will be concatenated to the front of the filename. A good example would be if you wanted to add a timestamp: `:prefix => Time.now.strftime("%m_%Y_")`.
    * `:root` - the string that will be used to name the root of a domain.
* `driver` is a string for the browser driver to use. The default is `'webkit'`. You could also pass in `'selenium'` instead.
* `dimensions` is a hash with the height and width of the browser window. The default dimensions are 1024x768.
* `threshold` is the percentage of acceptable change that the screenshots can take. This number can always be overwritten for an instance.

Then use one of the three methods below in a test...

#### Percentage of change

    GreenOnion.skin_percentage(url, threshold [optional])
The primary feature of GreenOnion is seeing how much (if at all) a view has changed from one instance to the next, and being alerted when a view has surpassed into an unacceptable threshold.

* `url` is the screen you want tested. Must include http://, example - 'http://yourSite.com'
* `threshold` can be overwritten here, or if not given in the configure block – it will default to a threshold of 100%

#### Viewing screenshot diffs

    GreenOnion.skin_visual(url)
Once you are aware of a issue in the UI, you can also rip open your spec/skins directory and manually see what the differences are from one screenshot to the next.

* `url` is the screen you want tested. Must include http://, example - 'http://yourSite.com'

#### Both viewing screenshot diffs and percentage of change

    GreenOnion.skin_visual_and_percentage(url, threshold {optional})
This is just a combination of the two methods above.

## Contributing

### Testing

The best way to run the specs is with...

    bundle exec rake spec

...this way a Sinatra WEBrick server will run concurrently with the test suite, and exit on completion. You can see the Sinatra app in spec/sample_app.

## Roadmap

* Screenshots can either be viewed as a visual diff, or overlayed newest over oldest and viewed as an onion-skin with sliding transparency.
* Allow for flexibility in picking browsers
* Skinner generator needs love <3
    * Should allow for testing using fixtures/factories
* More robust tests, especially around the visual diffs themselves
* More documentation
* More configuration/customizable settings

## THANK YOU

Much of this work could not be completed without these people and projects

### [Jeff Kreeftmeijer](http://jeffkreeftmeijer.com)
This is the post that got the wheels in motion: http://jeffkreeftmeijer.com/2011/comparing-images-and-creating-image-diffs/. Most of the GreenOnion::Compare class is based on this work alone. Great job Jeff!

### [Compatriot](https://github.com/carols10cents/compatriot)
Carol Nichols saw the same post, and worked on an excellent gem for cross-browser testing. That gem greatly influenced design decisions with GreenOnion.

### [VCR](https://github.com/myronmarston/vcr)
Many patterns and ideas also came from VCR, because of its flexibility in allowing users to pick what gems to work with.

### [Capybara](https://github.com/jnicklas/capybara), [ChunkyPNG](https://github.com/wvanbergen/chunky_png), [Thor](https://github.com/wycats/thor), and [OilyPNG](https://github.com/wvanbergen/oily_png)
The land on which we sow our bulbs.

## Contributor
[Ted O'Meara](http://www.intridea.com/about/team/ted-o-meara)

## License
MIT License. See LICENSE for details.

## Copyright
Copyright (c) 2012 Intridea, Inc.