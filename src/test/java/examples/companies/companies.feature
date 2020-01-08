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

Feature: testing company mock web services

 Background:
  * url 'http://localhost:8080'
@testGET1
 Scenario: get all companies

  Given path 'companies'
  When method get
  Then status 200
  And match $ == '#[2]'
   # checks that the body of the response  has two elements, as we have stubbed for two companies 
  And match each $ contains {name: '#notnull' }
  And match each $ contains {email: '#notnull' }
  #checks if each element has this fields and are not null
@testGET2
	Scenario Outline: check company name
* def name = {name: '<name>'}
 Given path 'companies', '<cif>' 
 #the steps can use <> that reference headers in the examples table
 When method get
 Then status 200
 And match $ contains name
 # name varible is defined above to avoid writing the json in the match line 
 
 # an example is also a test, they are an executable specification of the system and the scenario outline 
 # is runned once for each row in the examples sections beneath it 
 Examples:
   | cif       | name              |
   | B84946656 | Paradigma Digital |
   | B82627019 | Minsait by Indra  |
   
   
@testPOST
 Scenario Outline: create new companies

 Given path 'companies'
 * def comp =
 """
 {
   "cif": '<cif>',
   "name": '<name>',
   "email": '<email>'
 }
 """
 When request comp
 #there was an error while using the word company
 And method POST
 Then status 201
 And match $ contains comp
 And match $ contains {cif: '#notnull'}

 Examples:
   | cif       | name    | email              |
   | B18996504 | Stratio | info@stratio.com   |
 