/*
const Bunyan = Npm.require('bunyan');
const Logger = Bunyan.createLogger({ "name": "ci4meteor" });
*/

Tinytest.add("example", function sanity(test) {
  Logger.info("ººº Yoo Hoo ººº");
  test.equal(true, true);
});

Tinytest.add("get a pet", function sanity(test) {
  var aPet = PetStore.sync.getPetById(
    { petId: 8},
    {responseContentType: "application/json"}
  );
  test.equal(aPet.obj.name, "Lion5");
});
