import 'package:equatable/equatable.dart';
import 'package:udhaar/screens/tutorial/model/media_info.dart';

abstract class ThumbnailState extends Equatable {
  const ThumbnailState();

  @override
  List<Object> get props => [];
}

class LoadingMedia extends ThumbnailState {}

class DialogOpened extends ThumbnailState {}

class UrlChanged extends ThumbnailState {}

class FailureDetail extends ThumbnailState {}

class LoadedMedia extends ThumbnailState {
  final MediaInfo mediaInfo;

  LoadedMedia({this.mediaInfo});

  @override
  List<Object> get props => [mediaInfo];

  @override
  String toString() => 'LoadedMedia { items: ${mediaInfo.title} }';
}
