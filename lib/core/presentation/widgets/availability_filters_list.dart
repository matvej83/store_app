import 'package:flutter/material.dart';
import 'package:store_app/core/domain/entity/availability_filter_entity.dart';

import 'availability_filter_item.dart';

class AvailabilityFiltersList extends StatelessWidget {
  const AvailabilityFiltersList({
    super.key,
    required this.availabilityFilters,
    required this.onTap,
    this.filterBackgroundColor,
  });

  final List<AvailabilityFilterEntity> availabilityFilters;
  final Function(AvailabilityFilterEntity) onTap;
  final Color? filterBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      key: ValueKey(availabilityFilters.length),
      spacing: 8,
      runSpacing: 8,
      children: availabilityFilters.map((filter) {
        return GestureDetector(
          onTap: () {
            onTap(filter);
          },
          child: AvailabilityFilterItem(
            filter: filter,
            backgroundColor: filterBackgroundColor,
          ),
        );
      }).toList(),
    );
  }
}
