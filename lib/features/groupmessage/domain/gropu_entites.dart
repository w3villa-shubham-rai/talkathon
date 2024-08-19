class Group {
  final String id;
  final String name;
  final List<String> participantIds;
  final String adminId;
  final DateTime createdAt;
  final String? groupImageUrl;

  Group({
    required this.id,
    required this.name,
    required this.participantIds,
    required this.adminId,
    required this.createdAt,
    this.groupImageUrl,
  });

  // Convert Group to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'participantIds': participantIds,
      'adminId': adminId,
      'createdAt': createdAt.toIso8601String(),
      'groupImageUrl': groupImageUrl,
    };
  }

  // Factory method to create a Group from a Map
  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'],
      name: map['name'],
      participantIds: List<String>.from(map['participantIds']),
      adminId: map['adminId'],
      createdAt: DateTime.parse(map['createdAt']),
      groupImageUrl: map['groupImageUrl'],
    );
  }
}
