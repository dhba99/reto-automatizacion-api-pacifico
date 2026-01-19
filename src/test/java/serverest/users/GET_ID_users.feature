@GET_ID_users_endpoint @regression
Feature: Obtener usuario por id

  Background:
    * url baseUrl
    * def userJson = read('classpath:serverest/schemas/user-response-schema.json')
    * def getUsers = call read('GET_users.feature@CP-001')
    * def idFirstUser = getUsers.idFirstUser


  @CP-101
  Scenario: Obtener usuario por id con un status code 200
    Given path 'usuarios/' + idFirstUser
    When method GET
    Then status 200
    * print "Status 200 retornado correctamente en endpoint GET /usuarios/{id}"

  @CP-102
  Scenario: Valida la estructura de respuesta JSON del usuario con un status code 200
    Given path 'usuarios/' + idFirstUser
    When method GET
    Then status 200
    And match response == userJson
    * print "Formato JSON de usuario validado correctamente"

  @CP-103
  Scenario Outline: Valida que al consultar por un ID no existente retorne status code 400
    Given path 'usuarios/' + non_id
    When method GET
    Then status 400
    And match response.message == "Usuário não encontrado"
    * print "Status 400 retornado correctamente al consultar por un ID no existente en endpoint GET /usuarios/{id}"

    Examples:
    |non_id          |
    |1111111111111111|
    |2222222222222222|

  @CP-104
  Scenario Outline: Valida que al consultar con un ID con un tamano diferente a 16 digitos y/o con caracteres no-digitos retorne status code 400
    Given path 'usuarios/' + non_id
    When method GET
    Then status 400
    And match response.id == "id deve ter exatamente 16 caracteres alfanuméricos"
    * print "Status 400 retornado correctamente al consultar por un ID con formato incorrecto en endpoint GET /usuarios/{id}"

    Examples:
    |non_id           |
    |3123321          |
    |3fdsff           |

