import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0D1B6E);
  static const Color primaryDark = Color(0xFF080F3E);
  static const Color accent = Color(0xFF2196F3);
  static const Color accentCyan = Color(0xFF00BCD4);
  static const Color white = Colors.white;
  static const Color grey = Color(0xFFE0E0E0);
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color greyText = Color(0xFF9E9E9E);
  static const Color textDark = Color(0xFF212121);
  static const Color yellow = Color(0xFFFFC107);
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textDark,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.greyText,
  );
}

// Dummy book data model
class Book {
  final String id;
  final String title;
  final String author;
  final String coverColor;
  final String status;
  final String description;
  bool isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverColor,
    this.status = 'Tersedia',
    this.description = 'Deskripsi buku tidak tersedia.',
    this.isFavorite = false,
  });
}

class BorrowHistory {
  final String startDate;
  final String endDate;
  final List<Book> books;

  BorrowHistory({
    required this.startDate,
    required this.endDate,
    required this.books,
  });
}

// Dummy Data
final List<Book> dummyBooks = [
  Book(
    id: '1121',
    title: 'Sejarah Maulid Nabi',
    author: 'Habib Lutfi',
    coverColor: '#D4A017',
    status: 'Tersedia',
    description: 'Buku tentang sejarah Nabi Muhammad SAW yang mengupas sejarah maulid secara mendalam dan komprehensif.',
  ),
  Book(
    id: '1122',
    title: 'Laskar Pelangi',
    author: 'Andrea Hirata',
    coverColor: '#1565C0',
    status: 'Tersedia',
    description: 'Novel inspiratif tentang perjuangan anak-anak di Belitung untuk meraih pendidikan.',
  ),
  Book(
    id: '1123',
    title: 'Bumi Manusia',
    author: 'Pramoedya Ananta Toer',
    coverColor: '#2E7D32',
    status: 'Dipinjam',
    description: 'Karya sastra monumental yang menggambarkan kehidupan di era kolonial Belanda.',
  ),
  Book(
    id: '1124',
    title: 'Filosofi Teras',
    author: 'Henry Manampiring',
    coverColor: '#6A1B9A',
    status: 'Tersedia',
    description: 'Buku yang memperkenalkan filsafat Stoa untuk kehidupan modern yang lebih tenang.',
  ),
  Book(
    id: '1125',
    title: 'Negeri 5 Menara',
    author: 'Ahmad Fuadi',
    coverColor: '#BF360C',
    status: 'Tersedia',
    description: 'Kisah inspiratif tentang kehidupan di pesantren dan mimpi para santri.',
  ),
  Book(
    id: '1126',
    title: 'Atomic Habits',
    author: 'James Clear',
    coverColor: '#37474F',
    status: 'Tersedia',
    description: 'Panduan praktis membangun kebiasaan kecil yang menghasilkan perubahan luar biasa.',
    isFavorite: true,
  ),
  Book(
    id: '1127',
    title: 'Sang Pemimpi',
    author: 'Andrea Hirata',
    coverColor: '#00695C',
    status: 'Tersedia',
    description: 'Sekuel Laskar Pelangi tentang mimpi besar dua sahabat dari Belitung.',
    isFavorite: true,
  ),
  Book(
    id: '1128',
    title: 'Ayat-Ayat Cinta',
    author: 'Habiburrahman',
    coverColor: '#880E4F',
    status: 'Dipinjam',
    description: 'Novel romantis islami tentang kehidupan mahasiswa Indonesia di Mesir.',
  ),
  Book(
    id: '1129',
    title: 'Surat Kecil Untuk Tuhan',
    author: 'Agnes Davonar',
    coverColor: '#E65100',
    status: 'Tersedia',
    description: 'Kisah nyata perjuangan hidup gadis remaja melawan penyakit kanker.',
  ),
];

final List<BorrowHistory> borrowHistory = [
  BorrowHistory(
    startDate: 'Selasa, 3 Februari 2024',
    endDate: 'Kamis, 5 Februari 2024',
    books: [dummyBooks[0]],
  ),
  BorrowHistory(
    startDate: 'Jumat, 12 Januari 2024',
    endDate: 'Senin, 15 Januari 2024',
    books: [dummyBooks[1]],
  ),
  BorrowHistory(
    startDate: 'Senin, 8 Januari 2024',
    endDate: 'Selasa, 9 Januari 2024',
    books: [dummyBooks[3], dummyBooks[4]],
  ),
];
