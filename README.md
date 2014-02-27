# Twittah
[![Build Status](https://travis-ci.org/Keats/Twittah.png?branch=master)](https://travis-ci.org/Keats/Twittah)
![Dependencies Status](https://david-dm.org/Keats/Twittah.png)

A twitter for soda only.
Using AngularJS.

## Install
```bash
$ git clone https://github.com/Keats/Twittah.git && cd Twittah
$ git submodule init
$ git submodule update
$ sudo npm -g install gulp
$ npm rebuild
$ gulp --require coffee-script/register
```

## Build system
This uses gulp (http://gulpjs.com/) so you can call any of the tasks defined in the gulpfile.
The default one watches over the files and runs the associated tasks when needed and is called like this:

```bash
$ gulp --require coffee-script/register
```

To build the version to distribute, run the following:
```bash
$ gulp build --require coffee-script/register --type dist
```

To run units + integrations tests (you need the build directory for the integration tests to run):
```bash
$ ./node_modules/protractor/bin/webdriver-manager update
$ gulp build --require coffee-script/register
$ cd build && python -m SimpleHTTPServer 8001 > /dev/null 2>&1 &
$ gulp ci --require coffee-script/register
```
The webdriver-manager update command is necessary to get the webdriver for protractor.

## Known bug in the build process
The default gulp task should reload the page on every change but doesn't it with an issue somewhere with karma https://github.com/Keats/ng-boilerplate/issues/1 so reloading manually is needed!

