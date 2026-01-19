Feature: Actualiza usuario por id

  Background:
    * url baseUrl
    * def getUsers = call read('GET_users.feature@CP-001')
    * def idFirstUser = getUsers.idFirstUser
    * def emailUserExistent = getUsers.emailFirstUser


  @CP-301
  Scenario: Agregar usuario correctamente retornando un status code 201
    * def generateUser = call read('classpath:serverest/utils/generate-users.feature@generate_user')
    * def randomUser = generateUser.userRequestJson
    * print randomUser
    Given path 'usuarios/' + idFirstUser
    And request randomUser
    When method PUT
    Then status 200
    And match response.message == 'Registro alterado com sucesso'
    * print "Status 201 retornado correctamente en endpoint POST /usuarios"

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