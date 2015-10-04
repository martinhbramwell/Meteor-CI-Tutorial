Package.describe({
  name: 'your0rg:yourpackage',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: '',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md',
});

Package.onUse(function onUse(api) {
  api.versionsFrom('1.2.0.1');
  api.use('ecmascript');
  api.addFiles(['yourpackage.js']);
  api.addFiles(['logger.js'], ['server']);
  api.export(['Logger', 'Pet']);
});

Package.onTest(function onTest(api) {
  api.use('ecmascript');
  api.use('tinytest');
  api.addFiles(['yourpackage.js']);
  api.addFiles(
    ['logger.js', 'yourpackage-tests.js'], ['server']
  );
  api.export(['Logger', 'PetStore']);
});

Npm.depends({
  'bunyan': '1.5.1',
  'swagger-client': '2.1.5',
});
