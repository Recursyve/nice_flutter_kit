import "package:example/pages/common/base.page.dart";
import "package:flutter/material.dart";
import "package:nice_flutter_kit/nice_flutter_kit.dart";

class RadioExpandableCardsPage extends StatelessWidget {
  const RadioExpandableCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Radio expandable cards",
      child: RadioExpandableProvider(
        initialExpandedKey: const ValueKey(42),
        child: ListView.separated(
          itemCount: 50,
          itemBuilder: (_, index) {
            if (index % 5 == 0) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(32, 20, 32, 0),
                child: Text("This is title #$index"),
              );
            }

            return _buildCard(index);
          },
          separatorBuilder: (_, __) => const SizedBox(height: 20),
        ),
      ),
    );
  }

  Widget _buildCard(int index) {
    return RadioExpandableCard(
      key: ValueKey(index),
      cardMargin: const EdgeInsets.symmetric(horizontal: 32),
      // ignore: avoid_print
      onChanged: (expanded) => print("Card $index changed: $expanded"),
      cardDecoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0B000000),
            spreadRadius: 8,
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      headerDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      headerPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      headerAlignment: Alignment.center,
      header: Text("Card #$index"),
      bodyPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      body: Column(
        children: [
          const Text("This"),
          const Text("is"),
          const Text("card"),
          Text("$index"),
        ],
      ),
      separator: const Divider(height: 24, thickness: 2, endIndent: 20),
    );
  }
}
