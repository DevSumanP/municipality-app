import 'package:municipality_app/features/contact/domain/entities/quick_links_entity.dart';

import '../repositories/contact_repository.dart';

class GetQuickLinkUsecase {
  final ContactRepositoryInterface repository;

  GetQuickLinkUsecase({required this.repository});

  Future<List<QuickLinkEntity>> call() async {
    return await repository.getQuickLinks();
  }
}
