require './ml/phisher'

ph = Phisher.new
ph.train
ph.test
puts "boogle.com"
puts ph.classify('boogle.com')
puts "google.com"
puts ph.classify('google.com')
puts "mba.com"
puts ph.classify("mba.com")
puts "accivalores"
puts ph.classify("accivalores.com")
