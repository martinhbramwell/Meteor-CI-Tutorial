const Client = Npm.require('swagger-client');
const swaggerSpecURL = 'http://petstore.swagger.io/v2/swagger.json';
Logger.debug('Swagger package :: ', 'starting');

const getSwaggerProxy = Meteor.wrapAsync(
  function wrpr(swaggerSpec, callback) {
    var prxySwagger = new Client({
      url: swaggerSpec,
      success: function suxs() { callback(null, prxySwagger); },
      error: function errs() { callback(null, prxySwagger); },
    });
  }
);
PetStore = getSwaggerProxy(swaggerSpecURL);

PetStore.sync = {};
PetStore.sync.getPetById = Meteor.wrapAsync(
  function wrpr(args, headers, callback) {
    PetStore.pet.getPetById( args, headers
    , function suxs( theResult ) {  callback(null, theResult);  }
    , function errs( theError ) {
      Logger.error('For Id #' + args.petId + ' : ' + theError.statusText);
      callback(null, theError);
    });
  });

Meteor.methods({
  getPetById: function getPetById(petNum) {
    var aPetVO = PetStore.sync.getPetById(
      { petId: petNum},
      {responseContentType: 'application/json'}
    );
    if (aPetVO.status === 404) {
      return {name: JSON.parse(aPetVO.data).message};
    }
    Logger.info('Pet is ', aPetVO.obj.name);
    return aPetVO.obj;
  },
});

