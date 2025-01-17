part of 'reel_bloc.dart';

sealed class ReelEvent {}

final class ReelLikeEvent extends ReelEvent {}

final class ReelStartEvent extends ReelEvent {
  final String url;

  ReelStartEvent({
    required this.url,
  });
}

final class ReelCommentEvent extends ReelEvent {
  final String comment;
  final String date;
  final String userName;
  final String userProfile;

  ReelCommentEvent({
    required this.comment,
    required this.date,
    required this.userName,
    required this.userProfile,
  });
}

final class ReelRestartEvent extends ReelEvent {}
