# Pet Store Test Automation Framework

This framework automates API testing for the Pet Store application. It is designed to work with three environments: **local**, **staging**, and **production**. The production environment is the most stable, but it still occasionally encounters `500` errors, primarily in the `users` endpoint. Despite these challenges, 75% of the tests currently pass successfully.

## System Requirements

- **Java Development Kit (JDK):** Version 11 or higher
- **Gradle:** Version 7.x or higher
- **Docker (optional):** For running the Pet Store API locally
- **Internet connection:** Required for accessing staging or production environments
- **K6 (for performance testing): [K6 Installation Guide](https://grafana.com/docs/k6/latest/set-up/install-k6/)



## Framework Features

- Supports dynamic environment configuration (local, staging, production) using system properties or environment variables.
- Automates testing of major Pet Store functionalities, such as `pets`, `orders`, and `users` endpoints.
- Generates detailed test execution reports.
- Includes retry logic for unstable API endpoints.
- Performance Testing: Added support for performance testing with K6 to monitor the API under load and identify potential bottlenecks.

## Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. Install dependencies:

- Ensure JDK and Gradle are installed and configured in your system.
- For local testing, ensure Docker is installed and running.
- Install K6 for performance testing by following the installation instructions [here](https://grafana.com/docs/k6/latest/set-up/install-k6/).

## Running in Local Environment
1. Start the Pet Store API container using Docker:
```bash
   docker run -d -p 8080:8080 swaggerapi/petstore3
   ```
###### This command will run the Pet Store API locally on http://localhost:8080.


2. (Optional) Clean and rebuild the project to avoid any previous build issues:
```bash
   gradle clean build
   ```
3. 
```bash
   gradle test -Denv=local
   ```

## Performance Testing with K6
This framework includes performance tests for the Pet Store API, powered by K6. These tests simulate multiple virtual users (VUs) interacting with the API to evaluate its performance under load.
### Running Performance Tests



To run the K6 performance tests, use the following command:
```bash
   k6 run performance-tests/load-test.js
   ```
###### This will execute the load test defined in the load-test.js script, which tests the API under different levels of load.

### Performance Test Scenarios
The load-test.js script is configured to run a scenario with 100 virtual users (VUs) executing the tests for 20 seconds. The test checks if the API returns a status of 200 for all requests

### Performance Test Reports
After the test completes, K6 will provide a summary report in the terminal with key metrics such as:
- Number of requests per second
- Average response time
- Number of failed requests
- HTTP request duration and other performance-related statistics
##### You can customize the K6 performance tests to include different load scenarios, such as simulating more virtual users or adjusting the duration.

### Example Performance Test Metrics
```csharp
   ✓ status is 200

checks.........................: 100.00% 20 out of 20
data_received..................: 59 kB   5.4 kB/s
data_sent......................: 3.0 kB  272 B/s
http_req_blocked...............: avg=433.4ms  min=0s       med=0s       max=3.56s    p(90)=1.75s    p(95)=3.55s
http_req_duration..............: avg=178.82ms min=167.99ms med=173.03ms max=213.26ms p(90)=201.68ms p(95)=209.68ms
http_req_failed................: 0.00%   0 out of 20

   ```



## Project Structure

```bash
.
├── src
│   ├── main
│   │   └── java
│   └── test
│       ├── java
│       │   ├── stepdefinitions        # Cucumber step definitions
│       │   ├── config                 # Configuration files
│       │   ├── Runners                # Test runners
│       │   ├── utils                  # Utility classes for test setup and context
│       │   └── RunCucumberTest.java   # Cucumber configuration
│       ├── resources
│       │   ├── features             # Cucumber feature files
│       │   ├── images               # Image files
│       │   ├── cucumber.properties  # Cucumber properties file
│       │   └── serenity.conf        # Serenity configuration file
├── Dockerfile                       # Docker file
├── .env                             # Environment configuration file
├──  settings.gradle                 #Gradle settings file
├── build.gradle                     # Gradle build file
└── README.md                        # Project documentation


```

## Configuring Environments
The framework supports three environments:
- local
- staging
- production (default)

You can configure the environment in two ways:

1. Using System Properties: Pass the environment as a Gradle parameter:
 ```bash
   gradle test -Denv=staging
   ```
2. Using Environment Variables: Set the ENV variable before running the tests:
 ```bash
   export ENV=local
   gradle test
   ```

If no environment is specified, the tests will run against the production environment (https://petstore3.swagger.io/api/v3).

## Running Tests
- To run all tests:
```bash
   gradle test
   ```
- To run tests for a specific tag (e.g., @user):
```bash
   gradle test -Dcucumber.filter.tags="@user"
   ```
- To view detailed logs:
```bash
   gradle test --info
   ```

## Reports
Test execution reports are generated in the build/reports/tests/test directory. You can open the index.html file in your browser to view a detailed summary of the results.

## Known Issues
- 500 Errors on Production:
   - The users endpoint occasionally returns server errors.
   - These issues are outside the scope of the test automation framework and are related to the API's stability.


## Additional Notes
- Retry Logic: The framework includes retry mechanisms for unstable endpoints to reduce false negatives.
- Test Coverage: Currently, approximately 75% of tests pass successfully, mainly due to server-side issues.

## Future Enhancements
- Implement monitoring for API downtime and notify the team.
- Improve retry logic to handle specific error codes more effectively.
- Add support for additional endpoints and negative test cases.


Feel free to contribute to this framework or report issues via the repository's issue tracker.

##

 ###### Author: Alejandro Rios 