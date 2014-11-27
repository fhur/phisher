phisher
-------

Phishing detection gem

## Usage

To import `phisher` simply

```ruby
gem install phisher
```

## Phishy links
To check if a url is phishy simply call
```ruby
phisher.verify("www.google.com") # => :safe
phisher.verify("faizbook.nz") # => :phishy
phisher.verify("someunknownsite.com") # => :unknown
```

## Black and White lists

Phisher can be trained to reject any url in a blacklist and verify any
url in a whitelist.

```ruby
phisher = Phisher.new

# A list of urls, can optionaly contain wildards i.e. myblog.blogger.com/*
phisher.blacklist = blacklisted_links

# A list of whitelisted domains. Can also contain wildcards
phisher.whitelist = whitelisted_domains

```

## Training a Phisher

Black/White lists are great but they do have drawbacks, namely they are
not easily extensible. To improve Phisher you should train it to detect
phishing. 

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

