Feature: Generador de datos de usuario

  Background:
    * def listaNombres = read('classpath:serverest/data/names.csv')
    * def randomInt = function(min, max) { return Math.floor(Math.random() * (max - min + 1)) + min; }
    #Obtiene nombre aleatoreo a partir de names.csv
    * def getRandomName =
      """
        function(){
          var total = listaNombres.length;
          var randIndex = randomInt(0, total-1);
          return listaNombres[randIndex].nombres;
        }
      """

    * def getRandomEmail =
      """
        function(){
          var idEmail = java.util.UUID.randomUUID().toString();
          return idEmail + '@email.com';
        }
      """
    * def getRandomPassword =
      """
        function(){
          return java.util.UUID.randomUUID().toString();
        }
      """
    * def getRandomTrueOrFalse =
      """
        function(){
          return ( randomInt(0,1) == 1 ? "true" : "false");
        }
      """

  @generate_user
  Scenario: generate user
    * def random = java.util.UUID.randomUUID().toString()
    * def userRequestJson = read('classpath:serverest/schemas/user-request-schema.json')
    * userRequestJson.nome = getRandomName() + ' ' + getRandomName();
    * userRequestJson.email = getRandomEmail();
    * userRequestJson.password = getRandomPassword();
    * userRequestJson.administrador = getRandomTrueOrFalse();



