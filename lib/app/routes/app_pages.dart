import 'package:get/get.dart';
import 'package:miplanner_v2/app/modules/home/views/home_view.dart';
import 'package:miplanner_v2/app/modules/home/bindings/home_binding.dart';
import 'package:miplanner_v2/app/modules/tasks/views/tasks_view.dart';
import 'package:miplanner_v2/app/modules/calendar/views/calendar_view.dart';
import 'package:miplanner_v2/app/modules/calendar/bindings/calendar_binding.dart';
import 'package:miplanner_v2/app/modules/perfil/views/perfil_view.dart';
import 'package:miplanner_v2/app/modules/perfil/bindings/perfil_binding.dart';
import 'package:miplanner_v2/app/modules/category/views/category_view.dart';
import 'package:miplanner_v2/app/modules/category/bindings/category_binding.dart';
import 'package:miplanner_v2/app/features/configuracion/views/configuracion_view.dart';
import 'package:miplanner_v2/app/features/configuracion/bindings/configuracion_binding.dart';
import 'package:miplanner_v2/app/modules/tasks/screens/add_task/views/add_task_screen.dart';
import 'package:miplanner_v2/app/modules/tasks/screens/add_task/bindings/add_task_binding.dart';
import 'package:miplanner_v2/app/modules/tasks/screens/list_task/views/list_task_screen.dart';
import 'package:miplanner_v2/app/modules/tasks/screens/list_task/bindings/list_task_binding.dart';
import 'package:miplanner_v2/app/modules/tasks/screens/update_task/views/update_task_screen.dart';
import 'package:miplanner_v2/app/modules/tasks/screens/update_task/bindings/update_task_binding.dart';
// cleanarch:import

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  AppPages — Lista de todas las pantallas de la app                      │
// └─────────────────────────────────────────────────────────────────────────┘
//
// ¿Qué hace este archivo?
//   Es el "directorio de pantallas". Cada pantalla de la app está registrada
//   aquí como un GetPage. Home es la pantalla raíz; el resto son sus hijos.
//
// ¿Cómo agrego una pantalla nueva?
//   Usa el CLI — él inyecta la ruta automáticamente:
//
//     cleanarch create module <nombre>     → módulo completo (hijo de home)
//     cleanarch create feature <nombre>    → feature ligero (hijo de home)
//     cleanarch create screen <nombre> --module <mod>  → screen dentro de un módulo
//
// Estructura de rutas:
//   home (raíz)
//   └── producto     ← módulo hijo
//       └── detalle  ← screen hija del módulo
//   └── dashboard    ← feature hijo
//
// ¿Cómo navego?
//   Get.toNamed(Routes.producto);
//   Get.toNamed(Routes.detalleScreen, arguments: {'id': '1'});
//   Get.back();

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // Primera pantalla que se muestra al abrir la app
  static const initial = Routes.home;

  static final routes = <GetPage>[
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.tasks,
          page: () => const TasksView(),
          children: [
            GetPage(name: _Paths.addTask,    page: () => const AddTaskScreen(),    binding: AddTaskBinding()),
            GetPage(name: _Paths.listTask,   page: () => const ListTaskScreen(),   binding: ListTaskBinding()),
            GetPage(name: _Paths.updateTask, page: () => const UpdateTaskScreen(), binding: UpdateTaskBinding()),
            // cleanarch:inject:tasks
          ],
        ),
        GetPage(
          name: _Paths.calendar,
          page: () => const CalendarView(),
          binding: CalendarBinding(),
          children: [
            // cleanarch:inject:calendar
          ],
        ),
        GetPage(
          name: _Paths.perfil,
          page: () => const PerfilView(),
          binding: PerfilBinding(),
          children: [
            // cleanarch:inject:perfil
          ],
        ),
        GetPage(
          name: _Paths.category,
          page: () => const CategoryView(),
          binding: CategoryBinding(),
          children: [
            // cleanarch:inject:category
          ],
        ),
        GetPage(name: _Paths.configuration, page: () => const ConfiguracionView(), binding: ConfiguracionBinding()),
        // cleanarch:inject
      ],
    ),
  ];
}
