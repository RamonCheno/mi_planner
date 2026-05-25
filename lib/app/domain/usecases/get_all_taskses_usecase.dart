import 'package:miplanner_v2/app/domain/entities/tasks_entity.dart';
import 'package:miplanner_v2/app/domain/repositories/tasks_repository.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  CAPA: Domain  →  UseCase (Caso de Uso)                                 │
// └─────────────────────────────────────────────────────────────────────────┘
//
// ¿Qué es un Caso de Uso?
//   Es una ACCIÓN específica que puede hacer tu app.
//   Este caso de uso hace exactamente UNA cosa:
//   "Obtener todos los taskses".
//
// ¿Por qué no llamar al Repository directo desde el Controller?
//   Podrías hacerlo, pero si pones la lógica aquí:
//   ✅ Puedes agregar reglas de negocio sin tocar la UI ni los datos.
//   ✅ Puedes testear esta acción sola, sin levantar pantallas ni servidores.
//
// ¿Cómo se llama desde el Controller?
//   final items = await _getAllTaskses();
//
// TODO: Si necesitas filtros o paginación, agrégalos al método call().
class GetAllTasksUseCase {
  final TaskRepository _repository;

  GetAllTasksUseCase(this._repository);

  Future<List<TaskEntity>> call() => _repository.getAll();
}
