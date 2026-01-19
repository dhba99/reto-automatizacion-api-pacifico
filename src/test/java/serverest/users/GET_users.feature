Feature: Obtener lista de usuarios

  Background:
    * url baseUrl
    * def userJson = read('classpath:serverest/schemas/user-response-schema.json')

  @CP-001
  Scenario: Obtener todos los usuario con un status code 200
    Given path 'usuarios'
    When method GET
    Then status 200
    * def idFirstUser = response.usuarios[0]._id
    * def emailFirstUser = response.usuarios[0].email;
    * print "Status 200 retornado correctamente en endpoint GET /usuarios"

  Scenario: Valida que la cantidad de usuarios retornados es la misma que el campo quentidade
    Given path 'usuarios'
    When method GET
    Then status 200
    And response.quantidade == response.usuarios.length
    * print "Total de usuarios retornados es el mismo en el campo quentidade en GET /usuarios"

  Scenario: Valida la estructura de respuesta JSON del usuario
    Given path 'usuarios'
    When method GET
    Then status 200
    And match response.usuarios[1] == userJson
    * print "Formato JSON de usuario validado correctamente"

