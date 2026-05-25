# MiplannerV2

Proyecto Flutter con **Arquitectura Limpia** y **GetX** como manejador de estados.

## Estructura del Proyecto

```
lib/
├── app/
│   ├── core/
│   │   ├── bindings/        # InitialBinding
│   │   ├── constants/       # AppConstants, AppColors, AppTextStyles
│   │   ├── network/         # ApiClient (GetConnect)
│   │   ├── theme/           # AppTheme
│   │   └── utils/           # Helpers generales
│   ├── data/
│   │   ├── models/          # Modelos (extienden entities)
│   │   ├── providers/       # Fuentes de datos remotas/locales
│   │   └── repositories/    # Implementaciones de repositorios
│   ├── domain/
│   │   ├── entities/        # Entidades de negocio
│   │   ├── repositories/    # Contratos (interfaces)
│   │   └── usecases/        # Casos de uso
│   ├── modules/             # Módulos (feature slices)
│   │   └── <module>/
│   │       ├── bindings/    # Inyección de dependencias
│   │       ├── controllers/ # GetxController
│   │       ├── views/       # Vistas (GetView)
│   │       └── widgets/     # Widgets locales del módulo
│   ├── routes/              # AppPages + AppRoutes
│   └── translations/        # i18n
└── main.dart
```

## Generado con cleanarch CLI — by [RamonChenoDev](https://github.com/RamonChenoDev)

```bash
# Crear proyecto
cleanarch create project <nombre>

# Crear módulo completo (domain + data + presentation)
cleanarch create module <nombre>

# Crear feature ligero (vista + controlador + binding)
cleanarch create feature <nombre>

# Crear screen dentro de un módulo
cleanarch create screen <nombre> --module <modulo>

# Crear solo un controlador
cleanarch create controller <nombre>

# Ver ayuda
cleanarch --help
```

## Comenzar

```bash
flutter pub get
flutter run
```
