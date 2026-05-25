import 'package:miplanner_v2/app/domain/entities/category_entity.dart';
import 'package:miplanner_v2/app/domain/repositories/category_repository.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  CAPA: Domain  →  UseCase (Caso de Uso)                                 │
// └─────────────────────────────────────────────────────────────────────────┘
//
// ¿Qué hace este Caso de Uso?
//   Una sola cosa: buscar un category por su id.
//   Lo usa la pantalla de detalle cuando el usuario toca un elemento.
//
// ¿Devuelve null?
//   Sí. Si el category no existe, devuelve null.
//   El Controller decide qué mostrar en ese caso.
//
// ¿Cómo se llama desde el Controller?
//   final item = await _getCategoryById(elIdQueQuieres);
class GetCategoryByIdUseCase {
  final CategoryRepository _repository;

  GetCategoryByIdUseCase(this._repository);

  Future<CategoryEntity?> call(int id) => _repository.getById(id);
}
