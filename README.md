REQUIREMENTS:

* Ruby 2
* Bundler gem

INSTALLATION:

* Clone repo
* bundle install
* Symlink or copy the compiled chipmunk library to /usr/local/lib so chipmunk-ffi has access to it.  On my local box that looked like this:

  * ln -s ~/.rvm/gems/ruby-2.0.0-p247@game_dev/gems/chipmunk-5.3.4.5/lib/chipmunk.bundle /usr/local/lib/chipmunk

