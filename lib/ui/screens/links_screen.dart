import 'package:flutter/cupertino.dart';

class LinksScreen extends StatelessWidget {
  final String musicName;

  const LinksScreen({super.key, required this.musicName});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(musicName),
          ),
          SliverFillRemaining(
            child: Center(
              child: Text(
                'Links for $musicName',
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}