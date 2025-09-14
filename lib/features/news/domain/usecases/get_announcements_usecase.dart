import '../entities/announcement_entity.dart';
import '../repositories/news_repository.dart';

class GetAnnouncementsUseCase {
  final NewsRepository repository;

  GetAnnouncementsUseCase(this.repository);

  Future<List<AnnouncementEntity>> call() async {
    return await repository.getAnnouncements();
  }
}