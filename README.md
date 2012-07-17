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

## Configuration