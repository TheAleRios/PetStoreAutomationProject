package stepdefinitions; 

import test.java.utils.ScenarioContext;

import io.cucumber.java.en.*;
import io.restassured.RestAssured;
import org.junit.jupiter.api.Assertions;

import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;

import static org.hamcrest.Matchers.*;

import java.io.File;
import java.util.Map;

public class petStorePetSteps {

    private RequestSpecification request;
    private Response response;
    private String requestBody;

    @Given("API is up and running")
    public void api_is_up_and_running() {

        String env = System.getProperty("env", "prod");

        String baseUrl;
        switch (env.toLowerCase()) {
            case "staging":
                baseUrl = System.getProperty("baseUrlStaging", System.getenv("BASE_URL_STAGING"));
                break;
            case "local":
                baseUrl = System.getProperty("baseUrlLocal", System.getenv("BASE_URL_LOCAL"));
                break;
            default:
                baseUrl = System.getProperty("baseUrlProd", System.getenv("BASE_URL_PROD"));
                break;
        }

        RestAssured.baseURI = baseUrl;
        request = RestAssured.given().header("Content-Type", "application/json");

        System.out.println("Using environment: " + env);
        System.out.println("Base URL: " + baseUrl);

    }

    @Given("I have the following JSON request body:")
    public void i_have_the_following_json_request_body(String jsonBody) {
        // Store json
        requestBody = jsonBody;
    }

    @When("I send a POST request to {string}")
    public void i_send_a_post_request_to(String endpoint) {
        // Send POST request
        response = request.body(requestBody).post(endpoint);
    }

    @When("I send a DELETE request to {string}")
    public void i_send_a_delete_request_to(String endpoint) {
        // Send DELETE request
        response = request.delete(endpoint);
    }

    @When("I send a GET request to {string}")
    public void i_send_a_get_request_to(String endpoint) {
        // Send GET request
        response = request.get(endpoint);
    }

    @When("I send a PUT request to {string}")
    public void i_send_a_put_request_to(String endpoint) {
        // Send PUT request
        response = request.body(requestBody).post(endpoint);
    }

    @When("I have the following parameters:")
    public void i_have_the_following_parameters(io.cucumber.datatable.DataTable dataTable) {
   
    request = RestAssured.given().header("Content-Type", "application/x-www-form-urlencoded");

    Map<String, String> params = dataTable.asMap(String.class, String.class);

    for (Map.Entry<String, String> entry : params.entrySet()) {
        request.queryParam(entry.getKey(), entry.getValue());
    }

    System.out.println("Query parameters added: " + params);
    }   

    @When("I send a POST request with parameters to {string}")
    public void i_send_a_post_request_with_parameters_to(String endpoint) {
    // Send a POST request different from the other post
         response = request.log().all().post(endpoint);
    }

    @Then("the response code should be {int}")
    public void the_response_code_should_be(Integer statusCode) {
        // Verifiy status code
        response.then().statusCode(statusCode);
    }

    @Then("the response body should contain the field {string}")
    public void the_response_body_should_contain_the_field(String field) {
        // Verify field
        response.then().body("$", hasKey(field));
    }

    @Then("the response body should contain the {string} as {string}")
    public void the_response_body_should_contain_the_as(String field, String expectedValue) {
    
       try {
        // Try to convert value to integer
        Integer expectedIntValue = Integer.parseInt(expectedValue);
        response.then().body(field, equalTo(expectedIntValue));
        } catch (NumberFormatException e) {
            // If convertion fails then is a string and should be used as a string
            response.then().body(field, equalTo(expectedValue));
        }
    }
    
    @When("I have the file {string}")
    public void iHaveTheFile(String filePath) {
    File file = new File(filePath);
    if (!file.exists()) {
        throw new IllegalArgumentException("File not found at path: " + filePath);
    }
    // Save the file in the context:
    ScenarioContext.set("fileToUpload", file);
    }

    @When("I send a POST request to {string} to upload the image")
    public void iSendAPOSTRequestToUploadImage(String endpoint) {

        File file = new File("src/test/resources/images/cat.jpg");
        Response response = RestAssured.given()
        .header("accept", "application/json")  
        .header("Content-Type", "application/octet-stream")  
        .body(file)  
        .log().all()
        .when()
        .post(endpoint)
        .then()
        .log().all()
        .extract()
        .response();
        
    ScenarioContext.set("response", response); ;
    }

    @Then("the response body should contain a {string} file")
    public void theResponseBodyShouldContainAFile(String expectedExtension) {

        Response response = (Response) ScenarioContext.get("response");
        String responseBody = response.getBody().asString();

        Assertions.assertTrue(responseBody.contains(".tmp"),
        "Expected response body to contain '.tmp' but got: " + responseBody);
    
    }

    @Then("the response has data arrays")
    public void the_response_has_data_arrays() {
    
    response.then().body("$", hasSize(greaterThan(0)));
    }

    @Then("the response is empty")
    public void the_response_is_empty() {
   
    response.then().body("$", hasSize(0));
    }
}