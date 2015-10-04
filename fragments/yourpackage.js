const Client = Npm.require('swagger-client');
const swaggerSpecURL = 'http://petstore.swagger.io/v2/swagger.json';
const swagger = new Client({
  url: swaggerSpecURL,
  success: function getPet() {
    swagger.pet.getPetById(
      { petId: 7}, {responseContentType: 'application/json'},
      function log(pet) { Logger.info('Pet #' + pet.obj.id, ' -- ' + pet.obj.name);  }
    );
  },
});
