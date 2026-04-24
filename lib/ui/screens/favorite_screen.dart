import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_cosmos_messenger/logic/cubit/favorite_cubit.dart';
import 'package:nasa_cosmos_messenger/logic/cubit/favorite_state.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('收藏')),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_border, size: 64, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(height: 16),
                  const Text('目前還沒有收藏任何太空圖喔！', style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final apod = state.favorites[index];

              return _buildFavoriteGridItem(context, apod);
            },
          );
        },
      ),
    );
  }

  Widget _buildFavoriteGridItem(BuildContext context, dynamic apod) {
    final displayDate = apod.date.replaceAll('-', '/');

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: (apod.mediaType == 'video' && apod.thumbnailUrl != null)
                        ? Image.network(apod.thumbnailUrl!, fit: BoxFit.cover)
                        : (apod.mediaType == 'image')
                        ? Image.network(apod.url, fit: BoxFit.cover)
                        : const Icon(Icons.video_library, size: 48),
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.star, color: Colors.amber),
                    onPressed: () {
                      _showDeleteConfirmDialog(context, apod);
                    },
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayDate,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  apod.title,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmDialog(BuildContext context, dynamic apod) {
    final displayDate = apod.date.replaceAll('-', '/');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('取消收藏'),
          content: Text('確定要將「$displayDate 的天文圖」移出收藏庫嗎？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                context.read<FavoriteCubit>().removeFavorite(apod.date);
                Navigator.pop(context);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('已將圖片移出收藏庫'), duration: Duration(seconds: 2)));
              },
              child: const Text('確定', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
