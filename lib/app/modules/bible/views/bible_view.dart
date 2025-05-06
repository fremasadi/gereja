import 'package:flutter/material.dart';
import 'package:gereja/app/data/constants/const_color.dart';
import 'package:get/get.dart';
import '../controllers/bible_controller.dart';

class BibleView extends GetView<BibleController> {
  const BibleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bible Study'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () => _showBookmarks(context),
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => _showHistory(context),
          ),
        ],
      ),
      body: Obx(() => _buildBody()),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBody() {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.errorMessage.value.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error: ${controller.errorMessage.value}',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.errorMessage.value = '',
              child: const Text('Kembali'),
            ),
          ],
        ),
      );
    }

    if (controller.currentVerse.value == null) {
      return _buildSearchView();
    }

    return _buildVerseView();
  }

  Widget _buildSearchView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Cari Ayat Alkitab',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Masukkan Referensi (contoh: John 3:16)',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                controller.getVerse(value);
              }
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Atau Pilih dari Kitab Alkitab:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'Perjanjian Lama'),
                      Tab(text: 'Perjanjian Baru'),
                    ],
                    labelColor: Colors.blue,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildBooksList(controller.oldTestamentBooks),
                        _buildBooksList(controller.newTestamentBooks),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (controller.recentVerses.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                const Text(
                  'Terakhir Dibaca:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.recentVerses.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            controller.getVerse(
                                controller.recentVerses[index].reference);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.black,
                          ),
                          child: Text(controller.recentVerses[index].reference),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildBooksList(List<String> books) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(books[index]),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showChapterSelection(books[index]),
        );
      },
    );
  }

  void _showChapterSelection(String book) {
    // Jumlah pasal untuk setiap buku (contoh sederhana)
    int chapterCount = 20; // Default jumlah pasal

    // Atur jumlah pasal berdasarkan buku (versi sederhana)
    if (['Psalms'].contains(book)) {
      chapterCount = 150;
    } else if (['Genesis', 'Isaiah'].contains(book)) {
      chapterCount = 66;
    } else if (['Matthew', 'Acts'].contains(book)) {
      chapterCount = 28;
    }

    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Pilih Pasal $book',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: chapterCount,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.back();
                      controller.getChapter(book, index + 1);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerseView() {
    final verse = controller.currentVerse.value!;
    final bool isBookmarked = controller.isBookmarked(verse.reference);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  verse.reference,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? Colors.blue : null,
                ),
                onPressed: () {
                  controller.toggleBookmark(verse.reference);
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // Implementasi fungsi share
                  Get.snackbar(
                    'Share',
                    'Berbagi ${verse.reference}',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            ],
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Translation: ${verse.translation}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: verse.verses.length,
            itemBuilder: (context, index) {
              final detail = verse.verses[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${detail.verse}. ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                      TextSpan(
                        text: detail.text,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text('Prev'),
                onPressed: () => controller.getPreviousVerse(),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Next'),
                onPressed: () => controller.getNextVerse(),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Catatan Studi:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Tulis catatan studi Anda disini...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Simpan Catatan'),
              onPressed: () {
                Get.snackbar(
                  'Berhasil',
                  'Catatan studi disimpan',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      backgroundColor: ConstColor.white,
      currentIndex: 0,
      onTap: (index) {
        // Handle navigation
        if (index == 0) {
          // Kembali ke pencarian
          controller.currentVerse.value = null;
        } else if (index == 1) {
          // Tampilkan bookmark
          _showBookmarks(Get.context!);
        } else if (index == 2) {
          // Tampilkan pengaturan
          Get.snackbar(
            'Coming Soon',
            'Fitur pengaturan akan segera hadir',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Cari',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Bookmark',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Pengaturan',
        ),
      ],
    );
  }

  void _showBookmarks(BuildContext context) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Bookmarks',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: Obx(() {
                if (controller.bookmarks.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada bookmark'),
                  );
                }

                return ListView.builder(
                  itemCount: controller.bookmarks.length,
                  itemBuilder: (context, index) {
                    final reference = controller.bookmarks[index];
                    return ListTile(
                      title: Text(reference),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          controller.toggleBookmark(reference);
                        },
                      ),
                      onTap: () {
                        Get.back();
                        controller.getVerse(reference);
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showHistory(BuildContext context) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Riwayat Pencarian',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: Obx(() {
                if (controller.searchHistory.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada riwayat pencarian'),
                  );
                }

                return ListView.builder(
                  itemCount: controller.searchHistory.length,
                  itemBuilder: (context, index) {
                    final reference = controller.searchHistory[index];
                    return ListTile(
                      title: Text(reference),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Get.back();
                        controller.getVerse(reference);
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
