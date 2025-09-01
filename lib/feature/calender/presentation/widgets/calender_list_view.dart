import 'package:al_huda/feature/calender/presentation/widgets/event_item.dart';
import 'package:flutter/material.dart';

class EventListView extends StatelessWidget {
  const EventListView({super.key, required this.events});

  final List<Map<String, dynamic>> events;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: events.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final event = events[index];
        return EventItem(
          name: event["name"],
          date: event["gregorian"],
          remainingDays: event["remaining"],
        );
      },
    );
  }
}
