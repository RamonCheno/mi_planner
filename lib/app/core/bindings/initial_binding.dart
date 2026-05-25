import 'package:get/get.dart';
import 'package:miplanner_v2/app/core/services/database_service.dart';
import 'package:miplanner_v2/app/core/services/permission_service.dart';
// cleanarch:import

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  InitialBinding — Servicios globales de la app                          │
// └─────────────────────────────────────────────────────────────────────────┘
//
// ¿Qué hace este archivo?
//   Es el primer Binding que ejecuta GetX, incluso antes de mostrar
//   cualquier pantalla. Aquí registras los objetos que TODA la app necesita.
//
// ¿Qué va aquí?
//   ✅ ApiClient          → para hacer llamadas HTTP desde cualquier Provider
//   ✅ DatabaseService    → base de datos local global
//   ✅ SettingsService    → configuración persistente global
//
// ¿Qué NO va aquí?
//   ❌ Controllers de pantallas específicas (esos van en el Binding de cada módulo)
//
// ¿Qué significa permanent: true?
//   Le dice a GetX: "No destruyas este objeto aunque cambie la pantalla".
//   Los servicios globales siempre deben ser permanent: true.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DatabaseService>(DatabaseService(), permanent: true);
    Get.put<PermissionsService>(PermissionsService(), permanent: true);
    // cleanarch:service
  }
}
