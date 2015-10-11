Session.setDefault('idPet', 6133627026);
Session.setDefault('pet', { name: 'unknown'});

Template.petStoreTest.helpers({
  idPet: function getCounter() {
    return Session.get('idPet');
  },
  namePet: function getPetName() {
    return Session.get('pet').name;
  },

});

Template.petStoreTest.events({
  'click button': function clickMe() {
    Session.set('idPet', Session.get('idPet') + 1);

    Meteor.call('getPetById', Session.get('idPet'), function setPet(err, thePet) {
      if (err) {
        console.log('Server error :: ' + err);
        Session.set('pet', { name: 'error'});
      } else {
        Session.set('pet', thePet);
      }
    });
  },
});
