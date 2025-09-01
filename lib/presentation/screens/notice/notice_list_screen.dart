import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/database/app_database.dart';
import '../../providers/database_provider.dart';

class NoticeListScreen extends ConsumerWidget {
  const NoticeListScreen({super.key});

  Map<String, dynamic> getIconAndColor(String type) {
    switch (type) {
      case 'urgent':
        return {
          'icon': Icons.warning_amber_rounded,
          'color': Colors.red,
          'bgColor': Colors.red.shade50
        };
      case 'success':
        return {
          'icon': Icons.check_circle,
          'color': Colors.green,
          'bgColor': Colors.green.shade50
        };
      default:
        return {
          'icon': Iconsax.info_circle,
          'color': const Color(0xFF2563EB),
          'bgColor': const Color(0xFFEFF6FF)
        };
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(appDatabaseProvider);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Notices',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontSize: 18),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          actions: [
            // if (unreadCount > 0)
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 17, 0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '3 New',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        body: FutureBuilder<List<DocumentsTable>>(
          future: database.documentsDao.getDocumentsByType('notice'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError ||
                snapshot.data == null ||
                snapshot.data!.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: Text('No notices available')),
              );
            }
            final notices = snapshot.data!.toList();
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: notices.length,
              itemBuilder: (context, index) {
                final notice = notices[index];
                final iconData = getIconAndColor(notice.type);

                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: const Border(
                        left: BorderSide(width: 4, color: Color(0xFF2563EB)),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: iconData['bgColor'],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                iconData['icon'],
                                color: iconData['color'],
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notice.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        size: 12,
                                        color: Color(0xFF9CA3AF),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        notice.createdAt
                                            .toString()
                                            .substring(0, 16),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF9CA3AF),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Html(data: notice.description, style: {
                        //   "body": Style(margin: Margins.all(0),
                        //   fontSize: FontSize(14),
                        //   fontWeight: FontWeight.normal
                        //   ),
                        // }),
                        Text(
                          notice.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                            height: 1.4,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
