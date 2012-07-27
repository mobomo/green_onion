
[<img src="https://secure.travis-ci.org/tomeara/green_onion.png" />](http://travis-ci.org/#!/tomeara/green_onion)

# GreenOnion

Regression issues make you cry.

GreenOnion is a testing library for the UI only. It alerts you when the appearance of a view has changed, let's you know the percentage of total change, and allows you to visualize the areas that have been changed. It fits right into your test suite, and is dependent on familiar tools like Capybara.

## Installation

Add this line to your application's Gemfile:

    gem 'green_onion'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install green_onion

## Usage

### Partnering up with RSpec

The primary feature of GreenOnion is seeing how much (if at all) a view has changed from one instance to the next, and being alerted when a view has surpassed into an unacceptable threshold.

### Viewing screenshot diffs

Once you are aware of a issue in the UI, you can also rip open your spec/skins directory and manually see what the differences are from one screenshot to the next. Screenshots can either be viewed as a visual diff, or overlayed newest over oldest and viewed as an green_onion-skin with sliding transparency.

## Contributing

### Testing

The best way to run the specs is with...

		bundle exec rake spec

...this way a Sinatra WEBrick server will run concurrently with the test suite, and exit on completion. You can see the Sinatra app in spec/sample_app.

## THANK YOU

Much of this work could not be completed without these people and projects

### Jeff Kreeftmeijer
This is the post that got the wheels in motion: http://jeffkreeftmeijer.com/2011/comparing-images-and-creating-image-diffs/. Most of the GreenOnion::Compare class is based on this work alone. Great job Jeff!

### Compatriot
Carol Nichols saw the same post, and worked on an excellent gem for cross-browser testing. That gem greatly influenced design decisions with GreenOnion.

### Capybara and ChunkyPNG
The land on which we sow our bulbs.