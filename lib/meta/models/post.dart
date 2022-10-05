import 'package:try_me/meta/models/outfit.dart';
import 'package:try_me/meta/models/user.dart';

class Post {
  final Users owner;
  final String uid;
  final String name;
  final String brand;
  final String size;
  final String notes;
  final String photo;
  final List<OutfitPices> pices;
  final bool isPrivate;

  Post(
    this.owner,
    this.uid,
    this.name,
    this.brand,
    this.size,
    this.notes,
    this.photo,
    this.pices,
    this.isPrivate,
  );

  factory Post.fromJson(Map<String, dynamic> data, String uid, Users user) {
    final List<OutfitPices> oufits = [];

    for (var outfit in data["pices"]) {
      oufits.add(OutfitPices.setOutfit(outfit));
    }

    return Post(
      user,
      uid,
      data["name"],
      data["brand"],
      data["size"],
      data["notes"],
      data["photo"],
      oufits,
      data["private"],
    );
  }
}
