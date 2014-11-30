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

```
# A list of fishing detection algorithms. Check the lib/algos folder for
# a list of all supported algorithms.
algos = [ SearchEngineAlgo.new 0.5, TwitterAlgo.new 0.5 ]
phisher = Phisher.new algos: algos
```

## Phishing Algorithms

`Phisher` provides the concept of an 'Algo' (short for algorithm)

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

