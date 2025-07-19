class Threat {
  final String content;
  final String category; // e.g., 'Harassment', 'Blackmail'
  final DateTime timestamp;

  Threat({required this.content, required this.category, required this.timestamp});
}
