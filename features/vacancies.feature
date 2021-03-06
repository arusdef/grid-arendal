Feature: Vacancies
In order to manage vacancies
As an adminuser
I want to edit, create, view vacancies

  Scenario: User can view vacancies page
    Given I am authenticated adminuser
    And vacancy
    When I go to the vacancies page
    Then I should see "Researcher"

  Scenario: Adminuser can edit vacancy
    Given vacancy
    And I am authenticated adminuser
    When I go to the edit vacancy page for "Researcher"
    And I fill in "Title" with "vacancy edited"
    And I press "SAVE"
    Then I should see "vacancy edited"

  Scenario: Adminuser can create vacancy
    Given I am authenticated adminuser
    When I go to the new vacancy page
    And I fill in "Title" with "Scientist"
    And I fill in "Description" with "My description"
    And I press "SAVE"
    Then I should have one vacancy

  Scenario: Adminuser can not create vacancy without title
    Given I am authenticated adminuser
    When I go to the new vacancy page
    And I fill in "Title" with ""
    And I fill in "Description" with "My description"
    And I press "SAVE"
    Then I should have zero vacancies
    And I should see "can't be blank"

  @javascript
  Scenario: Publisheruser can publish and unpublish an vacancy
    Given I am authenticated publisheruser
    And vacancy
    When I go to the vacancies page
    Then I should see "Researcher"
    And I click on overlapping ".Publish"
    And I wait for the ajax request to finish
    And I should see "Researcher"
    And I should have one published vacancy
