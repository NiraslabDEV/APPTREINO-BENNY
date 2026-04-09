import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../bloc/dashboard_bloc.dart';
import '../../../../../core/theme/app_theme.dart';

class ActivityFeedTile extends StatelessWidget {
  final RecentActivity activity;
  const ActivityFeedTile({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: KineticColors.surfaceContainerHigh,
        backgroundImage: activity.studentPhotoUrl != null
            ? CachedNetworkImageProvider(activity.studentPhotoUrl!)
            : null,
        child: activity.studentPhotoUrl == null
            ? Text(
                activity.studentName[0].toUpperCase(),
                style: const TextStyle(
                    color: KineticColors.primaryContainer,
                    fontWeight: FontWeight.bold),
              )
            : null,
      ),
      title: Text(
        activity.studentName,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        activity.workoutName,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${activity.totalVolumeKg.toStringAsFixed(0)} kg',
            style: const TextStyle(
              color: KineticColors.primaryContainer,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          Text(
            timeago.format(DateTime.parse(activity.completedAt),
                locale: 'pt_BR'),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
