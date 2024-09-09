class StatusItem{
  String? url = "";
  String? caption = "";
  List<String>? seenUser = [];
  DateTime? time;

  StatusItem({this.url, this.seenUser, this.time,this.caption});

  factory StatusItem.fromMap(Map<String, dynamic> map) {
    return StatusItem(
      caption: map['caption'],
      url: map['url'],
      time: map['time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['time'])  // Convert int to DateTime
          : null,
      seenUser: List<String>.from(map['seenUser'] ?? []),
    );
  }
  Map<String, dynamic> toMap() => {
        'url': url,
        'seenUser': seenUser,
    "caption" : caption,
        'time': DateTime.now().millisecondsSinceEpoch,
      };
}