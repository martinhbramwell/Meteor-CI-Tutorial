/**
 * @fileOverview The unit tests for 'yourpackage'.
 * @author Your Self <yourself.yourorg@gmail.com>
 * @version v0.0.1
 * @license MIT
 */

/**
 * Tinytest unit tests
 * @namespace Tinytest
 */
/*
const Bunyan = Npm.require('bunyan');
const Logger = Bunyan.createLogger({ 'name': 'ci4meteor' });
*/
/**
 * Simply verifies that true equals true
 * @name sanityCheckEQ
 * @memberof Tinytest
 * @function
 * @param  test {Tinytest} Check Equality
 * @return {None}
 */
Tinytest.add('Check Equality', function sanityCheckEQ(test) {
  Logger.info('ººº Yoo Hoo ººº');
  test.equal(true, true);
});

/**
 * Simply verifies that true doesn't equal false
 * @name sanityCheckNEQ
 * @memberof Tinytest
 * @function
 * @param  test {Tinytest} Check Inequality
 * @return {None}
 */
Tinytest.add('Check Inequality', function sanityCheckNEQ(test) {
  test.notEqual(true, false);
});


/**
 * Can we retrieve a pet by its ID number?
 * @name obtainPetById
 * @memberof Tinytest
 * @function
 * @param  test {Tinytest} Pet #petNum is : expected
 * @return {None}
 */
const petNum = 6133627028;
const expected = 'Your fluffy little wolverine';
Tinytest.add('Pet #' + petNum + ' is : ' + expected, function obtainPetById(test) {
  var aPet = PetStore.sync.getPetById(
    { petId: petNum},
    {responseContentType: 'application/json'}
  );
  test.equal(aPet.obj.name, expected);
});
