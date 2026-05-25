import 'package:miplanner_v2/app/domain/entities/tasks_entity.dart';
import 'package:miplanner_v2/app/domain/repositories/tasks_repository.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  CAPA: Domain  →  UseCase (Caso de Uso)                                 │
// └─────────────────────────────────────────────────────────────────────────┘
//
// ¿Qué hace este Caso de Uso?
//   Una sola cosa: buscar un tasks por su id.
//   Lo usa la pantalla de detalle cuando el usuario toca un elemento.
//
// ¿Devuelve null?
//   Sí. Si el tasks no existe, devuelve null.
//   El Controller decide qué mostrar en ese caso.
//
// ¿Cómo se llama desde el Controller?
//   final item = await _getTasksById(elIdQueQuieres);
class GetTaskByIdUseCase {
  final TaskRepository _repository;

  GetTaskByIdUseCase(this._repository);

  Future<TaskEntity?> call(int id) => _repository.getById(id);
}
