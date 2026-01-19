Feature: Eliminar usuario por id

  Background:
    * url baseUrl
    * def userJson = read('classpath:serverest/schemas/user-response-schema.json')


  Scenario: Eliminar usuario por id con un status code 200
    * def createdUser = call read('POST_users.feature@CP-201')
    * def idUserCreated = createdUser.idUserCreated
    Given path 'usuarios/' + idUserCreated
    When method DELETE
    Then status 200
    And match response.message == "Registro excluído com sucesso"
    * print "Status 200 retornado correctamente en endpoint DELETE /usuarios/{id}"

  Scenario Outline: Valida que al eliminar por un ID no existente retorne status code 200
    Given path 'usuarios/' + non_id
    When method DELETE
    Then status 200
    And match response.message == "Nenhum registro excluído"
    * print "Status 200 retornado correctamente al intentar eliminar usuario por un ID no existente en endpoint DELETE /usuarios/{id}"

    Examples:
      | non_id           |
      | 1111111111111111 |
      | 2222222222222222 |
      | 3123321          |
      | 3fdsff           |
      | fdsfdsfdsfdsfdsf |

