import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/enums.dart';

class StatusHelper {
  static const Map<ServiceStatus, StatusConfig> _statusConfigs = {
    ServiceStatus.online: StatusConfig(
      color: AppColors.onlineColor,
      backgroundColor: AppColors.onlineBackground,
      text: 'Online',
    ),
    ServiceStatus.inPerson: StatusConfig(
      color: AppColors.inPersonColor,
      backgroundColor: AppColors.inPersonBackground,
      text: 'In-Person',
    ),
    ServiceStatus.offline: StatusConfig(
      color: AppColors.offlineColor,
      backgroundColor: AppColors.offlineBackground,
      text: 'Offline',
    ),
  };

  static StatusConfig getStatusConfig(ServiceStatus status) {
    return _statusConfigs[status]!;
  }
}

class StatusConfig {
  final Color color;
  final Color backgroundColor;
  final String text;

  const StatusConfig({
    required this.color,
    required this.backgroundColor,
    required this.text,
  });
}
