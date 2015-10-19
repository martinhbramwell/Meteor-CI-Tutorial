const Client = Npm.require('swagger-client');
const swaggerSpecURL = 'http://petstore.swagger.io/v2/swagger.json';
const swagger = new Client({
  url: swaggerSpecURL,
  success: function getPet() {
    swagger.pet.getPetById(
      { petId: 6133627028 }, {responseContentType: 'application/json'},
      function log(pet) { Logger.info('(Async) Pet #' + pet.obj.id, ' -- ' + pet.obj.name);  }
    );
  },
});
