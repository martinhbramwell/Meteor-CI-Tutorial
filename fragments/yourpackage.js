const Client = Npm.require('swagger-client');
const swaggerSpecURL = 'http://petstore.swagger.io/v2/swagger.json';
Logger.debug('Swagger package :: ', 'starting');

const TestPet = 6133627027;
const swagger = new Client({
  url: swaggerSpecURL,
  success: function getPet() {
    for (idx = TestPet; idx < TestPet + 4; idx++) {
      Logger.debug('(Async) Looking for Pet #', idx);
      swagger.pet.getPetById(
        { petId: idx}, {responseContentType: 'application/json'},
        function log(pet) { Logger.info('(Async) Pet #' + pet.obj.id, ' -- ' + pet.obj.name);  }
      );
    }
  },
});

