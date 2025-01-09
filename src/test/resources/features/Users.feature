Feature: Users endpoints tests

  ####################

  Scenario: Verify properly adding a user to the store
    Given API is up and running
    And I have the following JSON request body:
    """
    {
    "id": 10,
    "username": "theUser",
    "firstName": "John",
    "lastName": "James",
    "email": "john@email.com",
    "password": "12345",
    "phone": "12345",
    "userStatus": 1
    }

    """
    When I send a POST request to "/user"
    Then the response code should be 200

  ####################
 
  Scenario: Verify adding a user to the store with no data
    Given API is up and running
    And I have the following JSON request body:
    """

    """
    When I send a POST request to "/user"
    Then the response code should be 400


  ####################

  
  Scenario: Verify adding a user to the store with an empty json
    Given API is up and running
    And I have the following JSON request body:
    """
    {

    }

    """
    When I send a POST request to "/user"
    Then the response code should be 500
   

    ####################

  Scenario: Verify loging with an existing user
    Given API is up and running
    And I have the following JSON request body:
    """
    {
    "id": 10,
    "username": "theUser",
    "firstName": "John",
    "lastName": "James",
    "email": "john@email.com",
    "password": "12345",
    "phone": "12345",
    "userStatus": 1
    }

    """
    When I send a POST request to "/user"
    Then the response code should be 200
    When I have the following parameters:
    |   username  |  theUser  | 
    |   password  |   12345   |
    When I send a GET request to "/user/login"
    Then the response code should be 200


    ####################
    
    Scenario: Verify logout
    Given API is up and running
    When I send a GET request to "/user/logout"
    Then the response code should be 200
    
    ####################
  
    Scenario: Verify getting a user by name
    Given API is up and running
    And I have the following JSON request body:
    """
    {
    "id": 10,
    "username": "theUser",
    "firstName": "John",
    "lastName": "James",
    "email": "john@email.com",
    "password": "12345",
    "phone": "12345",
    "userStatus": 1
    }

    """
    When I send a POST request to "/user"
    Then the response code should be 200
    When I send a GET request to "/user/theUser"
    Then the response code should be 200
    And the response body should contain the field "id"
    And the response body should contain the "username" as "theUser"

    ####################
    
    Scenario: Verify getting a user with a non existing name
    Given API is up and running
    When I send a GET request to "/user/89898989"
    Then the response code should be 404
 
    ####################

   Scenario: Verify updating an existing user
    Given API is up and running 
    And I have the following JSON request body:

    """
    {
    "id": 15,
    "username": "theUser5",
    "firstName": "John",
    "lastName": "James",
    "email": "john@email.com",
    "password": "12345",
    "phone": "12345",
    "userStatus": 1
    }

    """

    When I send a POST request to "/user"
    Then the response code should be 200
    When I have the following JSON request body:

    """
     {
    "id": 15,
    "username": "theUser5",
    "firstName": "John",
    "lastName": "James",
    "email": "john@email.com",
    "password": "12345",
    "phone": "12345",
    "userStatus": 1
    }

    """
    
    When I send a PUT request to "/user/theUser5"
    Then the response code should be 200
    And the response body should contain the field "id"
    And the response body should contain the "firstName" as "JohnModified"

    ####################

    Scenario: Verify updating a user with a non existing name
    Given API is up and running 
    And I have the following JSON request body:
    """
    {
    "id": 10,
    "username": "theUser",
    "firstName": "John",
    "lastName": "James",
    "email": "john@email.com",
    "password": "12345",
    "phone": "12345",
    "userStatus": 1
    }

    """
    When I send a PUT request to "/user/theUser999999"
    Then the response code should be 405
    
    ####################
    
    Scenario: Verify properly adding a list of users to the store
    Given API is up and running 
    And I have the following JSON request body:
    """
    [
      {
        "id": 20,
        "username": "Emma",
        "firstName": "Emma",
        "lastName": "Bunton",
        "email": "ema@email.com",
        "password": "12345",
        "phone": "12345",
        "userStatus": 1
      },
      {
        "id": 21,
        "username": "MelB",
        "firstName": "Mel",
        "lastName": "B",
        "email": "melb@email.com",
        "password": "12345",
        "phone": "12345",
        "userStatus": 1
      },
      {
        "id": 22,
        "username": "MelC",
        "firstName": "Melanie",
        "lastName": "C",
        "email": "melc@email.com",
        "password": "12345",
        "phone": "12345",
        "userStatus": 1
      }
      
    ]

    """
    When I send a POST request to "/user/createWithList"
    Then the response code should be 200

    ####################
 
    Scenario: Verify deleting a user
    Given API is up and running 
    And I have the following JSON request body:
    """
    {
    "id": 10,
    "username": "theUser",
    "firstName": "John",
    "lastName": "James",
    "email": "john@email.com",
    "password": "12345",
    "phone": "12345",
    "userStatus": 1
    }

    """
    When I send a POST request to "/user"
    Then the response code should be 200
    When I send a GET request to "/user/theUser"
    Then the response code should be 200
    When I send a DELETE request to "/user/theUser"
    Then the response code should be 200
    When I send a GET request to "/user/theUser"
    Then the response code should be 404

    #############################

    Scenario: Verify deleting a user with a non existing user name
    Given API is up and running 
    When I send a DELETE request to "/user/999999"
    Then the response code should be 404
