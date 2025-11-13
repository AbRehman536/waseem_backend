class TaskModel {
  final String? docId;
  final String? title;
  final String? description;
  final String? image;
  final List<dynamic>? favorite;
  final String? priorityID;
  final bool? isCompleted;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.title,
    this.description,
    this.image,
    this.favorite,
    this.priorityID,
    this.isCompleted,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      docId: json["docID"],
      title: json["title"],
      description: json["description"],
      image: json["image"],
      favorite: json["favorite"] == null ? [] : List<dynamic>.from(json["favorite"]!.map((x) => x)),
      priorityID: json["priorityID"],
      isCompleted: json["isCompleted"],
      createdAt: json["createdAt"],
    );
  }

  Map<String, dynamic> toJson(String taskID) {
    return {
      "docID": taskID,
      "title": title,
      "description": description,
      "image": image,
      "favorite": favorite == null ? [] : List<dynamic>.from(favorite!.map((x) => x)),
      "priorityID": priorityID,
      "isCompleted": isCompleted,
      "createdAt": createdAt,
    };
  }
}
