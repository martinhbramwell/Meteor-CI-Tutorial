const Bunyan = Npm.require('bunyan'); // !
LoggerSpec={
  'name': '${PKG_NAME}',
};
if ( Meteor.settings.LOGDIR && Meteor.settings.LOGDIR.length > 0 ) {
  LoggerSpec.streams = [{'path': Meteor.settings.LOGDIR,}];
};

Logger = Bunyan.createLogger(LoggerSpec);
