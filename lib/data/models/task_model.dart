class PendingTask {
  final String id;
  final String title;
  final String dueTime;
  final bool isCompleted;

  const PendingTask({
    required this.id,
    required this.title,
    required this.dueTime,
    this.isCompleted = false,
  });

  PendingTask copyWith({bool? isCompleted}) {
    return PendingTask(
      id: id,
      title: title,
      dueTime: dueTime,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}