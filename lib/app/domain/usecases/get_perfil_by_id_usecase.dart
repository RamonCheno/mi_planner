import 'package:miplanner_v2/app/domain/entities/perfil_entity.dart';
import 'package:miplanner_v2/app/domain/repositories/perfil_repository.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  CAPA: Domain  →  UseCase (Caso de Uso)                                 │
// └─────────────────────────────────────────────────────────────────────────┘
//
// ¿Qué hace este Caso de Uso?
//   Una sola cosa: buscar un perfil por su id.
//   Lo usa la pantalla de detalle cuando el usuario toca un elemento.
//
// ¿Devuelve null?
//   Sí. Si el perfil no existe, devuelve null.
//   El Controller decide qué mostrar en ese caso.
//
// ¿Cómo se llama desde el Controller?
//   final item = await _getPerfilById(elIdQueQuieres);
class GetPerfilByIdUseCase {
  final PerfilRepository _repository;

  GetPerfilByIdUseCase(this._repository);

  Future<PerfilEntity?> call(String id) => _repository.getById(id);
}
