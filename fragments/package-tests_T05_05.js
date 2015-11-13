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
 * Simply verifies that true equals true
 * @name sanityCheckEQ
 * @memberof Tinytest
 * @function
 * @param  test {Tinytest} Check Equality
 * @return {None}
 */
Tinytest.add('Check Equality', function sanityCheckEQ(test) {
  test.equal(true, true);
});

//  FIXME PLEASE
Tinytest.add('Check inequality', function sanityCheckNEQ(test) {
  test.notEqual(true, false);
});
