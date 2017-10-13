Feature: Show a map
  As a user
  To see whats in my area
  I would like to see a map of my area

  @javascript
  Scenario: User can see a map
    Given I navigate to the index page
    And the map has been loaded
    And show me the page
    Then my location is where the center of the map should approximately be: "59.334591" lat and "18.063240" lng
    And I should see a pin on the map
