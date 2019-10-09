#Author: your.email@your.domain.com
#Keywords Summary :
#Feature: List of scenarios.
#Scenario: Business rule through list of steps with arguments.
#Given: Some precondition step
#When: Some key actions
#Then: To observe outcomes or validation
#And,But: To enumerate more Given,When,Then steps
#Scenario Outline: List of steps for data-driven as an Examples and <placeholder>
#Examples: Container for s table
#Background: List of steps run before each of the scenarios
#""" (Doc Strings)
#| (Data Tables)
#@ (Tags/Labels):To group Scenarios
#<> (placeholder)
#""
## (Comments)
#Sample Feature Definition Template
@test1
Feature: testing company mock web services

 Background:
  * url 'http://localhost:8080'

 Scenario: get all companies

  Given path 'companies'
  When method get
  Then status 200
  And match $ == '#[2]'
   # checks that the body of the response  has two elements, as we have stubbed for two companies 
  And match each $ contains {name: '#notnull'}
  And match each $ contains {email: '#notnull'}
  #checks if each element has this fields and are not null
