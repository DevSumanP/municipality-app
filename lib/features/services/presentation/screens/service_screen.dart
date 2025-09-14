import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:municipality_app/features/services/presentation/widgets/service/service_card.dart';
import 'package:municipality_app/shared/widgets/error_widget.dart';

import '../../../../shared/widgets/shimmer_loading.dart';
import '../providers/service_provider.dart';

class ServiceScreen extends ConsumerStatefulWidget {
  const ServiceScreen({super.key});

  @override
  ConsumerState<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends ConsumerState<ServiceScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      ref
          .read(serviceProvider.notifier)
          .updateSearchQuery(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildShimmerCategories() {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6, // Show 6 shimmer category buttons
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: index < 5 ? 12 : 20),
            child: const ShimmerBox(
              width: 100,
              height: 36,
              borderRadius: 20,
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerServiceCount() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: const Row(
        children: [
          ShimmerBox(width: 120, height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final serviceState = ref.watch(serviceProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: const Color(0xFFF8FAFC),
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header - Always show
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Municipal Services',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Access city services and information',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF64748B),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),

              // Search and Filter Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                  ),
                ),
                child: Column(
                  children: [
                    // Category Filters - Show shimmer while loading
                    serviceState.isLoading
                        ? _buildShimmerCategories()
                        : (serviceState.error?.isNotEmpty ?? false)
                            ? const SizedBox.shrink()
                            : SizedBox(
                                height: 36,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: serviceState.categories.length,
                                  itemBuilder: (context, index) {
                                    final category =
                                        serviceState.categories[index];
                                    final isSelected =
                                        serviceState.selectedCategory ==
                                            category.id;
                                    return Container(
                                      margin: EdgeInsets.only(
                                        right: index <
                                                serviceState.categories.length -
                                                    1
                                            ? 12
                                            : 20,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(serviceProvider.notifier)
                                              .updateSelectedCategory(
                                                  category.id);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? Color(int.parse(
                                                    "0xff${category.colorHex}"))
                                                : const Color(0xFFF3F4F6),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            category.name,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: isSelected
                                                  ? Colors.white
                                                  : const Color(0xFF64748B),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                  ],
                ),
              ),

              // Services List
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Service count or shimmer
                      serviceState.isLoading
                          ? _buildShimmerServiceCount()
                          : (serviceState.error?.isNotEmpty ?? false)
                              ? const SizedBox.shrink()
                              : Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    '${serviceState.filteredServices.length} service${serviceState.filteredServices.length != 1 ? 's' : ''} available',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF64748B),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),

                      // Services list or shimmer
                      Expanded(
                        child: serviceState.isLoading
                            ? ListView.builder(
                                itemCount: 8, // Show 8 shimmer service cards
                                itemBuilder: (context, index) {
                                  return const ShimmerServiceCard();
                                },
                              )
                            : (serviceState.error?.isNotEmpty ?? false)
                                ? CustomErrorWidget(
                                    errorMsg: serviceState.error!,
                                    onTap: () => ref
                                        .read(serviceProvider.notifier)
                                        .refreshData(),
                                  )
                                : serviceState.filteredServices.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.search_off,
                                              size: 64,
                                              color: Colors.grey[400],
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              'No services found',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Try adjusting your filters',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: serviceState
                                            .filteredServices.length,
                                        itemBuilder: (context, index) {
                                          return ServiceCard(
                                              service: serviceState
                                                  .filteredServices[index]);
                                        },
                                      ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
