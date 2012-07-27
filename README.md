
[<img src="https://secure.travis-ci.org/tomeara/green_onion.png" />](http://travis-ci.org/#!/tomeara/green_onion)

# GreenOnion

Regression issues make you cry.

GreenOnion is a testing library for the UI only. It alerts you when the appearance of a view has changed, let's you know the percentage of total change, and allows you to visualize the areas that have been changed. It fits right into your test suite, and is dependent on familiar tools like Capybara.

## Installation

Add this line to your application's Gemfile:

    gem 'green_onion'

And then execute:

    bundle

Or install it yourself as:

    gem install green_onion

## Usage

### RSpec

For RSpec, `require 'green_onion'` in your spec_helper.rb file. Place this block in the file also:

    GreenOnion.configure do |c|
      c.skins_dir = 'spec/skins'
      c.threshold = 20
    end

* `skins_dir` is the directory that GreenOnion will store all skins. The namespace for skins is {URI name}.png (original), {URI name}_fresh.png (testing), and {URI name}_diff.png
* `threshold` is the percentage of acceptable change that the screenshots can take. This number can always be overwritten for an instance.

Then use one of the three methods below in a test...

### Percentage of change

    GreenOnion.skin_percentage(url, threshold {optional})
The primary feature of GreenOnion is seeing how much (if at all) a view has changed from one instance to the next, and being alerted when a view has surpassed into an unacceptable threshold.

* `url` is the screen you want tested. Must include http://, example - 'http://yourSite.com'
* `threshold` can be overwritten here, or if not given in the configure block – it will default to a threshold of 100%

### Viewing screenshot diffs

    GreenOnion.skin_visual(url)
Once you are aware of a issue in the UI, you can also rip open your spec/skins directory and manually see what the differences are from one screenshot to the next.

* `url` is the screen you want tested. Must include http://, example - 'http://yourSite.com'

### Both viewing screenshot diffs and percentage of change

    GreenOnion.skin_percentage(url, threshold {optional})
This is just a combination of the two methods above.

## Contributing

### Testing

The best way to run the specs is with...

    bundle exec rake spec

...this way a Sinatra WEBrick server will run concurrently with the test suite, and exit on completion. You can see the Sinatra app in spec/sample_app.

## Roadmap

* Screenshots can either be viewed as a visual diff, or overlayed newest over oldest and viewed as an onion-skin with sliding transparency.
* Allow for headless screenshooting
* More robust tests, especially around the visual diffs themselves
* More documentation
* More configuration/customizable settings

## THANK YOU

Much of this work could not be completed without these people and projects

### Jeff Kreeftmeijer
This is the post that got the wheels in motion: http://jeffkreeftmeijer.com/2011/comparing-images-and-creating-image-diffs/. Most of the GreenOnion::Compare class is based on this work alone. Great job Jeff!

### Compatriot
Carol Nichols saw the same post, and worked on an excellent gem for cross-browser testing. That gem greatly influenced design decisions with GreenOnion.

### Capybara and ChunkyPNG
The land on which we sow our bulbs.