const Client = Npm.require('swagger-client');
const swaggerSpecURL = 'http://petstore.swagger.io/v2/swagger.json';
Logger.debug('mypackage :: ', 'starting');

const TestPet = 6133627028;
const swagger = new Client({
  url: swaggerSpecURL,
  success: function getPet() {
  	Logger.debug('(Async) Looking for Pet #', TestPet);
    for (idx = TestPet; idx <= TestPet + 3; idx++) {
      swagger.pet.getPetById(
        { petId: idx}, {responseContentType: 'application/json'},
        function log(pet) { Logger.info('(Async) Pet #' + pet.obj.id, ' -- ' + pet.obj.name);  }
      );
    }
    );

  },
});

