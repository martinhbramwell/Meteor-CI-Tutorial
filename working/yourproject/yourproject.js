if (Meteor.isClient) {
  Session.setDefault('counter', 6133627027);
  Session.setDefault('pet', { name: 'unknown'});

  Template.hello.helpers({
    counter: function getCounter() {
      return Session.get('counter');
    },
    namePet: function getPetName() {
      return Session.get('pet').name;
    },

  });

  Template.hello.events({
    'click button': function clickMe() {
      Session.set('counter', Session.get('counter') + 1);

      Meteor.call('getPetById', Session.get('counter'), function setPet(err, thePet) {
        if (err) {
          console.log('Server error :: ' + err);
          Session.set('pet', { name: 'error'});
        } else {
          Session.set('pet', thePet);
        }
      });
    },
  });
}
