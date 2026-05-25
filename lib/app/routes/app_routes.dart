part of 'app_pages.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  AppRoutes — Nombres de las rutas de navegación                         │
// └─────────────────────────────────────────────────────────────────────────┘
//
// Migrado con: cleanarch init --routes
//
// Hay dos clases separadas:
//
//   _Paths  → segmentos individuales (lo que GetX usa en GetPage.name)
//   Routes  → rutas completas        (lo que usas en Get.toNamed())
//
// ¿Cómo navego?
//   Get.toNamed(Routes.tasks);
//   Get.back();

/// Segmentos de ruta — usados en GetPage.name y para construir [Routes].
abstract class _Paths {
  _Paths._();

  static const home = '/';

  // ── tasks ─────────────────────────────────────────────────────────
  static const tasks      = '/tasks';
  static const addTask    = '/add-task';
  static const listTask   = '/list-task';
  static const updateTask = '/update-task';
  // cleanarch:path:tasks

  // ── calendar ──────────────────────────────────────────────────────
  static const calendar = '/calendar';
  // cleanarch:path:calendar

  // ── perfil ────────────────────────────────────────────────────────
  static const perfil = '/perfil';
  // cleanarch:path:perfil

  // ── category ──────────────────────────────────────────────────────
  static const category = '/category';
  // cleanarch:path:category

  // ── configuration ─────────────────────────────────────────────────
  static const configuration = '/configuration';
  // cleanarch:path:configuration

  // cleanarch:path
}

/// Rutas completas — úsalas en Get.toNamed().
abstract class Routes {
  Routes._();

  static const home = _Paths.home;

  // ── tasks ─────────────────────────────────────────────────────────
  static const tasks      = _Paths.tasks;
  static const addTask    = _Paths.tasks + _Paths.addTask;
  static const listTask   = _Paths.tasks + _Paths.listTask;
  static const updateTask = _Paths.tasks + _Paths.updateTask;
  // cleanarch:route:tasks

  // ── calendar ──────────────────────────────────────────────────────
  static const calendar = _Paths.calendar;
  // cleanarch:route:calendar

  // ── perfil ────────────────────────────────────────────────────────
  static const perfil = _Paths.perfil;
  // cleanarch:route:perfil

  // ── category ──────────────────────────────────────────────────────
  static const category = _Paths.category;
  // cleanarch:route:category

  // ── configuration ─────────────────────────────────────────────────
  static const configuration = _Paths.configuration;
  // cleanarch:route:configuration

  // cleanarch:route
}
