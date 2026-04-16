import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/search_bar_widget.dart';

class DetailBukuScreen extends StatefulWidget {
  final Book book;
  const DetailBukuScreen({super.key, required this.book});

  @override
  State<DetailBukuScreen> createState() => _DetailBukuScreenState();
}

class _DetailBukuScreenState extends State<DetailBukuScreen> {
  final _searchController = TextEditingController();

  Color _colorFromHex(String hex) {
    final h = hex.replaceAll('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }

  void _pinjam() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Konfirmasi Peminjaman'),
        content: Text('Apakah kamu ingin meminjam "${widget.book.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.book.status == 'Tersedia'
                    ? widget.book.status
                    : null;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Buku berhasil dipinjam!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Pinjam', style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookColor = _colorFromHex(widget.book.coverColor);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Container(
            color: AppColors.primary,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back, color: AppColors.white),
                          padding: EdgeInsets.zero,
                        ),
                        const Text('Buku', style: AppTextStyles.heading),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SearchBarWidget(
                      controller: _searchController,
                      onChanged: (_) {},
                      hint: 'Cari Buku',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book preview area with background blur effect
                  Container(
                    height: 220,
                    color: Colors.grey[100],
                    child: Stack(
                      children: [
                        // Background blurred book color
                        Positioned.fill(
                          child: Container(
                            color: bookColor.withOpacity(0.15),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 160,
                            height: 200,
                            decoration: BoxDecoration(
                              color: bookColor,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: bookColor.withOpacity(0.4),
                                  blurRadius: 16,
                                  offset: const Offset(4, 6),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                // Spine effect
                                Container(
                                  width: 12,
                                  decoration: BoxDecoration(
                                    color: bookColor.withOpacity(0.6),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomLeft: Radius.circular(6),
                                    ),
                                  ),
                                ),
                                // Title on cover
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(18, 16, 10, 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.book.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          height: 1.3,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        widget.book.author,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Book details
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _DetailRow(label: 'Nama Buku', value: widget.book.title),
                        const SizedBox(height: 12),
                        _DetailRow(label: 'ID Buku', value: widget.book.id),
                        const SizedBox(height: 12),
                        _DetailRow(label: 'Deskripsi Buku', value: widget.book.description),
                        const SizedBox(height: 12),
                        _DetailRow(
                          label: 'Status',
                          value: widget.book.status,
                          valueColor: widget.book.status == 'Tersedia'
                              ? Colors.green
                              : Colors.orange,
                        ),
                        const SizedBox(height: 40),
                        // Pinjam button
                        if (widget.book.status == 'Tersedia')
                          Center(
                            child: SizedBox(
                              width: 180,
                              height: 46,
                              child: ElevatedButton(
                                onPressed: _pinjam,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'PINJAM',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (widget.book.status != 'Tersedia')
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.orange),
                              ),
                              child: const Text(
                                'Buku sedang dipinjam',
                                style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                      ],
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

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label : ',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 14,
              color: valueColor ?? AppColors.textDark,
              fontWeight: valueColor != null ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
