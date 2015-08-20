Logger = Npm.require("bunyan").createLogger({
  "name": "ci4meteor",
  "streams": [{
    "path": "/var/log/meteor/ci4meteor.log",
  }],
});


const Client = Npm.require("swagger-client");
const swaggerSpecURL = "http://petstore.swagger.io/v2/swagger.json";

/*
const swagger = new Client({
  url: swaggerSpecURL,
  success: function getPet() {
    swagger.pet.getPetById(
      { petId: 8},
      {responseContentType: "application/json"},
      function log(pet) {
        Logger.info("(Async) Pet #" + pet.obj.id, " -- " + pet.obj.name);
      }
    );
  },
});

*/
const getSwaggerProxy = Meteor.wrapAsync(
  function wrpr(swaggerSpec, callback) {
    var prxySwagger = new Client({
      url: swaggerSpec,
      success: function suxs() {
        callback(null, prxySwagger);
      },
      error: function errs() {
        callback(null, prxySwagger);
      },
    });
  }
);

PetStore = getSwaggerProxy(swaggerSpecURL);

PetStore.sync = {};
PetStore.sync.getPetById = Meteor.wrapAsync(
  function wrpr(args, headers, callback) {
    PetStore.pet.getPetById(
        args
      , headers
      , function suxs( theResult ) {
          Logger.info("Cool " + theResult);
          callback(null, theResult);
        }
      , function errs( theError ) {
          Logger.info("Oh crap! " + theError);
          callback(null, theError);
        }
    );
  }
);