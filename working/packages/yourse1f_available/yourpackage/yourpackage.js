/*
function listProperties(obj) {
  var propList = '';
  for ( propName in obj ) {
    if (typeof(obj[propName]) !== 'undefined') {
      propList += (typeof propName + ': ' + propName + ', ');
    }
  }
  console.log(propList);
}
*/

if (Meteor.isServer) {
  const Client = Npm.require('swagger-client');
  const swaggerSpecURL = 'http://petstore.swagger.io/v2/swagger.json';

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
      PetStore.pet.getPetById(
          args
        , headers
        , function suxs( theResult ) {
          callback(null, theResult);
        }
        , function errs( theError ) {
//          listProperties(args);
          Logger.info('For Id #' + args.petId + ' : ' + theError.statusText);
          callback(null, theError);
        }
      );
    }
  );

  Meteor.methods({
    getPetById: function getPetById(petNum) {
      var aPetVO = PetStore.sync.getPetById(
        { petId: petNum},
        {responseContentType: 'application/json'}
      );
      return aPetVO.status === 404
      ? {name: JSON.parse(aPetVO.data).message}
      : aPetVO.obj;
    },
  });
}
