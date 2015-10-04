var webdriver = null;
try {
   webdriver = require('selenium-webdriver');
}
catch (e) {
   console.log(e.message);
   if (e.message.indexOf("Cannot find module") > -1) {
     console.log("Selenium Webdriver needs to be installed.  Please run :");
     console.log("   npm install selenium-webdriver");
   } else {
     throw e;
   }
   process.exit(1);
}

var chrome = require('selenium-webdriver/chrome');

var options = new chrome.Options();
var logOptions = new webdriver.logging.Preferences();
logOptions.setLevel('browser', webdriver.logging.Level.ALL);
options.setLoggingPrefs(logOptions);

var driver = new chrome.Driver(options);

console.log("  > Opening Meteor test suite...");
driver.get('http://127.0.0.1:4096').then(function() {
  console.log("  > Running tests...");

  // Wait for tests to complete.
  var pollTimer = setInterval(function() {
    // Output logs while the tests are running.
    driver.manage().logs().get('browser').then(function (log) {
      for (var index in log) {
        var entry = log[index];
        console.log("    [" + entry.level.name + "] " + entry.message);
      }
    });

    driver.executeScript(function() {
      if (typeof TEST_STATUS !== 'undefined')
        return TEST_STATUS.DONE;
      return typeof DONE !== 'undefined' && DONE;
    }).then(function(done) {
      if (done) {
        clearInterval(pollTimer);
        driver.executeScript(function () {
          if (typeof TEST_STATUS !== 'undefined')
            return TEST_STATUS.FAILURES;
          if (typeof FAILURES === 'undefined') {
            return 1;
          }
          return 0;
        }).then(function (failures) {
          // Output final logs.
          driver.manage().logs().get('browser').then(function (log) {
            for (var index in log) {
              var entry = log[index];
              console.log("    [" + entry.level.name + "] " + entry.message);
            }

            driver.quit().then(function() {
              console.log("  > Tests completed " + (failures ? "WITH FAILURES" : "OK") + ".");
              process.exit(failures ? 1 : 0);
            });
          });
        });
      }
    });
  }, 500);
});
