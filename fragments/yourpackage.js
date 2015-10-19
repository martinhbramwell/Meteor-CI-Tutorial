const Client = Npm.require('swagger-client');
const swaggerSpecURL = 'http://petstore.swagger.io/v2/swagger.json';
Logger.info('mypackage :: ', 'starting');

const TestPet = 6133627028;
const swagger = new Client({
  url: swaggerSpecURL,
  success: function getPet() {
  	Logger.info('(Async) Looking for Pet #', TestPet);
    swagger.pet.getPetById(
      { petId: TestPet }, {responseContentType: 'application/json'},
      function log(pet) { Logger.info('(Async) Pet #' + pet.obj.id, ' -- ' + pet.obj.name);  }
    );
  },
});
