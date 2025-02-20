library add_thumbnail;

export 'thumbnail_list_vew.dart';
export 'package:udhaar/screens/tutorial/model/media_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udhaar/screens/tutorial/widget/add_thumbnail_widget.dart';

import 'bloc/bloc.dart';
import 'model/media_info.dart';

/// A Calculator.
class Thumbnail {
  ///  Invoke `addLink` function to show add_thumbnail dialog.
  ///
  /// Callback `onLinkAdded` returns `MediaInfo` object on `save` button pressed
  ///
  /// ```dart
  /// List<MediaInfo> mediaList = [];
  ///
  /// void openAddLinkDialog() async {
  //  // Open add thumbnail dialog
  //   await Thumbnail.addLink(
  ///    context: context,
  ///    errorText: "hmm, this link looks too complicated for me... Can you try another one?",
  ///    titleText: "Add a media link here",
  ///    subTitleText: "Paste media URL to view thumbnail",
  ///    textFieldHintText: "Add link here",
  ///    /// callback that return thumbnail information in `MediaInfo` object
  ///    onLinkAdded: (mediaInfo) {
  ///    if (mediaInfo != null && mediaInfo.thumbnailUrl.isNotEmpty) {
  ///      setState(() {
  ///        mediaList.add(mediaInfo);
  ///      });
  ///     }
  ///    },
  ///  );
  /// }
  ///```
  ///
  static Future<void> addLink(
      {BuildContext context,
      ValueChanged<MediaInfo> onLinkAdded,
      String titleText = "Add a media link here",
      String subTitleText = "Paste media URL to view thumbnail",
      String textFieldHintText = "Add link here",
      String errorText =
          '"hmm, this link looks too complicated for me... Can you try another one?"'}) async {
    var media = await showDialog(
        context: context,
        child: Builder(
          builder: (context) {
            return Dialog(
                child: MultiBlocProvider(
              providers: [
                BlocProvider<ThumbnailBloc>(
                  create: (BuildContext context) => ThumbnailBloc(),
                ),
              ],
              child: AddMediaDialogContent(
                titleText: titleText,
                subTitleText: subTitleText,
                textFieldHintText: textFieldHintText,
                errorText: errorText,
              ),
            ));
          },
        ));
    if (media != null) {
      onLinkAdded(media);
    }
  }
}
