// models/tags_model.dart
class TagsModel {
  List<String> tags;

  TagsModel({required this.tags});

  factory TagsModel.fromJson(List<dynamic> json) {
    return TagsModel(
      tags: List<String>.from(json),
    );
  }
}

class ReactionsModel {
  int likes;
  int dislikes;

  ReactionsModel({required this.likes, required this.dislikes});

  factory ReactionsModel.fromJson(Map<String, dynamic> json) {
    return ReactionsModel(
      likes: json['likes'],
      dislikes: json['dislikes'],
    );
  }
}


class PostModel {
  int id;
  String title;
  String body;
  TagsModel tagsModel;
  ReactionsModel reactions;
  int views;
  int userId;

  PostModel({
    required this.id,
    required this.title,
    required this.body,
    required this.tagsModel,
    required this.reactions,
    required this.views,
    required this.userId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      tagsModel: TagsModel.fromJson(json['tags']),
      reactions: ReactionsModel.fromJson(json['reactions']),
      views: json['views'],
      userId: json['userId'],
    );
  }

}

class PostData {
  int? limit;
  int? total;
  int? skip;
  List<PostModel>? posts;

  PostData({
    required this.limit,
    required this.skip,
    required this.total,
    required this.posts,
  });

  factory PostData.fromJson(Map<String, dynamic> json) {
    List<PostModel> mPost = [];
    for (var eachPost in json['posts']) {
      mPost.add(PostModel.fromJson(eachPost));
    }
    return PostData(
      limit: json['limit'],
      skip: json['skip'],
      total: json['total'],
      posts: mPost,
    );
  }
}



