import 'package:miplanner_v2/app/domain/entities/calendar_entity.dart';
import 'package:miplanner_v2/app/domain/repositories/calendar_repository.dart';

// ┌─────────────────────────────────────────────────────────────────────────┐
// │  CAPA: Domain  →  UseCase (Caso de Uso)                                 │
// └─────────────────────────────────────────────────────────────────────────┘
//
// ¿Qué hace este Caso de Uso?
//   Una sola cosa: buscar un calendar por su id.
//   Lo usa la pantalla de detalle cuando el usuario toca un elemento.
//
// ¿Devuelve null?
//   Sí. Si el calendar no existe, devuelve null.
//   El Controller decide qué mostrar en ese caso.
//
// ¿Cómo se llama desde el Controller?
//   final item = await _getCalendarById(elIdQueQuieres);
class GetCalendarByIdUseCase {
  final CalendarRepository _repository;

  GetCalendarByIdUseCase(this._repository);

  Future<CalendarEntity?> call(String id) => _repository.getById(id);
}
