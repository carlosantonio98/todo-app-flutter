
# Todo app

La aplicación propuesta es un práctico gestor de tareas pendientes (To-Do) diseñado para simplificar el seguimiento y la administración de actividades por realizar. Este proyecto ofrece a los usuarios la posibilidad de mantener una lista siempre actualizada de tareas pendientes, permitiéndoles también marcar fácilmente aquellas que han sido completadas.

## Pre-requisitos 📋

Para la correcta ejecución de este proyecto, necesitas tener las siguientes tecnologías instaladas en tu ordenador.
* Flutter 3.7.8
* Android SDK 33.0.1
* Android Studios 2021.3

## Instalación 🔧

1. Clona este proyecto.
```bash
git clone https://github.com/carlosantonio98/todo-app-flutter.git
```

2. Abre el proyecto en un editor de código.

3. Instala las dependencias del pubspec.yaml con flutter.
```bash
flutter pub get
```

4. Crea el archivo config.dart dentro del folder lib y configura las variables de firebase correspondientes.
```
class FirebaseConfig {
    static const String apiKey = 'TU_API_KEY';
    static const String appId = 'TU_APP_ID';
    static const String messagingSenderId = 'TU_MESSAGING_SENDER_ID';
    static const String projectId = 'TU_PROJECT_ID';
    static const String storageBucket = 'TU_STORAGE_BUCKET';
}
```
5. Conecta un dispositivo o inicia un emulador.

6. Ejecuta la aplicación.
```bash
flutter run
```

## Construido con 🛠️

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- [font_awesome_flutter ^10.2.1](https://pub.dev/packages/font_awesome_flutter/versions)
- [cloud_firestore ^4.1.0](https://pub.dev/packages/cloud_firestore/versions)
- [firebase_core ^2.3.0](https://pub.dev/packages/firebase_core/versions)
- [firebase_auth ^4.2.0](https://pub.dev/packages/firebase_auth/versions)
- [provider ^6.0.5](https://pub.dev/packages/provider/versions)
- [google_sign_in ^5.4.2](https://pub.dev/packages/google_sign_in/versions)

## Estructura del Proyecto

```
todo-app-flutter/
├── android/
├── assets/
├── ios/
├── lib/
│ ├── config.dart <--- Nota: Archivo sensible no incluido en el repositorio.
│ ├── models/
│ │ ├── task.dart
│ │ └── ...
│ ├── pages/
│ │ ├── home_page.dart
│ │ └── ...
│ ├── services/
│ │ └── auth_service.dart
│ ├── widgets/
│ │ ├── task_list.dart
│ │ └── ...
| ├── firebase_options.dart <--- Aquí se encuentra el archivo de configuración de firebase
│ └── main.dart
├── test/
├── ...
└── pubspec.yaml
```

## Preview 📸

- Pagina principal

    ![App Screenshot](https://i.imgur.com/fUeJntK.jpg)

- Pagina de inicio de sesión con google

    ![App Screenshot](https://i.imgur.com/XgR0gYr.jpg)

- Pagina de tareas
    
    ![App Screenshot](https://i.imgur.com/fwRsbml.jpg)
    
- Pagina de nueva tarea

    ![App Screenshot](https://i.imgur.com/EoyWbTs.jpg)

- Pagina de tareas realizadas

    ![App Screenshot](https://i.imgur.com/lLgMBNo.jpg)

- Pagina de tareas por hacer

    ![App Screenshot](https://i.imgur.com/YtyhMBH.jpg)

- Pagina de tareas(actualizada)

    ![App Screenshot](https://i.imgur.com/reO1xs5.jpg)
    
- Eliminado una tarea

    ![App Screenshot](https://i.imgur.com/4eSJbOH.jpg)

- Finalizando una tarea

    ![App Screenshot](https://i.imgur.com/0zVqNem.jpg)

- Barra de navegación lateral

    ![App Screenshot](https://i.imgur.com/zxsXxdG.jpg)

## Autor 🖋️

- [@carlosantonio98](https://github.com/carlosantonio98)