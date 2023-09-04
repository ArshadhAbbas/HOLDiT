import 'package:flutter/material.dart';
import 'package:holdit/providers/faq_provider.dart';
import 'package:provider/provider.dart';

class FaQ extends StatelessWidget {
  const FaQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 71, 69, 69)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'FAQ',
          style: TextStyle(
              color: Color.fromARGB(255, 71, 69, 69),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<FAQProvider>(
          builder: (context, faqProvider, child) => Container(
            padding: const EdgeInsets.all(16),
            child: ExpansionPanelList(
              expansionCallback: (int index, bool isOpen) {
                faqProvider.toggleExpansionPanelList(index, isOpen);
              },
              children: [
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isOpen) {
                    return const ListTile(
                      leading: Icon(Icons.help),
                      title: Text('What is HOLDiT?'),
                    );
                  },
                  body: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'HOLDit is an application that helps you to keep an accurate record of your money inflow and outflow',
                    ),
                  ),
                  isExpanded: faqProvider.isOpenList[0],
                ),
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isOpen) {
                    return const ListTile(
                      leading: Icon(Icons.help),
                      title: Text(
                          'How HOLDiT helps me to balance my expense and income?'),
                    );
                  },
                  body: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'HOLDiT allows you to record your expenses and incomes as they occur. This provides an accurate record of how much money has been spent or earned and on what.\nYou can categorize your expenses and income based on the type of transaction (e.g. food, transportation, entertainment, etc.). This provides insight into spending/earning patterns and helps users identify areas where you can cut back.',
                    ),
                  ),
                  isExpanded: faqProvider.isOpenList[1],
                ),
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isOpen) {
                    return const ListTile(
                      leading: Icon(Icons.help),
                      title: Text(
                          'What are the subscription charges to use this app?'),
                    );
                  },
                  body: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'HOLDiT is completely free to use, with no hidden fees or in-app purchases and moreover No Ads at all.',
                    ),
                  ),
                  isExpanded: faqProvider.isOpenList[2],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
