class WorkerModel {
  String image;
  String name;
  String location;
  int experience;
  double hourRate;
  double ratingCount;
  double rating;
  String status;
  String about;
  List<String> strengths;
  String category;
  String $id;
  String $createdAt;
  String $deletedAt;

  WorkerModel({
    required this.image,
    required this.name,
    required this.location,
    required this.experience,
    required this.hourRate,
    required this.ratingCount,
    required this.rating,
    required this.status,
    required this.about,
    required this.strengths,
    required this.category,
    required this.$id,
    required this.$createdAt,
    required this.$deletedAt,
  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) => WorkerModel(
        image: json["image"],
        name: json["name"],
        location: json["location"],
        experience: json["experience"],
        hourRate: json["hour_rate"]?.toDouble(),
        ratingCount: json["rating_count"]?.toDouble(),
        rating: json["rating"]?.toDouble(),
        status: json["status"],
        about: json["about"],
        strengths: List<String>.from(json["strengths"].map((x) => x)),
        category: json["category"],
        $id: json["\$id"],
        $createdAt: json["\$createdAt"],
        $deletedAt: json["\$deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "location": location,
        "experience": experience,
        "hour_rate": hourRate,
        "rating_count": ratingCount,
        "rating": rating,
        "status": status,
        "about": about,
        "strengths": List<dynamic>.from(strengths.map((x) => x)),
        "category": category,
        "\$id": $id,
        "\$createdAt": $createdAt,
        "\$deletedAt": $deletedAt,
      };
}
