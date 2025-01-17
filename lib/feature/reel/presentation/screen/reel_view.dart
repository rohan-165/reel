import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reel/core/services/service_locator.dart';
import 'package:reel/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:reel/feature/reel/data/reel_mixin.dart';
import 'package:reel/feature/reel/data/video_repo.dart';
import 'package:reel/feature/reel/presentation/reel_bloc/reel_bloc.dart';
import 'package:reels_viewer/reels_viewer.dart';

class ReelView extends StatefulWidget {
  const ReelView({super.key});

  @override
  State<ReelView> createState() => _ReelViewState();
}

class _ReelViewState extends State<ReelView> with ReelMixin {
  @override
  void initState() {
    super.initState();
    ReelModel currentItem = VideoRepository().reelsList().first;
    getIt<ReelBloc>().add(ReelRestartEvent());
    getIt<ReelBloc>().add(
      ReelStartEvent(url: currentItem.url),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReelBloc, ReelState>(
      builder: (context, reelState) {
        return ReelsViewer(
          reelsList: VideoRepository().reelsList(
            isLiked: reelState.itemModel.likeUrl?.isLike ?? false,
            likeCount: reelState.itemModel.likeUrl?.likeCount ?? 0,
            comments: reelState.itemModel.commentUrl
                ?.map(
                  (e) => ReelCommentModel(
                    comment: e.comment ?? '',
                    userProfilePic: e.userProfilePic ?? '',
                    userName: e.userName ?? 'User Name',
                    commentTime: DateTime.parse(
                      e.commentTime ?? DateTime.now().toString(),
                    ),
                  ),
                )
                .toList(),
          ),
          appbarTitle: 'Reel App',
          onShare: (url) {
            shareLink(url: url);
          },
          onLike: (url) {
            getIt<ReelBloc>().add(ReelLikeEvent());
          },
          onFollow: () {},
          onComment: (comment) {
            getIt<ReelBloc>().add(
              ReelCommentEvent(
                userProfile: getIt<ProfileCubit>().state.photoUrl ?? '',
                userName:
                    getIt<ProfileCubit>().state.displayName ?? 'User Name',
                comment: comment,
                date: DateTime.now().toString(),
              ),
            );
          },
          onClickMoreBtn: () {},
          onClickBackArrow: () {},
          onIndexChanged: (index) {
            ReelModel currentItem = VideoRepository().reelsList()[index];
            getIt<ReelBloc>().add(ReelRestartEvent());
            getIt<ReelBloc>().add(
              ReelStartEvent(url: currentItem.url),
            );
          },
          showProgressIndicator: true,
          showVerifiedTick: false,
          showAppbar: false,
        );
      },
    );
  }
}
