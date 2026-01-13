# SAP ABAP Cloud & Integration Portfolio

### Perfil Profesional
* **Contador Público** con enfoque en transformación digital.
* Estudiante de  **Integration Suite**.
* Estudiante de **ABAP Cloud (RAP)** y **SAP BTP**.

### Proyectos y Prácticas
* **Fundamentos ABAP:** Clases y métodos con lógica de control interno.
* **CDS Views:** Modelado de datos financieros.
* **Scripts:** Automatizaciones en Groovy para integración.
* 
Proyecto: Gestión de Hoteles en ABAP Cloud
Objetivo: Crear un modelo de datos virtual (VDM) para reportes financieros de hoteles.

Desafío Técnico: Se resolvió la incompatibilidad de tipos FLTP (punto flotante) en cálculos de moneda mediante el uso de Casting Anidado (DEC a CURR).

Modelado: Implementación de asociaciones y joins con tablas estándar como I_CurrencyText para descripciones dinámicas.

FRAMEWORK PARA CALCULAR BONO
Este proyecto implementa un framework escalable para el cálculo de bonificaciones, siguiendo los principios de Clean ABAP y Programación Orientada a Objetos (OO).

Arquitectura de Clases Globales: Uso de una clase base abstracta (ZCL_VENDEDORBASE) para definir contratos de negocio, asegurando que cualquier nuevo tipo de vendedor siga la misma estructura.

Polimorfismo: Implementación de lógica especializada en subclases (ZCL_VENDEDOR_SENIOR y ZCL_VENDEDOR_JUNIOR), permitiendo que el sistema procese diferentes reglas de cálculo de forma dinámica.

Separación de Responsabilidades (SoC): La lógica de cálculo está desacoplada de la lógica de presentación, facilitando el mantenimiento y la futura integración con APIs o Fiori.

Diccionario de Datos (DDIC): Uso de estructuras globales (ZST_REPORTE_BONOS) para garantizar la integridad y consistencia de los datos en todo el ciclo de vida del proceso.

Control de Versiones: Proyecto gestionado íntegramente con abapGit y Eclipse ADT, alineado con las metodologías modernas de desarrollo en SAP BTP / ABAP Cloud.

