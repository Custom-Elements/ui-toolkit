browserify = require 'browserify'
gulp = require 'gulp'
less = require 'gulp-less'
rename = require 'gulp-rename'
vulcanize = require 'gulp-vulcanize'
replace = require 'gulp-replace'
concat = require 'gulp-concat'
coffee = require 'gulp-coffee'
globby = require 'globby'
gutil = require 'gulp-util'
sourcemaps = require 'gulp-sourcemaps'
rm = require 'gulp-rm'
source = require 'vinyl-source-stream'
connect = require 'gulp-connect'

src ='./elements'
dest = './static'

gulp.task 'litcoffee', ->
  gulp.src "#{src}/**/*.litcoffee"
    .pipe sourcemaps.init()
    .pipe coffee({bare: true}).on('error', gutil.log)
    .pipe sourcemaps.write()
    .pipe rename extname: '.js'
    .pipe gulp.dest dest

gulp.task 'browserify', ['rename-litcoffee'], ->
  globby ['./static/**/*.js'], (err, entries) ->
    entries.forEach (entry) ->
      browserify({ entries: [entry], debug: true })
        .bundle()
        .pipe(source(entry))
        .pipe(gulp.dest('./'))

gulp.task 'rename-litcoffee', ['litcoffee'], ->
  gulp.src "#{src}/**/*.html"
    .pipe replace('.litcoffee', '.js')
    .pipe gulp.dest dest

gulp.task 'rename-package-paths', ->
  gulp.src 'packages/*.html'
    .pipe replace('./elements', "..")
    .pipe gulp.dest "#{dest}/packages"

gulp.task 'vulcanize', ['browserify','rename-package-paths'], ->
  gulp.src ["#{dest}/packages/*.html", "#{dest}/**/demo.html"]
    .pipe vulcanize({ dest: dest, strip: true, inline: true })
    .pipe gulp.dest dest

gulp.task 'clean', ->
  gulp.src "#{dest}/**"
    .pipe rm()

gulp.task 'connect', ->
  connect.server
    root: '.'
    livereload: true

gulp.task 'default', ['vulcanize']
gulp.task 'watch', ['default', 'connect'], ->
  gulp.watch("#{src}/**", ['vulcanize'])
    .on 'change', ->
      connect.reload()