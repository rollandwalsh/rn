var gulp = require('gulp'),
	plumber = require('gulp-plumber'),
	rename = require('gulp-rename'),
	autoprefixer = require('gulp-autoprefixer'),
	coffee = require('gulp-coffee'),
	jshint = require('gulp-jshint'),
	uglify = require('gulp-uglify'),
	cleancss = require('gulp-clean-css'),
	sass = require('gulp-sass');

var agentWebPath = '../../../../';

var search3Companies = [
	'agentpros',
	'agr',
	'americanproperty',
	'bagr',
	'bhap',
	'bhcp',
	'bhfo',
	'bhhr',
	'c21h',
	'calco',
	'cbbest',
	'cbrivercountry',
	'cbsequim',
	'cjre',
	'coastalrealty',
	'coldwellbanker_kline',
	'coldwellbanker_evergreen',
	'cpsre',
	'crre',
	'cwre',
	'demp',
	'elpr',
	'flpg',
	'gare',
	'gksrealty',
	'hare',
	'hggr',
	'hmre',
	'hqre',
	'hrpb',
	'kansasmlsera',
	'kansasmlsindependents',
	'kr',
	'le',
	'megr',
	'mfc',
	'mnire',
	'mvre',
	'nire',
	'nres',
	'nwre',
	'pnwra',
	'ppro',
	'prucaliforniarealty',
	'prufoxroach',
	'prutroth',
	'rec',
	'rega',
	'remaxak',
	'remaxal',
	'remaxar',
	'remaxatlantic',
	'remaxcahi',
	'remaxcarolina',
	'remaxcentral',
	'remaxga',
	'remaxflorida',
	'remaxil',
	'remaxin',
	'remaxla',
	'remaxky',
	'remaxmidstates',
	'remaxms',
	'remaxmtn',
	'remaxnc',
	'remaxncoh',
	'remaxne',
	'remaxnj',
	'remaxok',
	'remaxpade',
	'remaxpnw',
	'remaxsouthernoh',
	'remaxstl',
	'remaxsw',
	'remaxtest',
	'remaxtn',
	'remaxtx',
	'sare',
	'serlsprime',
	'sissywood',
	'smmt',
	'snyder',
	'tore',
	'valore',
	'wbre',
	'weicherttriangle'
];

// STYLING

// Compiles search scss files at company level
gulp.task('styles', function () {
	var s3Dirs = search3Companies.map(function (dir) {
		gulp.src([agentWebPath + dir + '/scss/**/*.scss'])
	    .pipe(plumber({
	    	errorHandler: function (error) {
	    		console.log(error.message);
	    		this.emit('end');
	    	}
	    }))
	    .pipe(sass())
	    .pipe(autoprefixer('last 3 versions', '>1%', 'ie 10'))
	    .pipe(gulp.dest(agentWebPath + dir + '/css/'))
	    .pipe(rename({ suffix: '.min' }))
	    .pipe(cleancss({processImport: false}))
	    .pipe(gulp.dest(agentWebPath + dir + '/css/'))
	});
});

// Compiles featured properties page styling to N drive
gulp.task('featured-properties', function () {
	gulp.src('scss/featured-properties.scss')
	.pipe(plumber({
	    errorHandler: function (error) {
	    	console.log(error.message);
	    	this.emit('end');
	    }
	}))
	.pipe(sass())
	.pipe(autoprefixer('last 3 versions', '>1%', 'ie 10'))
	.pipe(gulp.dest('N:/Media/global/featured-properties/css/'))
	.pipe(rename({ suffix: '.min' }))
	.pipe(cleancss())
	.pipe(gulp.dest('N:/Media/global/featured-properties/css/'))
});

// SCRIPTS

// Compiles global coffee files at company level	
gulp.task('scripts', function () {
	var s3Dirs = search3Companies.map(function (dir) {
		gulp.src('coffee/**/*.coffee')
	    .pipe(plumber({
	    	errorHandler: function (error) {
	    		console.log(error.message);
	    		this.emit('end');
	    	}
	    }))
		.pipe(coffee({ bare: true }))
		.pipe(jshint())
		.pipe(jshint.reporter('default'))
	    .pipe(gulp.dest(agentWebPath + dir + '/js/'))
	    .pipe(rename({ suffix: '.min' }))
		.pipe(uglify())
	    .pipe(gulp.dest(agentWebPath + dir + '/js/'))
	});
});

// ICON FONT

// Copies global icon font to company level
gulp.task('icons', function () {
	var s3Dirs = search3Companies.map(function (dir) {
		return gulp.src('fonts/*')
		.pipe(gulp.dest(agentWebPath + dir + '/fonts'))
	});
});

gulp.task('default', function () {
	gulp.watch("scss/**/*.scss", ['styles']);
	gulp.watch("coffee/**/*.coffee", ['scripts']);
});
