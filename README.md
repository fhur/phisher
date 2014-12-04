phisher
-------

Simple and extensible phishing detection gem.

## Usage

To install `phisher` gem:

```ruby
gem install phisher
```


## Checking urls for phishing
To check if a url is phishy simply call
```ruby
phisher.verify("www.google.com")
```
`verify` will return a number from 0 to 1 indicating
how safe is a url where 0 is completely safe and 1
is completely unsafe

## Black and White lists

`Phisher` comes built in with black and white list phishing detection.

```ruby
# You can use * wildcards
blacklist = ['foo.org/*', 'bar.com', 'baz.nz/*']
whitelist = ['google.com/*', 'facebook.com/*']

phisher = Phisher.new blacklist: blacklist, whitelist: whitelist

phisher.verify('google.com/whatever') # => 0
phisher.verify('foo.org/whatever') # => 1
```


## Improving Phisher

Black/White lists are great but they do have drawbacks, namely they are
not easily extensible. To improve `Phisher`'s phishing detection capabilities
you can add several custom algorithms to your `Phisher` instance as follows

```ruby
# A list of fishing detection algorithms. Check the lib/algos folder for
# a list of all supported algorithms.
algos = [ SearchEngineAlgo.new 0.5, TwitterAlgo.new 0.5 ]
phisher = Phisher.new algos: algos
```

## Phishing Algorithms

`Phisher` is extensible in the sense that you can supply an arbitrary number of phishing detection algorithms 
to customize your `Phisher`. Algorithms are supplied to a `Phisher` via the constructor's `algos` parameter.
You must pass an array of `Algo` subclasses, and the weight of each `Algo` must add `1`.

```ruby
# You pass an array of algos.
array_of_algos = [SomeAlgo.new 0.5, SomeOtherAlgo.new 0.3, OtherAlgo.new 0.2]
Phisher.new algos: array_of_algos
```

An `Algo` is simply a class that takes a url as parameter and returns
a number between 0 and 1 indicating the probability that the given url
is phishy.

## Available `Algo`s

This is a short description of some implemented algos. Check the `/lib/algos`
folder for an updated list of available `Algo`s.

  - TwitterAlgo
    The twitter phishing detection algorithm is based on the assumption
    that reputable Twitter users and reputable tweets will not contain
    phishy urls. The algorithm works as follows:

    1. Let `u` be the url that will be classified
    2. serach for `u` in the twitter API.
    3. Obtain a list of tweets and for each tweet obtain the user that
       composed that tweet.
    4. Calculate some 'reputation' indicators (e.g. the average number
       of followers)
    5. Classify the tweet given the calculated reputation.

## Implementing your own `Algo`

Implementing an algo is easy, you just need to subclass `Algo` and
implement the `risk(url)` method. See `Algo` class's documentation
for a detailed explanation.

## Important

- This gem does not come with training data, you must train the models
  yourself.
- This gem is still in early ALPHA. Do not use for production. API might
  change without notice.

## Contributing to phisher

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 fhur. See LICENSE.txt for
further details.

