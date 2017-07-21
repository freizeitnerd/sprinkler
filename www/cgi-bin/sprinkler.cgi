#!/usr/bin/ruby

require 'cgi' # https://www.tutorialspoint.com/ruby/ruby_web_applications.htm


cgi = CGI.new
params = cgi.params