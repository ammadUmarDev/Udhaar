import 'package:udhaar/screens/tutorial/model/media_info.dart';

import 'apiProvider.dart';

class Repository {
  final moviesApiProvider = ThumbnailApiProvider();
  Future<MediaInfo> fetchAllNews({String link = ''}) =>
      moviesApiProvider.fetchMediaInfo(link);
}
