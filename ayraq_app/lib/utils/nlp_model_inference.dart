Future<String> classifyThreat(String message) async {
  // Placeholder: Replace with actual ML/NLP inference
  if (message.toLowerCase().contains("kill") || message.toLowerCase().contains("blackmail")) {
    return 'Death Threat';
  } else if (message.toLowerCase().contains("nude") || message.toLowerCase().contains("expose")) {
    return 'Blackmail';
  } else if (message.toLowerCase().contains("idiot") || message.toLowerCase().contains("ugly")) {
    return 'Harassment';
  }
  return 'Safe';
}