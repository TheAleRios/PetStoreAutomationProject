@ignore
Feature: Pet endpoints tests

####################

  Scenario: Verify properly adding a pet to the store
    Given API is up and running
    And I have the following JSON request body:
    """
    {
      "id": "11",
      "name": "doggie",
      "category": {
        "id": 1,
        "name": "Dogs"
     },
     "photoUrls": [
      "string"
     ],
     "tags": [
       {
         "id": 0,
         "name": "string"
       }
     ],
      "status": "available"
    }

    """
    When I send a POST request to "/pet"
    Then the response code should be 200
    And the response body should contain the field "id"
    And the response body should contain the "name" as "doggie"

####################
  
    Scenario: Verify adding a pet to the store only with an id
    Given API is up and running
    And I have the following JSON request body:
    """
    {
      "id": "10"
    }

    """
    When I send a POST request to "/pet"
    Then the response code should be 200
    And the response body should contain the field "id"
    And the response body should contain the field "photoUrls"
    And the response body should contain the field "tags"

####################
    
    Scenario: Verify adding a pet to the store without id
    Given API is up and running
    And I have the following JSON request body:
    """
    {
      "name": "doggie",
      "category": {
        "id": 1,
        "name": "Dogs"
     },
     "photoUrls": [
      "string"
     ],
     "tags": [
       {
         "id": 0,
         "name": "string"
       }
     ],
      "status": "available"
    }

    """
    When I send a POST request to "/pet"
    Then the response code should be 500

    ####################
   
    Scenario: Verify properly deleting a pet from the store
    Given API is up and running
    And I have the following JSON request body:
    """
    {
      "id": "10" 
    }

    """
    When I send a POST request to "/pet"
    Then the response code should be 200
    When I send a DELETE request to "/pet/10"
    Then the response code should be 200
    
    ####################
    
    Scenario: Verify deleting a pet from the store with an invalid id
    Given API is up and running
    When I send a DELETE request to "/pet/asdasd"
    Then the response code should be 400

    ####################
    
    Scenario: Verify getting a pet from store
    Given API is up and running
    And I have the following JSON request body:
    """
    {
      "id": "11",
      "name": "doggie",
      "category": {
        "id": 1,
        "name": "Dogs"
     },
     "photoUrls": [
      "string"
     ],
     "tags": [
       {
         "id": 0,
         "name": "string"
       }
     ],
      "status": "available"
    }

    """
    When I send a POST request to "/pet"
    Then the response code should be 200
    When I send a GET request to "/pet/11"
    Then the response code should be 200
    And the response body should contain the field "id"
    And the response body should contain the "name" as "doggie"
    
    ####################
   
    Scenario: Verify getting a pet from the store with an invalid id
    Given API is up and running
    When I send a GET request to "/pet/asdasd"
    Then the response code should be 400

     ####################
   
    Scenario: Verify getting a pet from the store with an non existing id
    Given API is up and running
    When I send a GET request to "/pet/999999"
    Then the response code should be 404


    ####################
 
  Scenario: Verify properly modifing a pet in the store
    Given API is up and running
    And I have the following JSON request body:
    """
    {
      "id": "11",
      "name": "doggie",
      "category": {
        "id": 1,
        "name": "Dogs"
     },
     "photoUrls": [
      "string"
     ],
     "tags": [
       {
         "id": 0,
         "name": "string"
       }
     ],
      "status": "available"
    }

    """
    When I send a POST request to "/pet"
    Then the response code should be 200
    And the response body should contain the field "id"
    And the response body should contain the "name" as "doggie"
    When I have the following JSON request body:
    """
    {
      "id": "11",
      "name": "doggieModified",
      "category": {
        "id": 1,
        "name": "Dogs"
     },
     "photoUrls": [
      "string"
     ],
     "tags": [
       {
         "id": 0,
         "name": "string"
       }
     ],
      "status": "available"
    }

    """

    When I send a PUT request to "/pet"
    Then the response code should be 200
    And the response body should contain the field "id"
    And the response body should contain the "name" as "doggieModified"

    ####################
   
    Scenario: Verify properly modifing a pet with form data
    Given API is up and running
    And I have the following JSON request body:
    """
    {
      "id": "11",
      "name": "doggie",
      "category": {
        "id": 1,
        "name": "Dogs"
     },
     "photoUrls": [
      "string"
     ],
     "tags": [
       {
         "id": 0,
         "name": "string"
       }
     ],
      "status": "available"
    }

    """
    When I send a POST request to "/pet"
    Then the response code should be 200
    When I have the following parameters:
    |     name     |    DoggieForm   |
    |    status    |   unavailable   |
    And I send a POST request with parameters to "/pet/11"
    Then the response code should be 200
    And the response body should contain the "name" as "DoggieForm"
    And the response body should contain the "status" as "unavailable"

    ####################
    
    Scenario: Verify modifing a pet only with status
    Given API is up and running
    And I have the following JSON request body:
    """
    {
      "id": "11",
      "name": "doggie",
      "category": {
        "id": 1,
        "name": "Dogs"
     },
     "photoUrls": [
      "string"
     ],
     "tags": [
       {
         "id": 0,
         "name": "string"
       }
     ],
      "status": "available"
    }

    """
    When I send a POST request to "/pet"
    Then the response code should be 200
    When I have the following parameters:
    |    status   | unavailable | 
    And I send a POST request with parameters to "/pet/11"
    Then the response code should be 400

    ####################
    
    Scenario: Verify modifing a pet only with name
    Given API is up and running
    And I have the following JSON request body:
    """
    {
      "id": "11",
      "name": "doggie",
      "category": {
        "id": 1,
        "name": "Dogs"
     },
     "photoUrls": [
      "string"
     ],
     "tags": [
       {
         "id": 0,
         "name": "string"
       }
     ],
      "status": "available"
    }

    """
    When I send a POST request to "/pet"
    Then the response code should be 200
    When I have the following parameters:
    |    name   | doggie2 | 
    And I send a POST request with parameters to "/pet/11"
    Then the response code should be 200


    ####################
    
    
    Scenario: Verify properly uploading an image
    Given API is up and running
    And I have the following JSON request body:
    """
    {
      "id": "11",
      "name": "doggie",
      "category": {
        "id": 1,
        "name": "Dogs"
     },
     "photoUrls": [
      "string"
     ],
     "tags": [
       {
         "id": 0,
         "name": "string"
       }
     ],
      "status": "available"
    }

    """
    When I send a POST request to "/pet"
    Then the response code should be 200
    When I have the file "src/test/resources/images/cat.jpg"
    And I send a POST request to "/pet/11/uploadImage" to upload the image
    Then the response code should be 200
    And the response body should contain a ".tmp" file

  

    ####################
  
    Scenario: Verify getting a pet by status
    Given API is up and running
    And I have the following parameters:
    |     status         |   <status>    | 
    When I send a GET request to "/pet/findByStatus"
    Then the response code should be 200

    Examples:
        | status    |
        | available |
        |   sold    |
        |  pending  |

    ####################
    
    Scenario: Verify getting a pet by a non valid status
    Given API is up and running
    And I have the following parameters:
    |     status     |  <status>    |
    When I send a GET request to "/pet/findByStatus"
    Then the response code should be 400

        Examples:
        |  status   |
        |   5656    |
        |           |

        ####################
    
    Scenario: Verify getting a pet by existing tags
    Given API is up and running
    And I have the following parameters:
    |     tags     |  tag4   |
    When I send a GET request to "/pet/findByTags"
    Then the response code should be 200
    And the response has data arrays

    ####################
    
    Scenario: Verify getting a pet by non existing tags
    Given API is up and running
    And I have the following parameters:
    |     tags     |  99999   |
    When I send a GET request to "/pet/findByTags"
    Then the response code should be 200
    And the response is empty

    
    