import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/book_card.dart';
import '../widgets/search_bar_widget.dart';
import 'detail_buku_screen.dart';
import 'detail_pinjam_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final _searchController = TextEditingController();
  List<BorrowHistory> _history = borrowHistory;

  void _onSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _history = borrowHistory;
      } else {
        _history = borrowHistory.where((h) {
          return h.books.any((b) =>
              b.title.toLowerCase().contains(query.toLowerCase()) ||
              b.author.toLowerCase().contains(query.toLowerCase()));
        }).toList();
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
                    const Text('History pinjam', style: AppTextStyles.heading),
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
            child: _history.isEmpty
                ? const Center(
                    child: Text('Tidak ada history', style: TextStyle(color: AppColors.greyText)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _history.length,
                    itemBuilder: (context, i) {
                      final h = _history[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailPinjamScreen(history: h),
                                ),
                              ),
                              child: Text(
                                '${h.startDate} - ${h.endDate}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: h.books.length,
                                itemBuilder: (ctx, j) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: SizedBox(
                                      width: 100,
                                      child: BookCard(
                                        book: h.books[j],
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => DetailBukuScreen(book: h.books[j]),
                                          ),
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
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
