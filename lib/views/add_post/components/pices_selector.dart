import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:try_me/meta/models/outfit.dart';
import 'package:try_me/meta/utils/constants.dart';

class PicesSelector extends StatefulWidget {
  final Function(OutfitPices pice) onSelect;
  final Function(OutfitPices pice) onUnSelect;
  const PicesSelector({
    super.key,
    required this.onSelect,
    required this.onUnSelect,
  });

  @override
  State<PicesSelector> createState() => _PicesSelectorState();
}

class _PicesSelectorState extends State<PicesSelector> {
  final List<OutfitPices> icons = [
    OutfitPices.shirt,
    OutfitPices.pants,
    OutfitPices.dress,
    OutfitPices.jacket,
    OutfitPices.shoe,
    OutfitPices.hat,
  ];

  List selected = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Stücke:"),
        Row(
          children: icons
              .map(
                (e) => Builder(builder: (context) {
                  final bool isSelected = selected.contains(e);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        setState(() {
                          selected.remove(e);
                          widget.onUnSelect.call(e);
                        });
                      } else {
                        setState(() {
                          selected.add(e);
                          widget.onSelect.call(e);
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        e.test,
                        height: 30,
                        color: isSelected ? kprimaryColor : ksecondaryColor,
                      ),
                    ),
                  );
                }),
              )
              .toList(),
        )
      ],
    );
  }
}
