import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/book_card.dart';
import '../widgets/search_bar_widget.dart';
import 'detail_buku_screen.dart';

class DipinjamScreen extends StatefulWidget {
  const DipinjamScreen({super.key});

  @override
  State<DipinjamScreen> createState() => _DipinjamScreenState();
}

class _DipinjamScreenState extends State<DipinjamScreen> {
  final _searchController = TextEditingController();
  List<Book> _borrowedBooks = dummyBooks.where((b) => b.status == 'Dipinjam').toList();

  void _onSearch(String query) {
    final borrowed = dummyBooks.where((b) => b.status == 'Dipinjam').toList();
    setState(() {
      if (query.isEmpty) {
        _borrowedBooks = borrowed;
      } else {
        _borrowedBooks = borrowed
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
                    const Text('Buku yang dipinjam', style: AppTextStyles.heading),
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
            child: _borrowedBooks.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.book_outlined, size: 64, color: AppColors.grey),
                        SizedBox(height: 12),
                        Text(
                          'Tidak ada buku yang dipinjam',
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
                      itemCount: _borrowedBooks.length,
                      itemBuilder: (context, i) {
                        return BookCard(
                          book: _borrowedBooks[i],
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailBukuScreen(book: _borrowedBooks[i]),
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
