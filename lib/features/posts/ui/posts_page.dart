import 'package:api_with_bloc/features/posts/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostsBloc postsBloc = PostsBloc();

  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts Page')),
      body: BlocConsumer<PostsBloc, PostsState>(
          bloc: postsBloc,
          listenWhen: (previous, current) => current is PostActionState,
          buildWhen: (previous, current) => current is! PostActionState,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case PostFetchingLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case PostFetchingSuccessfulState:
                final sucessState = state as PostFetchingSuccessfulState;
                return Container(
                  child: ListView.builder(
                      itemCount: sucessState.posts.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(16),
                          padding: EdgeInsets.all(16),
                          color: Colors.grey.shade200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sucessState.posts[index].title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(sucessState.posts[index].body),
                            ],
                          ),
                        );
                      }),
                );

              default:
                return SizedBox();
            }
          }),
    );
  }
}
