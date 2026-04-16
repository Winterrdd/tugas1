import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/book_card.dart';
import '../widgets/search_bar_widget.dart';
import 'detail_buku_screen.dart';

class FavoritScreen extends StatefulWidget {
  const FavoritScreen({super.key});

  @override
  State<FavoritScreen> createState() => _FavoritScreenState();
}

class _FavoritScreenState extends State<FavoritScreen> {
  final _searchController = TextEditingController();
  List<Book> _favoriteBooks = dummyBooks.where((b) => b.isFavorite).toList();

  void _onSearch(String query) {
    final favorites = dummyBooks.where((b) => b.isFavorite).toList();
    setState(() {
      if (query.isEmpty) {
        _favoriteBooks = favorites;
      } else {
        _favoriteBooks = favorites
            .where((b) =>
                b.title.toLowerCase().contains(query.toLowerCase()) ||
                b.author.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Container(
            color: AppColors.primary,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Favorit', style: AppTextStyles.heading),
                    const SizedBox(height: 12),
                    SearchBarWidget(
                      controller: _searchController,
                      onChanged: _onSearch,
                      hint: 'Cari Buku',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: _favoriteBooks.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border, size: 64, color: AppColors.grey),
                        SizedBox(height: 12),
                        Text(
                          'Belum ada buku favorit',
                          style: TextStyle(color: AppColors.greyText),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.72,
                      ),
                      itemCount: _favoriteBooks.length,
                      itemBuilder: (context, i) {
                        return BookCard(
                          book: _favoriteBooks[i],
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailBukuScreen(book: _favoriteBooks[i]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
