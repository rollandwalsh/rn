var gulp = require('gulp'),
    plumber = require('gulp-plumber'),
    rename = require('gulp-rename');
var autoprefixer = require('gulp-autoprefixer');
var coffee = require('gulp-coffee');
var jshint = require('gulp-jshint');
var uglify = require('gulp-uglify');
var imagemin = require('gulp-imagemin'),
    cache = require('gulp-cache');
var cleancss = require('gulp-clean-css');
var sass = require('gulp-sass');

gulp.task('images', function () {
	gulp.src('img/**/*')
	  .pipe(cache(imagemin({ optimizationLevel: 3, progressive: true, interlaced: true })))
	  .pipe(gulp.dest('img/'));
});

gulp.task('styles', function () {
	gulp.src(['scss/**/*.scss'])
		.pipe(plumber({
			errorHandler: function (error) {
				console.log(error.message);
				this.emit('end');
			}
		}))
		.pipe(sass())
		.pipe(autoprefixer('last 3 versions', '>1%', 'ie 10'))
		.pipe(gulp.dest('css/'))
		.pipe(rename({ suffix: '.min' }))
		.pipe(cleancss())
		.pipe(gulp.dest('css/'))
});

gulp.task('scripts', function () {
	return gulp.src('coffee/**/*.coffee')
		.pipe(plumber({
			errorHandler: function (error) {
				console.log(error.message);
				this.emit('end');
			}
		}))
		.pipe(coffee({ bare: true }))
		.pipe(jshint())
		.pipe(jshint.reporter('default'))
		.pipe(gulp.dest('js/'))
		.pipe(rename({ suffix: '.min' }))
		.pipe(uglify())
		.pipe(gulp.dest('js/'))
});

// Copies global icon font to company level
gulp.task('icons', function () {
	gulp.src('../modules/internet/search/search3skin/fonts/*')
		.pipe(gulp.dest('fonts'))
});

gulp.task('default', function () {
	gulp.watch("scss/**/*.scss", ['styles']);
	gulp.watch("coffee/**/*.coffee", ['scripts']);
	gulp.watch('../modules/internet/search/search3skin/scss/**/*.scss', ['styles']);
});