import 'package:flutter/material.dart';
import 'package:webmp3/models/gridMusicModel.dart';
import 'package:webmp3/service/getAlbumDataMainService.dart';
import 'package:webmp3/service/gridAlbumGridService.dart';
import 'package:webmp3/util/gridPageComponents.dart';

class MovieGridWidget extends StatelessWidget {
  final RefreshCallback onRefresh;
  const MovieGridWidget({
    Key? key,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        titleAppBar(),
        Expanded(
          child: Container(
            color: Colors.black,
            child: FutureBuilder<List<GridMusicModel>>(
              future: GridAlbumService.getAlbumListData(),
              builder: (
                context,
                AsyncSnapshot<List<GridMusicModel>> snapshot,
              ) {
                if (snapshot.hasData) {
                  return RefreshIndicator(
                    onRefresh: onRefresh,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (
                        BuildContext context,
                        int index,
                      ) {
                        GridMusicModel gridMusicModel = snapshot.data![index];
                        return getGridCard(
                          gridMusicModel,
                          context,
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
