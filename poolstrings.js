#!/usr/bin/env node

var PROJECT_NAME = 'Santhera';
var SPREADSHEET_ID = '1dYQd5M7R2NJ1N9QW6lCbdQ5TQ6xt-6k0RSiR4kU5gEM';
var LANGUAGES = ['fr'];

var Localize = require('localize-with-spreadsheet');
var spreadsheet = Localize.fromGoogleSpreadsheet(SPREADSHEET_ID, '*');

spreadsheet.setKeyCol('key');


LANGUAGES.forEach(function(lang){
  spreadsheet.save(PROJECT_NAME + "/" + lang + ".lproj" + "/Localizable.strings", {
    valueCol: lang, format: 'ios'
  });
});

spreadsheet.save(PROJECT_NAME + "/Base.lproj" + "/Localizable.strings", {
  valueCol: 'fr', format: 'ios'
});
