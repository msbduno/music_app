import 'package:flutter/cupertino.dart';
import 'package:music_app/ui/screens/links_screen.dart';

class SearchDetailsScreen extends StatelessWidget {
  final String query;

  const SearchDetailsScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    final List<String> musicList = [
      'Song 1',
      'Song 2',
      'Song 3',
      'Song 4',
      'Song 5'
    ];

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(query),
          ),
          // add space between the navigation bar and the list
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final music = musicList[index];
                return CupertinoListTile(
                  title: Text(music),
                  trailing: const Icon(
  CupertinoIcons.link_circle,
  color: CupertinoColors.systemGrey,
),
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => LinksScreen(musicName: music),
                      ),
                    );
                  },
                );
              },
              childCount: musicList.length,
            ),
          ),
        ],
      ),
    );
  }
}