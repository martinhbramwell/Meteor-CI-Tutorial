/**
 * @fileOverview A demonstrator template.  This code is expected to be used as a getting
 * started example and then thrown away. It demonstrates the basic action of getting
 * date from apackage.
 * @author ${YOUR_FULLNAME} <${YOUR_EMAIL}>
 * @version v0.0.1
 * @license MIT
 */

Session.setDefault('idPet', 6133627026);
Session.setDefault('pet', { name: 'unknown'});

Template.petStoreTest.helpers({

  /**
   * petStoreTest template's helper for getting a pet ID
   * @return {Integer} A valid pet ID
   */
  idPet: function getCounter() {
    return Session.get('idPet');
  },
  /**
   * petStoreTest template's helper for getting a pet name as returned from the API
   * @return {String} The pet's name according to the remote API.
   */
  namePet: function getPetName() {
    return Session.get('pet').name;
  },

});

Template.petStoreTest.events({
  /**
   * Handle clicks of the button to step through a short list of pets
   * @return {null} None
   */
  'click button': function clickMe() {
    Session.set('idPet', Session.get('idPet') + 1);

    Meteor.call('${PKG_NAME}_getPetById', Session.get('idPet'), function setPet(err, thePet) {
      if (err) {
        console.log('Server error :: ' + err);
        Session.set('pet', { name: 'error'});
      } else {
        Session.set('pet', thePet);
      }
    });
  },
});
