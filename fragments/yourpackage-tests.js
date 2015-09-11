/**
 * @fileOverview The unit tests for "yourpackage".
 * @author Your Self <yourself.yourorg@gmail.com>
 * @version v0.0.1
 * @license MIT
 */

/**
 * Tinytest unit tests
 * @namespace Tinytest
 */

/** 
 * Simply verifies that true is equal to true
 * @name sanityCheckEQ
 * @function
 * @memberof Tinytest
 */
Tinytest.add('Check Equality', function sanityCheckEQ(test) {
  test.equal(true, true);
});

/** 
 * Simply verifies that true is NOT equal to false
 * @name sanityCheckNEQ
 * @function
 * @memberof Tinytest
 */
Tinytest.add('Check inequality', function sanityCheckNEQ(test) {
  test.notEqual(true, false);
});
