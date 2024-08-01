class Blog {
  final String title;
  final String content;
  final String author;
  final DateTime date;
  final String? imageUrl;
  final String? videoUrl;
  bool isLiked;
  bool isReposted;
  bool isFollowed; // Add this property
  int likeCount;
  int repostCount;

  Blog({
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    this.imageUrl,
    this.videoUrl,
    this.isLiked = false,
    this.isReposted = false,
    this.isFollowed = false, // Initialize this property
    this.likeCount = 0,
    this.repostCount = 0,
  });
}
