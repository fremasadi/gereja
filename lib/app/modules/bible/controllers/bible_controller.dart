import 'package:get/get.dart';
import '../../../data/repository/bible_repository.dart';

class BibleController extends GetxController {
  final BibleRepository repository = BibleRepository();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Current Bible verse
  var currentVerse = Rx<BibleVerse?>(null);

  // History of searched verses
  var searchHistory = <String>[].obs;

  // Bookmarks
  var bookmarks = <String>[].obs;

  // Recent verses viewed
  var recentVerses = <BibleVerse>[].obs;

  // Buku-buku Alkitab untuk dropdown selection
  final List<String> oldTestamentBooks = [
    'Genesis',
    'Exodus',
    'Leviticus',
    'Numbers',
    'Deuteronomy',
    'Joshua',
    'Judges',
    'Ruth',
    '1 Samuel',
    '2 Samuel',
    '1 Kings',
    '2 Kings',
    '1 Chronicles',
    '2 Chronicles',
    'Ezra',
    'Nehemiah',
    'Esther',
    'Job',
    'Psalms',
    'Proverbs',
    'Ecclesiastes',
    'Song of Solomon',
    'Isaiah',
    'Jeremiah',
    'Lamentations',
    'Ezekiel',
    'Daniel',
    'Hosea',
    'Joel',
    'Amos',
    'Obadiah',
    'Jonah',
    'Micah',
    'Nahum',
    'Habakkuk',
    'Zephaniah',
    'Haggai',
    'Zechariah',
    'Malachi'
  ];

  final List<String> newTestamentBooks = [
    'Matthew',
    'Mark',
    'Luke',
    'John',
    'Acts',
    'Romans',
    '1 Corinthians',
    '2 Corinthians',
    'Galatians',
    'Ephesians',
    'Philippians',
    'Colossians',
    '1 Thessalonians',
    '2 Thessalonians',
    '1 Timothy',
    '2 Timothy',
    'Titus',
    'Philemon',
    'Hebrews',
    'James',
    '1 Peter',
    '2 Peter',
    '1 John',
    '2 John',
    '3 John',
    'Jude',
    'Revelation'
  ];

  // Fungsi untuk mendapatkan ayat berdasarkan referensi
  Future<void> getVerse(String reference) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final data = await repository.getVerse(reference);
      currentVerse.value = BibleVerse.fromJson(data);

      // Tambahkan ke riwayat pencarian
      if (!searchHistory.contains(reference)) {
        searchHistory.add(reference);
        if (searchHistory.length > 20) {
          // Batasi history ke 20 item
          searchHistory.removeAt(0);
        }
      }

      // Tambahkan ke daftar ayat yang baru dilihat
      if (currentVerse.value != null) {
        recentVerses.insert(0, currentVerse.value!);
        if (recentVerses.length > 10) {
          // Batasi daftar ke 10 item
          recentVerses.removeLast();
        }
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk mendapatkan seluruh buku/pasal
  Future<void> getChapter(String book, int chapter) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final data = await repository.getChapter(book, chapter);
      currentVerse.value = BibleVerse.fromJson(data);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk bookmark ayat
  void toggleBookmark(String reference) {
    if (bookmarks.contains(reference)) {
      bookmarks.remove(reference);
    } else {
      bookmarks.add(reference);
    }
  }

  bool isBookmarked(String reference) {
    return bookmarks.contains(reference);
  }

  // Fungsi untuk mendapatkan ayat berikutnya
  Future<void> getNextVerse() async {
    if (currentVerse.value != null && currentVerse.value!.verses.isNotEmpty) {
      var lastVerse = currentVerse.value!.verses.last;
      int nextVerseNumber = lastVerse.verse + 1;

      try {
        await getVerse(
            '${lastVerse.book} ${lastVerse.chapter}:$nextVerseNumber');
      } catch (e) {
        // Jika gagal, mungkin ini adalah akhir pasal
        try {
          await getVerse('${lastVerse.book} ${lastVerse.chapter + 1}:1');
        } catch (e) {
          errorMessage.value = 'Tidak dapat memuat ayat berikutnya';
        }
      }
    }
  }

  // Fungsi untuk mendapatkan ayat sebelumnya
  Future<void> getPreviousVerse() async {
    if (currentVerse.value != null && currentVerse.value!.verses.isNotEmpty) {
      var firstVerse = currentVerse.value!.verses.first;
      int prevVerseNumber = firstVerse.verse - 1;

      if (prevVerseNumber > 0) {
        try {
          await getVerse(
              '${firstVerse.book} ${firstVerse.chapter}:$prevVerseNumber');
        } catch (e) {
          errorMessage.value = 'Tidak dapat memuat ayat sebelumnya';
        }
      } else {
        // Mungkin ini adalah awal pasal, coba pasal sebelumnya
        try {
          // Ini memerlukan logika lebih lanjut untuk mengetahui jumlah ayat di pasal sebelumnya
          await getVerse('${firstVerse.book} ${firstVerse.chapter - 1}');
        } catch (e) {
          errorMessage.value = 'Tidak dapat memuat ayat sebelumnya';
        }
      }
    }
  }
}
