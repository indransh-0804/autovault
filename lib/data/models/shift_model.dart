class ShiftState {
  final bool isActive;
  final DateTime? startTime;
  final DateTime? endTime;
  final Duration elapsedDuration;
  final int salesDuringShift;

  const ShiftState({
    this.isActive = false,
    this.startTime,
    this.endTime,
    this.elapsedDuration = Duration.zero,
    this.salesDuringShift = 0,
  });

  ShiftState copyWith({
    bool? isActive,
    DateTime? startTime,
    DateTime? endTime,
    Duration? elapsedDuration,
    int? salesDuringShift,
  }) {
    return ShiftState(
      isActive: isActive ?? this.isActive,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      elapsedDuration: elapsedDuration ?? this.elapsedDuration,
      salesDuringShift: salesDuringShift ?? this.salesDuringShift,
    );
  }

  String get formattedElapsed {
    final h = elapsedDuration.inHours.toString().padLeft(2, '0');
    final m = (elapsedDuration.inMinutes % 60).toString().padLeft(2, '0');
    final s = (elapsedDuration.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  String get formattedElapsedShort {
    final h = elapsedDuration.inHours.toString().padLeft(2, '0');
    final m = (elapsedDuration.inMinutes % 60).toString().padLeft(2, '0');
    return '$h:$m';
  }

  String get lastShiftSummary {
    if (startTime == null || endTime == null) return 'No previous shift';
    String fmt(DateTime dt) =>
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    return '${fmt(startTime!)} → ${fmt(endTime!)}';
  }

  String get totalHoursWorkedToday {
    if (startTime == null || endTime == null) return '0h 0m';
    final diff = endTime!.difference(startTime!);
    return '${diff.inHours}h ${diff.inMinutes % 60}m';
  }
}

