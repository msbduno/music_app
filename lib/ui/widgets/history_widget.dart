import 'package:flutter/cupertino.dart';

class SearchHistoryWidget extends StatelessWidget {
  final List<String> filteredHistory;
  final TextEditingController searchController;
  final Function(String) navigateToSearchResults;
  final Function(String) deleteFromHistory;

  const SearchHistoryWidget({
    super.key,
    required this.filteredHistory,
    required this.searchController,
    required this.navigateToSearchResults,
    required this.deleteFromHistory,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredHistory.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            searchController.text = filteredHistory[index];
            navigateToSearchResults(filteredHistory[index]);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: CupertinoColors.systemGrey4,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.clock,
                  color: CupertinoColors.systemGrey,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    filteredHistory[index],
                    style: const TextStyle(
                      color: CupertinoColors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    deleteFromHistory(filteredHistory[index]);
                  },
                  child: const Icon(
                    CupertinoIcons.clear,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}