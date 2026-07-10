# Automatizacion de API ServeRest con Karate DSL

# Proyecto de Automatización de Pruebas

Automatización de pruebas funcionales y de integración para APIs / aplicaciones usando un framework de testing.

## Tecnologías

- Java 17+
- Maven  
- Karate



## Requisitos

- Java 17 o superior  
- Maven 3.8+  
- Variables de entorno configuradas:
  - `JAVA_HOME`
  - `MAVEN_HOME`

## Configuración

Clonar repositorio:

```bash
git clone https://github.com/dhba99/api-automation-karatedsl.git
cd api-automation-karatedsl
```

Instalar dependencias:

```bash
mvn clean install -DskipTests
```

## Ejecución de pruebas:

Ejecutar un runner específico:

```bash
mvn test -Dtest=UserRunner
```

Ejecutar por tag:

```bash
mvn test -Dkarate.options="--tags @regression"
```

## Convenciones

Features en src/test/resources/features

Escenarios usan los siguientes tags: 
```bash
- @regression,
- @GET_ID_users_endpoint,
- @DELETE_users_endpoint,
- @GET_users_endpoint,
- @POST_users_endpoint,
- @PUT_users_endpoint
```

- Features en src/test/java/serverest/users
- Escenarios deben usar tags: @smoke, @regression, @negative
- Esquemas JSON en schemas/
- Datos de prueba en data/

## Estrategia de automatizacion

Este proyecto utiliza una estrategia de automatización orientada a pruebas de API por capas, enfocada en:
- Validación funcional de endpoints (status codes, contratos, datos).
- Pruebas de regresión automatizadas.
- Pruebas negativas y de manejo de errores.

Principios aplicados:
- Independencia de escenarios: cada escenario es autocontenido y no depende del estado de otros.
- Reutilización de componentes: uso de features reutilizables para generacion de datos.

Separación de responsabilidades:
- Features → definición de escenarios
- Schemas → validación de contratos
- Data → datos de prueba
- Runners → orquestación de ejecución

Tipos de pruebas cubiertas:
- Smoke
- Regression
- Negative
- Contract / Schema validation

## Patrones usados:

Data-Driven Testing  
Uso de Scenario Outline y archivos externos (.json, .csv) para ejecutar el mismo escenario con múltiples datos.  

Feature Reusable (Call)  
Uso de features reutilizables para lógica común  

Contract / Schema Validation  
Validación de contratos usando archivos JSON Schema o match estructural.  

Configuración Centralizada
Usando karate-config.js
