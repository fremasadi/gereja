import 'dart:convert';
import 'package:http/http.dart' as http;

class BibleRepository {
  final String _baseUrl = 'https://bible-api.com';

  // Mengambil ayat berdasarkan referensi (misal: "john 3:16", "genesis 1:1-10")
  Future<Map<String, dynamic>> getVerse(String reference) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$reference'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load verse: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching verse: $e');
    }
  }

  // Mengambil seluruh buku/pasal
  Future<Map<String, dynamic>> getChapter(String book, int chapter) async {
    try {
      final reference = '$book $chapter';
      final response = await http.get(Uri.parse('$_baseUrl/$reference'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load chapter: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching chapter: $e');
    }
  }

  // Fungsi pencarian sederhana (mencari dalam daftar ayat yang sudah diambil)
  List<Map<String, dynamic>> searchInVerses(
      List<Map<String, dynamic>> verses, String query) {
    query = query.toLowerCase();
    return verses
        .where(
            (verse) => verse['text'].toString().toLowerCase().contains(query))
        .toList();
  }
}

// Model untuk Ayat Alkitab
class BibleVerse {
  final String reference;
  final String text;
  final String translation;
  final List<BibleVerseDetail> verses;

  BibleVerse({
    required this.reference,
    required this.text,
    required this.translation,
    required this.verses,
  });

  factory BibleVerse.fromJson(Map<String, dynamic> json) {
    List<BibleVerseDetail> verseDetails = [];
    if (json['verses'] != null) {
      verseDetails = List<BibleVerseDetail>.from(
          json['verses'].map((v) => BibleVerseDetail.fromJson(v)));
    }

    return BibleVerse(
      reference: json['reference'] ?? '',
      text: json['text'] ?? '',
      translation: json['translation_id'] ?? 'unknown',
      verses: verseDetails,
    );
  }
}

// Model untuk Detail Ayat
class BibleVerseDetail {
  final String book;
  final int chapter;
  final int verse;
  final String text;

  BibleVerseDetail({
    required this.book,
    required this.chapter,
    required this.verse,
    required this.text,
  });

  factory BibleVerseDetail.fromJson(Map<String, dynamic> json) {
    return BibleVerseDetail(
      book: json['book_name'] ?? '',
      chapter: json['chapter'] ?? 0,
      verse: json['verse'] ?? 0,
      text: json['text'] ?? '',
    );
  }
}
