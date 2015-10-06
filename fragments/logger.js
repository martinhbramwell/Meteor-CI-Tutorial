const Bunyan = Npm.require('bunyan'); // !
Logger = Bunyan.createLogger({
  'name': '${PKG_NAME}',
  'streams': [{
    'path': '/var/log/meteor/ci4meteor.log',
  }],
});
