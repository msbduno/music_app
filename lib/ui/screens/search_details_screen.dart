
import 'package:flutter/cupertino.dart';
import 'package:music_app/ui/screens/links_screen.dart';
import '../../models/discogs_result.dart';
import '../../repositories/discogs_repository.dart';

class SearchDetailsScreen extends StatefulWidget {
  final DiscogsReleases artist;

  const SearchDetailsScreen({super.key, required this.artist});

  @override
  _SearchDetailsScreenState createState() => _SearchDetailsScreenState();
}

class _SearchDetailsScreenState extends State<SearchDetailsScreen> {
  final DiscogsRepository _repository = DiscogsRepository();
  List _musicList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchReleases();
  }

  Future<void> _fetchReleases() async {
    try {
      final releases = await _repository.fetchArtistReleases(widget.artist.id);
      setState(() {
        _musicList = releases;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle the error, maybe show a message to the user
      print('Error loading releases: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            backgroundColor: CupertinoColors.activeBlue,
            largeTitle: Padding(
              padding: EdgeInsets.only(top: 20), // Extra space at the top
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.artist.title,
                      style: CupertinoTheme.of(context).textTheme.navTitleTextStyle.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (_isLoading)
            const SliverToBoxAdapter(
              child: Center(child: CupertinoActivityIndicator()),
            )
          else if (_musicList.isEmpty)
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'No releases found',
                  style: CupertinoTheme.of(context).textTheme.textStyle,
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final music = _musicList[index];
                  return CupertinoListTile(
                    title: Text(music.title),
                    trailing: const Icon(
                      CupertinoIcons.link_circle,
                      color: CupertinoColors.systemGrey,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => LinksScreen(musicName: music.title),
                        ),
                      );
                    },
                  );
                },
                childCount: _musicList.length,
              ),
            ),
        ],
      ),
    );
  }
}