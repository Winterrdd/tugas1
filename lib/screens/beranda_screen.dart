import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/book_card.dart';
import '../widgets/search_bar_widget.dart';
import 'detail_buku_screen.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  final _searchController = TextEditingController();
  List<Book> _filteredBooks = dummyBooks;

  void _onSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredBooks = dummyBooks;
      } else {
        _filteredBooks = dummyBooks
            .where((b) =>
                b.title.toLowerCase().contains(query.toLowerCase()) ||
                b.author.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final recommended = _filteredBooks.take(3).toList();
    final baru = _filteredBooks.skip(3).take(3).toList();
    final banyakDipinjam = _filteredBooks.skip(6).take(3).toList();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // Header
          Container(
            color: AppColors.primary,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Beranda',
                      style: AppTextStyles.heading,
                    ),
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
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (recommended.isNotEmpty)
                    _BookSection(
                      title: 'Rekomendasi',
                      books: recommended,
                    ),
                  if (baru.isNotEmpty)
                    _BookSection(
                      title: 'Baru',
                      books: baru,
                    ),
                  if (banyakDipinjam.isNotEmpty)
                    _BookSection(
                      title: 'Banyak dipinjam',
                      books: banyakDipinjam,
                    ),
                  if (_filteredBooks.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40),
                        child: Text(
                          'Buku tidak ditemukan',
                          style: TextStyle(color: AppColors.greyText),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookSection extends StatelessWidget {
  final String title;
  final List<Book> books;

  const _BookSection({required this.title, required this.books});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.chevron_right, size: 18, color: AppColors.textDark),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: books.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: BookCard(
                    book: books[i],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailBukuScreen(book: books[i]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
