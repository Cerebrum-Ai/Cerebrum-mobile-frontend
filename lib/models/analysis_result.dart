class DiagnosisCase {
  final String name;
  final int matchPercentage;

  DiagnosisCase({
    required this.name,
    required this.matchPercentage,
  });
}

class AnalysisResult {
  final String type;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  AnalysisResult({
    required this.type,
    required this.data,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class AnalysisSession {
  final String id;
  final List<AnalysisResult> results;
  final DateTime startTime;

  AnalysisSession({
    String? id,
    List<AnalysisResult>? results,
    DateTime? startTime,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        results = results ?? [],
        startTime = startTime ?? DateTime.now();

  void addResult(AnalysisResult result) {
    results.add(result);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startTime': startTime.toIso8601String(),
      'results': results.map((result) => {
        'type': result.type,
        'data': result.data,
        'timestamp': result.timestamp.toIso8601String(),
      }).toList(),
    };
  }
} 