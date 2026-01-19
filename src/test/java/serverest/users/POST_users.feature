@POST_users_endpoint @regression
Feature: Agregar usuario por id

  Background:
    * url baseUrl
    * def getUsers = call read('GET_users.feature@CP-001')
    * def emailUserExistent = getUsers.emailFirstUser


  @CP-201
  Scenario: Agregar usuario correctamente retornando un status code 201
    * def generateUser = call read('classpath:serverest/utils/generate-users.feature@generate_user')
    * def randomUser = generateUser.userRequestJson
    * print randomUser
    Given path 'usuarios'
    And request randomUser
    When method POST
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    * def idUserCreated = response._id
    * print "Status 201 retornado correctamente en endpoint POST /usuarios"

  @CP-202
  Scenario Outline: Agregar usuario con algun campo vacio retornando un status code 400
    * def generateUser = call read('classpath:serverest/utils/generate-users.feature@generate_user')
    * def randomUser = generateUser.userRequestJson
    * print randomUser
    And randomUser[attribute] = ''
    Given path 'usuarios'
    And request randomUser
    When method POST
    Then status 400
    * print response
    And match errorMessage == response[errorProperty]
    * def idUserCreated = response._id
    * print "Status 400 retornado correctamente al enviar campos vacios en request en endpoint POST /usuarios"

    Examples:
      | attribute     | errorProperty | errorMessage                      |
      | nome          | nome          | nome não pode ficar em branco     |
      | password      | password      | password não pode ficar em branco |
      | email         | email         | email não pode ficar em branco    |
      | administrator | administrator | administrator não é permitido     |

  @CP-203
  Scenario: Agregar usuario con email existente retornando un status code 400
    * def generateUser = call read('classpath:serverest/utils/generate-users.feature@generate_user')
    * def randomUser = generateUser.userRequestJson
    * print randomUser
    And randomUser.email = emailUserExistent
    Given path 'usuarios'
    And request randomUser
    When method POST
    Then status 400
    * print response
    And match response.message == "Este email já está sendo usado"
    * print "Status 400 retornado correctamente al enviar email ya existente en endpoint POST /usuarios"