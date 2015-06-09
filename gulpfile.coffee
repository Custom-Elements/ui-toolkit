browserify = require 'browserify'
gulp = require 'gulp'
mustache = require 'gulp-mustache'
path = require 'path'
fs = require 'fs'
globby = require 'globby'
rename = require 'gulp-rename'


src = [
  './elements/**/*.html',
  '!./elements/**/demo/*.html',
  '!./elements/index.html'
]

docTemplateSrc = [
  './templates/docs.mustache'
]

links = globby.sync(src).map (f) ->
  link = { element: path.basename(f).replace('.html','') }
  link.url = "./#{link.element}/#{link.element}.html"
  link

gulp.task 'docs', ->
  gulp.src(docTemplateSrc)
    .pipe(mustache({ links }))
    .pipe(rename (path) ->
      path.extname = '.html'
      path.basename = 'index'
    )
    .pipe(gulp.dest('./elements'))

gulp.task 'watch', ->
  gulp.watch docTemplateSrc.concat(src), ['docs']