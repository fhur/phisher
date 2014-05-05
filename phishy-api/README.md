Phisher
=======

(Note: this documentation is currently broken)

Simple phishing detection based on twitter api

Installation
------------
You need to install the twitter gem
`gem install twitter`


Phishing detection
------------------
This project aims to provide an extremely simple heuristic approach to phishing
detection. The hypotheses is that a site's reputation will grow over time
if the site is 'real' while phishing sites will not. The reputation can be
measured using the site's activity on twitter. A phishing site will most likely
have little to none twitter activity while a real site like facebook, gmail,
will have followers and tweets every single day.

Traditional approaches to phishing depend on blacklists and whitelists. Blacklists
have the problem that phishing websites have a relatively short lifespan so these
lists have to be updated very often which can be very tedious and will not cover
the newer phishing sites until they are reported.

Whitelisting on the other hand requires a way to classify a website, if the classifying fails
the website will continue whitelisted and might affect users.

Applications
------------
A phishing classifier can be used, for example, in a browser extension to inform users
if they are entering a phishing website, this way they don't enter their bank info on insecure sites.

Usage
-----

The classifier is very simple, to use you must first train it.
Training is as simple as calling `Phisher#train`, after training
you can call `Phisher#calssify(domain)`

```ruby
phisher = Phisher.new
# lets first train the classifier
phisher.train
# now lets classify a domain
is_phishing = phisher.classify("google.com")
# => false
```

If you are lazy (like me :) ) you can simply call `ruby example.rb`
Note that every classify requests makes requests to the twitter API so
it may actually take a few secs for the response to arrive (depending on
you interwebz connection)

TODO
----
This project is currently using my twitter api keys so you can only make about 150 requests/15 minutes
A smarter approach should cache requests and allow users to insert their own api keys.
