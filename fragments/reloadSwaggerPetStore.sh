#!/bin/bash
#

function reloadSwaggerPetStore() {
  echo -e "\n\nInserting test values in Swagger Pet Store database . . . "
  curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
    \"id\": 6133627027,
    \"category\": {
      \"id\": 99,
      \"name\": \"wild\"
    },
    \"name\": \"Snowdrop the weasel.\",
    \"status\": \"available\"
  }" "http://petstore.swagger.io/v2/pet"
  echo ""
  curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
    \"id\": 6133627028,
    \"category\": {
      \"id\": 99,
      \"name\": \"wild\"
    },
    \"name\": \"Your fluffy little wolverine.\",
    \"status\": \"available\"
  }" "http://petstore.swagger.io/v2/pet"
  echo ""
  curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
    \"id\": 6133627029,
    \"category\": {
      \"id\": 99,
      \"name\": \"wild\"
    },
    \"name\": \"At last, a 'stay small' family crocodile.\",
    \"status\": \"available\"
  }" "http://petstore.swagger.io/v2/pet"
  echo ""
  curl -X POST --header "Content-Type: application/json" --header "Accept: application/json" -d "{
    \"id\": 6133627030,
    \"category\": {
      \"id\": 99,
      \"name\": \"wild\"
    },
    \"name\": \"Mildred the Mild-Mannered Mandrill\",
    \"status\": \"available\"
  }" "http://petstore.swagger.io/v2/pet"
  echo -e "\n. . . inserted test values in Swagger Pet Store database.\n\n"
}

reloadSwaggerPetStore;
