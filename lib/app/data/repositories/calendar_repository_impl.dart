import 'package:miplanner_v2/app/domain/entities/calendar_entity.dart';
import 'package:miplanner_v2/app/domain/repositories/calendar_repository.dart';

// Stub — calendar has no data layer; uses TaskProvider via CalendarController.
class CalendarRepositoryImpl implements CalendarRepository {
  @override
  Future<List<CalendarEntity>> getAll() async => [];

  @override
  Future<CalendarEntity?> getById(String id) async => null;

  @override
  Future<void> save(CalendarEntity entity) async {}

  @override
  Future<void> delete(String id) async {}
}
