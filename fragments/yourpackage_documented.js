/**
 * @fileOverview The main program for "${PKG_NAME}".  This where the exported entities reside.
 * @author ${YOUR_FULLNAME} <${YOUR_EMAIL}>
 * @version v0.0.1
 * @requires swagger-client
 * @license MIT
 */

/**
 * The PetStore name space
 * @namespace PetStore
 * @description  Represents a proxy to the Swgger demo API, 'PetSore'. <a href='http://petstore.swagger.io/' target='_blank'>Full API specification</a>
 */

/**
 * The Meteor name space
 * @namespace Meteor
 * @description  The global name space for any object needing exposure to the innards of a Meteor application
 */

/**
 * @constant
 * @description  An instance of the NodeJS module 'swagger-client'
 * Used to instaniate proxies of remote REST APIs that
 * publish Swagger format specifications
 * @type swagger-client
 * @memberof PetStore
 * @inner
 */
const Client = Npm.require('swagger-client');

/**
 * @constant
 * @description  Text representation of the URL of the REST API this package will proxy.
 * @type String
 * @memberof PetStore
 * @inner
 */
const swaggerSpecURL = 'http://petstore.swagger.io/v2/swagger.json';

/**
 * Instantiates the PetStore namespace proxy of the Swagger projects demo API
 * @name getSwaggerProxy
 * @memberof PetStore
 * @function
 * @param  {string} swaggerSpecURL
 * @returns {PetStore}
 */
const getSwaggerProxy = Meteor.wrapAsync(
  function wrpr(swaggerSpec, callback) {
    var prxySwagger = new Client({
      url: swaggerSpec,
      success: function suxs() { callback(null, prxySwagger); },
      error: function errs() { callback(null, prxySwagger); },
    });
  }
);
/**
 * This is the exported PetStore proxy that can be used by any server-side JavaScript code.
 * @exports PetStore
 */
PetStore = getSwaggerProxy(swaggerSpecURL);

/**
 * The PetStore.sync name space.
 * Contains synchronous representations of needed
 * asynchronous methods of the PetStore.
 * @namespace PetStore.sync
 * @memberof PetStore
 */
PetStore.sync = {};
  /**
   * Get a pet by its nrecord id.
   * @name getPetById
   * @memberof PetStore.sync
   * @function
   * @param  {integer} petNum
   * @returns {json}
   */
PetStore.sync.getPetById = Meteor.wrapAsync(
  function wrpr(args, headers, callback) {
    PetStore.pet.getPetById( args, headers
      , function suxs( theResult ) {
        Logger.info(  'Got pet #' + args.petId  );
        callback(null, theResult);
      }
      , function errs( theError ) {
        Logger.error('For Id #' + args.petId + ' : ' + theError.statusText);
        callback(null, theError);
      }
    );
  }
);

/**
 * Exposure to the Meteor name space.
 * This member of the Meteor namespace groups together the methods that this package will expose to client-side JavaScript
 * @namespace Meteor.${PKG_NAME}
 */
Meteor.methods({
  /**
   * Get a pet by its nrecord id.
   * @name getPetById
   * @memberof Meteor.${PKG_NAME}
   * @method
   * @param  {integer} petNum The PetStore demo API seems to permit full CRUD authority to anonymous users, so we use a couple of very large numbers to minimize the risk of spurious test failure.
   * @returns {json}
   */
  ${PKG_NAME}_getPetById: function getPetById(petNum) {
    var aPetVO = PetStore.sync.getPetById(
      { petId: petNum},
      {responseContentType: 'application/json'}
    );
    return aPetVO.status === 404
    ? {name: JSON.parse(aPetVO.data).message}
    : aPetVO.obj;
  },
});
