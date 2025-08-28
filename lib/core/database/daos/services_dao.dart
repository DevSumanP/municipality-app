import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/services_table.dart';

part 'services_dao.g.dart';

@DriftAccessor(tables: [Services])
class ServicesDao extends DatabaseAccessor<AppDatabase> with _$ServicesDaoMixin {
  ServicesDao(AppDatabase db) : super(db);

  // Get all services
  Future<List<ServicesTable>> getAllServices() async {
    return await (select(services)
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)])
    ).get();
  }

  // Get service by ID
  Future<ServicesTable?> getServiceById(int id) async {
    return await (select(services)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  // Get services by department
  Future<List<ServicesTable>> getServicesByDepartment(String departmentId) async {
    return await (select(services)
      ..where((tbl) => tbl.departmentId.equals(departmentId))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)])
    ).get();
  }

  // Get services count
  Future<int> getServicesCount() async {
    final query = selectOnly(services)..addColumns([services.id.count()]);
    final result = await query.getSingle();
    return result.read(services.id.count()) ?? 0;
  }

  // Get services count by department
  Future<int> getServicesCountByDepartment(String departmentId) async {
    final query = selectOnly(services)
      ..addColumns([services.id.count()])
      ..where(services.departmentId.equals(departmentId));
    final result = await query.getSingle();
    return result.read(services.id.count()) ?? 0;
  }

  // Insert single service
  Future<int> insertService(ServicesTable service) async {
    return await into(services).insert(service, mode: InsertMode.insertOrReplace);
  }

  // Insert multiple services
  Future<void> insertAllServices(List<ServicesTable> servicesList) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(services, servicesList);
    });
  }

  // Update service
  Future<bool> updateService(ServicesTable service) async {
    return await update(services).replace(service);
  }

  // Delete service
  Future<int> deleteService(int id) async {
    return await (delete(services)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Delete services by department
  Future<int> deleteServicesByDepartment(String departmentId) async {
    return await (delete(services)..where((tbl) => tbl.departmentId.equals(departmentId))).go();
  }

  // Delete all services
  Future<int> deleteAllServices() async {
    return await delete(services).go();
  }

  // Search services
  Future<List<ServicesTable>> searchServices(String query) async {
    return await (select(services)
      ..where((tbl) => 
        tbl.title.contains(query) | 
        tbl.description.contains(query))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.title)])
    ).get();
  }

  // Get services with video
  Future<List<ServicesTable>> getServicesWithVideo() async {
    return await (select(services)
      ..where((tbl) => tbl.video.isNotNull())
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)])
    ).get();
  }

  // Get services with proposal sample
  Future<List<ServicesTable>> getServicesWithProposalSample() async {
    return await (select(services)
      ..where((tbl) => tbl.proposalSample.isNotNull())
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)])
    ).get();
  }

  // Get services with extra document
  Future<List<ServicesTable>> getServicesWithExtraDocument() async {
    return await (select(services)
      ..where((tbl) => tbl.extraDocument.isNotNull())
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)])
    ).get();
  }

  // Get updated services
  Future<List<ServicesTable>> getUpdatedServices() async {
    return await (select(services)
      ..where((tbl) => tbl.isUpdated.equals('1'))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.updatedAt, mode: OrderingMode.desc)])
    ).get();
  }

  // Get active services
  Future<List<ServicesTable>> getActiveServices() async {
    return await (select(services)
      ..where((tbl) => tbl.status.equals('1'))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)])
    ).get();
  }

  // Get services by status
  Future<List<ServicesTable>> getServicesByStatus(String status) async {
    return await (select(services)
      ..where((tbl) => tbl.status.equals(status))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.order)])
    ).get();
  }

  // Get recent services (last 30 days)
  Future<List<ServicesTable>> getRecentServices({int limit = 10}) async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30)).toIso8601String();
    
    return await (select(services)
      ..where((tbl) => tbl.createdAt.isBiggerThanValue(thirtyDaysAgo))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.desc)])
      ..limit(limit)
    ).get();
  }

  // Get popular services (by order)
  Future<List<ServicesTable>> getPopularServices({int limit = 10}) async {
    return await (select(services)
      ..where((tbl) => tbl.status.equals('1'))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.order)])
      ..limit(limit)
    ).get();
  }
}