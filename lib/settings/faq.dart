import 'package:flutter/material.dart';

class FaQ extends StatefulWidget {
  const FaQ({super.key});

  @override
  State<FaQ> createState() => _FaQState();
}

class _FaQState extends State<FaQ> {
  Widget trailingIcon1 = const Icon(Icons.add);
  Widget trailingIcon2 = const Icon(Icons.add);
  Widget trailingIcon3 = const Icon(Icons.add);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 71, 69, 69)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("FaQ",
            style: TextStyle(
                color: Color.fromARGB(255, 71, 69, 69),
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          ExpansionTile(
              childrenPadding: const EdgeInsets.only(left: 62, right: 12),
              title: const Text('What is HOLDiT?'),
              leading: const Icon(Icons.question_mark),
              trailing: trailingIcon1,
              children: const <Widget>[
                Text(
                    'HOLDit is an application that helps you to keep an accurate record of your money inflow and outflow'),
              ],
              onExpansionChanged: (bool expanded) {
                setState(() {
                  if (expanded) {
                    trailingIcon1 = const Icon(Icons.remove);
                  } else {
                    trailingIcon1 = const Icon(Icons.add);
                  }
                });
              }),
          ExpansionTile(
              childrenPadding: const EdgeInsets.only(left: 62, right: 12),
              title:
                  const Text('How HOLDiT helps me to balance my expense and income?'),
              leading: const Icon(Icons.question_mark),
              trailing: trailingIcon2,
              children: const <Widget>[
                Text(
                    'HOLDiT allows you to record your expenses and incomes as they occur. This provides an accurate record of how much money has been spent or earned and on what.\nYou can categorize your expenses and income based on the type of transaction (e.g. food, transportation, entertainment, etc.). This provides insight into spending/earning patterns and helps users identify areas where you can cut back.'),
              ],
              onExpansionChanged: (bool expanded) {
                setState(() {
                  if (expanded) {
                    trailingIcon2 = const Icon(Icons.remove);
                  } else {
                    trailingIcon2 = const Icon(Icons.add);
                  }
                });
              }),
          ExpansionTile(
              childrenPadding: const EdgeInsets.only(left: 62, right: 12),
              title: const Text('What are the subscription charges to use this app?'),
              leading: const Icon(Icons.question_mark),
              trailing: trailingIcon3,
              children: const <Widget>[
                Text(
                    'HOLDiT is completely free to use, with no hidden fees or in-app purchases and moreover No Ads at all.'),
              ],
              onExpansionChanged: (bool expanded) {
                setState(() {
                  if (expanded) {
                    trailingIcon3 = const Icon(Icons.remove);
                  } else {
                    trailingIcon3 = const Icon(Icons.add);
                  }
                });
              }),
        ],
      ),
    );
  }
}
