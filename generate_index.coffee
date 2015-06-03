fs = require "fs"
path = require "path"

files = fs.readdirSync('./bower_components')

links = [
  'prism-element/prism-highlighter.html'
]

scripts = [
  'web-animations-js/web-animations.min.js'
]

exclude = [
  'iron-behaviors'
  'marked'
  'paper-behaviors'
  'prism'
  'prism-element'
  'web-animations-js'
  'webcomponentsjs'
]

files.forEach (f) ->
  path = "#{f}/#{f}.html"
  links.push(path) if links.indexOf(path) < 0 and exclude.indexOf(f) < 0

links.forEach (l) ->
  console.log "<link rel='import' href='./bower_components/#{l}'>"

scripts.forEach (l) ->
  console.log "<script src='./bower_components/#{l}'>"