import '../../../core/database/app_database.dart';
import '../../../core/database/tables/services_table.dart';
import '../../models/service_model.dart';

class ServiceLocalDataSource {
  final AppDatabase database;

  ServiceLocalDataSource({required this.database});

  Future<List<ServicesTable>> getAllServices() async {
    return await database.servicesDao.getAllServices();
  }

  Future<ServicesTable?> getServiceById(int id) async {
    return await database.servicesDao.getServiceById(id);
  }

  Future<List<ServicesTable>> getServicesByDepartment(int departmentId) async {
    return await database.servicesDao.getServicesByDepartment(departmentId);
  }

  Future<List<ServicesTable>> getUpdatedServices() async {
    return await database.servicesDao.getUpdatedServices();
  }

  Future<void> saveServices(List<Service> services) async {
    // Clear existing services
    await database.servicesDao.deleteAllServices();
    
    // Convert and insert new services
    final serviceTables = services.map((service) => ServicesTable(
      id: service.id,
      userId: service.userId,
      departmentId: service.departmentId,
      title: service.title,
      description: service.description,
      proposalSample: service.proposalSample,
      video: service.video,
      extraDocument: service.extraDocument,
      status: service.status,
      order: service.order,
      createdAt: service.createdAt,
      updatedAt: service.updatedAt,
      isUpdated: service.isUpdated,
      videoUrl: service.videoUrl,
      fileUrl: service.fileUrl,
      extraFileUrl: service.extraFileUrl,
    )).toList();

    await database.servicesDao.insertAllServices(serviceTables);
  }

  Future<void> saveService(Service service) async {
    final serviceTable = ServicesTable(
      id: service.id,
      userId: service.userId,
      departmentId: service.departmentId,
      title: service.title,
      description: service.description,
      proposalSample: service.proposalSample,
      video: service.video,
      extraDocument: service.extraDocument,
      status: service.status,
      order: service.order,
      createdAt: service.createdAt,
      updatedAt: service.updatedAt,
      isUpdated: service.isUpdated,
      videoUrl: service.videoUrl,
      fileUrl: service.fileUrl,
      extraFileUrl: service.extraFileUrl,
    );

    await database.servicesDao.insertService(serviceTable);
  }

  Future<void> updateService(ServicesTable service) async {
    await database.servicesDao.updateService(service);
  }

  Future<void> deleteService(int id) async {
    await database.servicesDao.deleteService(id);
  }

  Future<void> deleteAllServices() async {
    await database.servicesDao.deleteAllServices();
  }
}