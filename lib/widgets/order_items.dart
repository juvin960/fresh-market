
import 'package:flutter/material.dart';

import '../features/core/app_colors.dart';

class TimelineStep extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool completed;
  final bool active;
  final String? tag;

  const TimelineStep({
    super.key,
    required this.title,
    required this.subtitle,
    this.completed = false,
    this.active = false,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    final color = completed || active ? AppColors.accent : Colors.grey;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: active ? 24 : 20,
              height: active ? 24 : 20,
              decoration: BoxDecoration(
                color: active || completed ? Colors.green : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                completed ? Icons.check : (active ? Icons.local_shipping : null),
                size: active ? 16 : 12,
                color: Colors.white,
              ),
            ),
            Container(
              width: 2,
              height: 60,
              color: Colors.green,
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: active ? 16 : 14,
                      color: active ? Colors.green : null)),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(subtitle,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500)),
                  if (tag != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tag!,
                        style: const TextStyle(
                            fontSize: 10, color: Colors.green),
                      ),
                    )
                  ]
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        )
      ],
    );
  }
}

