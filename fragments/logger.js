const Bunyan = Npm.require('bunyan');
Logger = Bunyan.createLogger({
  'name': 'ci4meteor',
  'streams': [{
    'path': '/var/log/meteor/ci4meteor.log',
  }],
});
