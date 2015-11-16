/**
 * @fileOverview The unit tests for "${GITHUB_ORGANIZATION_NAME}:${PKG_NAME}".
 * @author ${YOUR_FULLNAME} <${YOUR_EMAIL}>
 * @version v0.0.1
 * @license MIT
 */

/**
 * Tinytest unit tests
 * @namespace Tinytest
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
  test.equal(true, true);
  Logger.info('ººº Yoo Hoo ººº');
});


/**
 * Simply verifies that false doesn't equal true
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
const expected = 'Your fluffy little wolverine.';
Tinytest.add('Pet #' + petNum + ' is : ' + expected, function obtainPetById(test) {
  var aPet = PetStore.sync.getPetById(
    { petId: petNum}, {responseContentType: 'application/json'}
  );
  test.equal(aPet.obj.name, expected);
});

