if ( Meteor.isClient ) {
  Template.apk_loader.helpers({
      isMobile: function() {
        return Meteor.isCordova;
    }
  });
}
