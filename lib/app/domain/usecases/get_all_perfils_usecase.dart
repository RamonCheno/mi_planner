import 'package:miplanner_v2/app/domain/entities/perfil_entity.dart';
import 'package:miplanner_v2/app/domain/repositories/perfil_repository.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  CAPA: Domain  →  UseCase (Caso de Uso)                                 │
// └─────────────────────────────────────────────────────────────────────────┘
//
// ¿Qué es un Caso de Uso?
//   Es una ACCIÓN específica que puede hacer tu app.
//   Este caso de uso hace exactamente UNA cosa:
//   "Obtener todos los perfils".
//
// ¿Por qué no llamar al Repository directo desde el Controller?
//   Podrías hacerlo, pero si pones la lógica aquí:
//   ✅ Puedes agregar reglas de negocio sin tocar la UI ni los datos.
//   ✅ Puedes testear esta acción sola, sin levantar pantallas ni servidores.
//
// ¿Cómo se llama desde el Controller?
//   final items = await _getAllPerfils();
//
// TODO: Si necesitas filtros o paginación, agrégalos al método call().
class GetAllPerfilsUseCase {
  final PerfilRepository _repository;

  GetAllPerfilsUseCase(this._repository);

  Future<List<PerfilEntity>> call() => _repository.getAll();
}
