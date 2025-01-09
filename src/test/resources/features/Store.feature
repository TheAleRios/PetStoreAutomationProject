Feature: Store endpoints tests

  ####################

  Scenario: Verify properly adding an order to the store
    Given API is up and running
    And I have the following JSON request body:
    """
     
    {
    "id": 1,
    "petId": 198772,
    "quantity": 7,
    "shipDate": "2025-01-08T02:05:53.673Z",
    "status": "approved",
    "complete": true
    }

    """
    When I send a POST request to "/store/order"
    Then the response code should be 200
    And the response body should contain the field "id"
    And the response body should contain the "status" as "approved"

  ####################
 
  Scenario: Verify adding an order to the store with no data
    Given API is up and running
    And I have the following JSON request body:
    """

    """
    When I send a POST request to "/store/order"
    Then the response code should be 400

  ####################

  Scenario: Verify adding an order to the store with an empty json
    Given API is up and running
    And I have the following JSON request body:
    """
    {

    }

    """
    When I send a POST request to "/store/order"
    Then the response code should be 200
    And the response body should contain the "id" as "0"

    ####################
    
    Scenario: Verify properly deleting an order from the store
    Given API is up and running
    And I have the following JSON request body:
    """
     
    {
    "id": 1,
    "petId": 198772,
    "quantity": 7,
    "shipDate": "2025-01-08T02:05:53.673Z",
    "status": "approved",
    "complete": true
    }

    """
    When I send a POST request to "/store/order"
    Then the response code should be 200
    When I send a DELETE request to "/store/order/1"
    Then the response code should be 200  
    
    ####################

    Scenario: Verify getting an order by id from the store
    Given API is up and running
    And I have the following JSON request body:
    """
     
    {
    "id": 1,
    "petId": 198772,
    "quantity": 7,
    "shipDate": "2025-01-08T02:05:53.673Z",
    "status": "approved",
    "complete": true
    }

    """
    When I send a POST request to "/store/order"
    Then the response code should be 200
    When I send a GET request to "/store/order/1"
    Then the response code should be 200  
    

    ####################
  
    @ignore
    Scenario: Verify getting the inventory from the store
    Given API is up and running
    When I send a GET request to "/store/inventory"
    Then the response code should be 200
    And the response body should contain the field "approved"
    And the response body should contain the field "placed"
    And the response body should contain the field "delivered"