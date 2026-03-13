# KeyMoney Demo 💰

Una versión demostrativa de la aplicación KeyMoney, diseñada para mostrar la arquitectura, UI y flujo lógico sin requerir conexiones reales a APIs externas.

## 🚀 Propósito del Proyecto

Este repositorio sirve como una **demo técnica** que utiliza datos simulados (mocks) para todas las operaciones, permitiendo explorar la interfaz de usuario y la lógica de negocio de manera aislada y rápida.

---

## 🏗️ Arquitectura

El proyecto sigue los principios de **Clean Architecture**, dividiendo el código en capas modulares para facilitar el mantenimiento y la escalabilidad:

- **`lib/core/`**: Contiene la lógica compartida, configuraciones de temas, manejo de base de datos local y utilidades genéricas.
- **`lib/features/`**: Cada funcionalidad (Autenticación, Home, Perfil, Wallet, etc.) está encapsulada en su propia carpeta, siguiendo este patrón:
  - `presentation/`: BLoCs, Widgets y páginas.
  - `domain/`: Entidades y casos de uso.
  - `data/`: Modelos y repositorios (implementaciones mock).
- **`lib/injection.dart`**: Gestiona la Inyección de Dependencias utilizando `get_it`.

---

## 🛠️ Tecnologías y Dependencias

El proyecto utiliza un stack moderno de Flutter para garantizar un rendimiento óptimo:

- **Manejo de Estado**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) para una gestión de estado predecible.
- **Inyección de Dependencias**: [get_it](https://pub.dev/packages/get_it).
- **Base de Datos Local**: [drift](https://pub.dev/packages/drift) (anteriormente Moor) para persistencia reactiva.
- **Iconos y UI**: [material_symbols_icons](https://pub.dev/packages/material_symbols_icons) y [flutter_svg](https://pub.dev/packages/flutter_svg).
- **Manejo de Dinero**: [money2](https://pub.dev/packages/money2) para formateo preciso de divisas.
- **Animaciones**: [animations](https://pub.dev/packages/animations) para transiciones fluidas.

---

## ⚙️ Configuración Local

1. **Requisitos**:
   - Flutter SDK (versión >= 3.10.7)
   - Dart SDK

2. **Instalación de dependencias**:

   ```bash
   flutter pub get
   ```

3. **Generación de archivos (Drift/Build Runner)**:
   Si se realizan cambios en la base de datos o modelos:

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Ejecución**:
   ```bash
   flutter run
   ```

---

## 📁 Estructura de Archivos Principal

```text
lib/
├── core/             # Base de datos, temas, configuraciones
├── features/         # Módulos específicos de la app
│   ├── authentication/
│   ├── home/
│   ├── profile/
│   └── ...
├── main.dart         # Punto de entrada
└── injection.dart    # Configuración de dependencias
```
