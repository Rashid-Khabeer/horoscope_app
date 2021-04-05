class HistoryModel {
  String date;
  int likes, hearts, dislikes;

  HistoryModel({
    this.date,
    this.dislikes,
    this.hearts,
    this.likes,
  });

  HistoryModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dislikes = json['dislikes'];
    hearts = json['hearts'];
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'hearts': hearts,
      'likes': likes,
      'dislikes': dislikes,
    };
  }
}
