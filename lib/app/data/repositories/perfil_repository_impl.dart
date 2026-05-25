import 'package:miplanner_v2/app/domain/entities/perfil_entity.dart';
import 'package:miplanner_v2/app/domain/repositories/perfil_repository.dart';

// Stub — perfil has no data layer; uses TaskProvider via PerfilController.
class PerfilRepositoryImpl implements PerfilRepository {
  @override
  Future<List<PerfilEntity>> getAll() async => [];

  @override
  Future<PerfilEntity?> getById(String id) async => null;

  @override
  Future<void> save(PerfilEntity entity) async {}

  @override
  Future<void> delete(String id) async {}
}
