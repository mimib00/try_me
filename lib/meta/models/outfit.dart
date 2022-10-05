import 'package:flutter/foundation.dart';

enum OutfitPices {
  shirt("assets/images/shirt.svg"),
  pants("assets/images/pants.svg"),
  dress("assets/images/dress.svg"),
  jacket("assets/images/jacket.svg"),
  shoe("assets/images/shoe.svg"),
  hat("assets/images/hat.svg");

  final String icon;
  const OutfitPices(this.icon);

  factory OutfitPices.setOutfit(String name) {
    switch (name) {
      case "shirt":
        return OutfitPices.shirt;
      default:
        return OutfitPices.shirt;
    }
  }
}
