#!/usr/bin/python

def renderJson(status, body)
  print "Status: ", status
  print "Content-Type: application/json"
  print "Content-Length: %d" % (len(body))
  print ""
  print body
  
renderJson("200 OK", "{foo: 'bar'}")