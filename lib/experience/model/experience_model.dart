class ExperienceModel {
  String? message;
  Data? data;

  ExperienceModel({this.message, this.data});

  ExperienceModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Experiences>? experiences;

  Data({this.experiences});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['experiences'] != null) {
      experiences = <Experiences>[];
      json['experiences'].forEach((v) {
        experiences!.add(Experiences.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (experiences != null) {
      data['experiences'] = experiences!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Experiences {
  int? id;
  String? name;
  String? tagline;
  String? description;
  String? imageUrl;
  String? iconUrl;

  Experiences(
      {this.id,
      this.name,
      this.tagline,
      this.description,
      this.imageUrl,
      this.iconUrl});

  Experiences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tagline = json['tagline'];
    description = json['description'];
    imageUrl = json['image_url'];
    iconUrl = json['icon_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tagline'] = tagline;
    data['description'] = description;
    data['image_url'] = imageUrl;
    data['icon_url'] = iconUrl;
    return data;
  }
}
