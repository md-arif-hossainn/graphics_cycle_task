import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/meme_provider.dart';
import '../widgets/meme_list_tile.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MemeListScreen extends ConsumerStatefulWidget {
  const MemeListScreen({super.key});

  @override
  ConsumerState<MemeListScreen> createState() => _MemeListScreenState();
}

class _MemeListScreenState extends ConsumerState<MemeListScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final memeAsyncValue = ref.watch(memeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Popular Memes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kBottomNavigationBarHeight),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: TextField(
                focusNode: _searchTextFocusNode,
                controller: _searchTextController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  hintText: "What's in your mind",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _searchTextController.clear();
                      _searchTextFocusNode.unfocus();
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                    icon: Icon(
                      Icons.close,
                      color: _searchTextFocusNode.hasFocus ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: memeAsyncValue.when(
        data: (memes) {
          final filteredMemes = memes
              .where((meme) =>
              meme.name.toLowerCase().contains(_searchQuery.toLowerCase()))
              .toList();

          return MasonryGridView.builder(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two columns
            ),
            itemCount: filteredMemes.length,
            itemBuilder: (context, index) {
              final meme = filteredMemes[index];
              final double height = (index % 2 == 0) ? 200 : 300;
              return Container(
                height: height,
                margin: const EdgeInsets.only(bottom: 10),
                child: MemeGridTile(meme: meme),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
