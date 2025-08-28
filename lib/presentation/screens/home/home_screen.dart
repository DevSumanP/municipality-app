import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconsax/iconsax.dart';
import 'package:municipality_app/presentation/widgets/common/shimmer_effect.dart';
import 'package:video_player/video_player.dart';
import '../../../core/database/app_database.dart';
import '../../../data/models/user_model.dart';
import '../../providers/database_provider.dart';
import '../../providers/auth_provider.dart';
import 'dart:io';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentCarouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final database = ref.watch(appDatabaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${user?.name ?? 'User'}'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Section
              if (user != null) _buildUserProfile(user),

              // Notices Section
              _buildNoticesSection(database),

              const SizedBox(height: 24),

              // Scrolling News Carousel
              _buildScrollingNews(database),


              // Employees
              _buildEmployeeList(database),

              // Services
              _buildServicesSection(database),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile(User user) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // CachedNetworkImage(imageUrl: user.image ?? '', width: 100, height: 100, fit: BoxFit.cover ,placeholder: (context, url) => const CircularProgressIndicator(), errorWidget: (context, url, error) => const Icon(Icons.error),),
            Image.asset('assets/images/character.png',
                width: 100, height: 100, fit: BoxFit.cover),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(user.email),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.grey,
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(4.0),
                            side: const BorderSide(
                                color: Color.fromARGB(255, 206, 206, 206)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Icon(Iconsax.call),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.all(4.0),
                            side: const BorderSide(color: Colors.blueAccent),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child:
                              const Icon(Iconsax.message, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollingNews(AppDatabase database) {
    return FutureBuilder<List<DocumentsTable>>(
      future: database.documentsDao.getDocumentsByType('scrolling_news'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: ShimmerEffect(height: 80, width: double.infinity));
        }

        if (snapshot.hasError ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        final newsItems = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Text(
                'Latest News',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                itemCount: newsItems.length,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (context, index) {
                  final news = newsItems[index];
                  return SizedBox(
                    width:
                        MediaQuery.of(context).size.width - 16, 
                    child: Text(
                      news.title,
                      // remove overflow
                      maxLines: 3, // allow wrapping to the next line
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNoticesSection(AppDatabase database) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notices',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        FutureBuilder<List<DocumentsTable>>(
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

            final notices = snapshot.data!.take(3).toList();
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notices.length,
              itemBuilder: (context, index) {
                final notice = notices[index];
                return Card(
                  elevation: 0,
                  color: Colors.white,
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: notice.imageUrl ?? '',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => const SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(child: Icon(Icons.error)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notice.title,
                                style: Theme.of(context).textTheme.titleMedium),
                            Text(
                              notice.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildEmployeeList(AppDatabase database) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Employees',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to all documents
                },
                child: Text('View All', style: Theme.of(context).textTheme.bodyMedium),
              ),
            ],
          ),
        ),
        FutureBuilder<List<EmployeesTable>>(
          future: database.employeesDao.getAllEmployees(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError ||
                snapshot.data == null ||
                snapshot.data!.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: Text('No employees')),
              );
            }

            final employees = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return Card(
                  color: Colors.white,
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: ListTile(
                    leading: _getEmployeeImage(employee.imageUrl ?? ''),
                    title: Text(employee.name),
                    subtitle: Text(
                     employee.phone ?? '',
                     
                    ),
                    trailing: IconButton(
                      icon: const Icon(Iconsax.eye),
                      onPressed: () => {},
                    ),
                    onTap: () => {},
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _getEmployeeImage(String type) {
    return CachedNetworkImage(
      imageUrl: type,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
      placeholder: (context, url) => const SizedBox(
        width: 50,
        height: 50,
        child: Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => const SizedBox(
        width: 50,
        height: 50,
        child: Center(child: Icon(Icons.error)),
      ),
    );
  }

  
  Widget _buildServicesSection(AppDatabase database) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Services',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        FutureBuilder<List<ServicesTable>>(
          future: database.servicesDao.getActiveServices(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError ||
                snapshot.data == null ||
                snapshot.data!.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: Text('No services available')),
              );
            }

            final services = snapshot.data!.take(3).toList();
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return Card(
                  elevation: 0,
                  color: Colors.white,
                  child: Row(
                    children: [
                      VideoPlayer(
                        VideoPlayerController.networkUrl(Uri.parse(service.videoUrl ?? '')),
                      ),  
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(service.title,
                                style: Theme.of(context).textTheme.titleMedium),
                            Text(
                              service.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }


  Future<void> _handleDownload(DocumentsTable document) async {
    if (document.isDownloaded) {
      // TODO: Open the document
      return;
    }

    // TODO: Implement download logic
    // 1. Show download progress
    // 2. Download file to local storage
    // 3. Update document status in database
  }

  Future<void> _openDocument(DocumentsTable document) async {
    if (document.isDownloaded) {
      final file = File(document.imageUrl!);
      if (await file.exists()) {
        // TODO: Open the file using a file opener package
      } else {
        // File doesn't exist, update database
        final updatedDoc = document.copyWith(isDownloaded: false);
        await ref
            .read(appDatabaseProvider)
            .documentsDao
            .updateDocument(updatedDoc);
        // Show error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('File not found. Please download again.')),
          );
        }
      }
    } else {
      await _handleDownload(document);
    }
  }

  Future<void> _refreshData() async {
    // TODO: Implement data refresh logic
    // 1. Fetch latest data from server
    // 2. Update local database
    // 3. Trigger UI rebuild
  }
}
