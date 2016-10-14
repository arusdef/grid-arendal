Feature: Activities
In order to manage activities
As an adminuser
I want to edit, create, view activities

  Scenario: User can view activities page
    Given I am authenticated adminuser
    And activity
    When I go to the activities page
    Then I should see "My activity"

  Scenario: Adminuser can edit activity
    Given activity
    And I am authenticated adminuser
    When I go to the edit activity page for "My activity"
    And I fill in "Title" with "activity edited"
    And I press "Update"
    Then I should see "activity edited"

  Scenario: Adminuser can create activity
    Given I am authenticated adminuser
    And partner
    And news_article
    When I go to the new activity page
    And I fill in "Title" with "My new activity"
    And I fill in "Description" with "My description"
    And I select "Gonca A." from "Users"
    And I select "Partner one" from "Partners"
    And I select "About the Company" from "News articles"
    And I press "Create Activity"
    Then I should have one activity

  Scenario: Adminuser can not create activity without title
    Given I am authenticated adminuser
    And partner
    And news_article
    When I go to the new activity page
    And I fill in "Title" with ""
    And I fill in "Description" with "My description"
    And I select "Gonca A." from "Users"
    And I select "Partner one" from "Partners"
    And I select "About the Company" from "News articles"
    And I press "Create Activity"
    Then I should have zero activities
    And I should see "can't be blank"

  Scenario: Publisheruser can publish and unpublish an activity
    Given I am authenticated publisheruser
    And activity
    When I go to the activities page
    Then I should see "My activity"
    When I follow "Unpublish" within ".publish_unpublish"
    Then I should be on the activities page
    And I should see "My activity"
    And I should see "Publish"
    When I follow "Publish" within ".publish_unpublish"
    Then I should be on the activities page
    And I should see "My activity"
    And I should see "Unpublish"

  Scenario: Publisheruser can make and remove featured status from activity
    Given I am authenticated publisheruser
    And activity
    When I go to the activities page
    Then I should see "My activity"
    And I follow "Remove featured"
    Then I should be on the activities page
    And I should see "My activity"
    And I should see "Make featured"
