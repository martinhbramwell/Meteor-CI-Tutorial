Package.describe({
  name: 'yourself-yourorg:yourpackage',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: '',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.3');
  api.addFiles('yourpackage.js', ['server']);
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('yourself:yourpackage');
  api.addFiles(
    ["logger.js", 'yourpackage.js', 'yourpackage-tests.js'],
    ['server']
  );
  api.export(["Logger", "PetStore"]);
});

Npm.depends({
  "bunyan": "1.4.0",
  "swagger-client": "2.1.1",
});

