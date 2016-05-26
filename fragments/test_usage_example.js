/**
 * @fileOverview The unit tests for "${MODULE_NAME}".
 * @author ${YOUR_FULLNAME} <${YOUR_EMAIL}>
 * @version v0.0.1
 * @license MIT
 */

/**
 * NightWatch End-to-end Tests
 * @namespace EndToEndTests
 **/

/**
 * Can we retrieve pets by their ID numbers?
 * @name obtainPetsByIds
 * @memberof EndToEndTests
 * @function
 * @param  null
 * @return {None}
 */
module.exports = {
  'Step Through Pets': function obtainPetsByIds(client) {
    client
      .url('http://localhost:3000')
      .waitForElementVisible('body', 1000)
      .verify.elementPresent('button[id=nextPet]')
      .verify.elementPresent('p[id=petNote]')
      .assert.containsText('p[id=petNote]', '6133627026')
      .assert.containsText('p[id=petNote]', 'unknown')
      .click('button[id=nextPet]')
      .pause(3000)
      .assert.containsText('p[id=petNote]', '6133627027')
      .assert.containsText('p[id=petNote]', 'weasel')

      .end();
  },
};
