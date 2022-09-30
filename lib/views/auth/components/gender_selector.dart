import 'package:flutter/material.dart';
import 'package:try_me/meta/utils/constants.dart';

class GenderSelector extends StatefulWidget {
  final Function(String value) onSelect;
  const GenderSelector({
    super.key,
    required this.onSelect,
  });

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  String selected = "Weiblich";

  final genders = ["Weiblich", "Männlich", "Divers"];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: genders
          .map(
            (e) => GestureDetector(
              onTap: () {
                setState(() {
                  selected = e;
                });
                widget.onSelect.call(e);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Chip(
                  labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  label: Text(
                    e,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: selected != e ? kprimaryColor : Colors.white,
                        ),
                  ),
                  backgroundColor: selected == e ? kprimaryColor : Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          )
          .toList(),
      // children: [
      //   Chip(
      //     label: Text("Weiblich"),
      //   ),
      //   Chip(
      //     label: Text("Weiblich"),
      //   ),
      //   Chip(
      //     label: Text("Weiblich"),
      //   ),
      // ],
    );
  }
}
