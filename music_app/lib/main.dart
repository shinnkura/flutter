import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:music_app/lib/spotify.dart';
import 'package:music_app/modules/songs/song.dart';
import 'package:music_app/widgets/song_card.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await setupSpotify();
  runApp(const MaterialApp(
    home: MusicApp(),
  ));
}

class MusicApp extends StatefulWidget {
  const MusicApp({
    super.key,
  });

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Song> _popularSongs = [];
  bool _isInitializing = false;
  Song? _selectedSong;
  bool _isPlay = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    final songs = await spotify.getPopularSongs();
    setState(() {
      _popularSongs = songs;
      _isInitializing = true;
    });
  }

  // 音楽を再生する処理
  void _play() {
    _audioPlayer.play(UrlSource(_selectedSong?.previewUrl ?? ''));
    setState(() {
      _isPlay = true;
    });
  }

  // 音楽を選択した場合の処理
  void _handleSongSelected(Song song) {
    setState(() {
      _selectedSong = song;
    });
    _play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0E10),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Music App',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.search,
                              color: Colors.white, size: 24),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: '探したい曲を入力してください',
                                hintStyle: TextStyle(color: Colors.white70),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Songs',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: !_isInitializing
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: LayoutGrid(
                                  columnSizes: [1.fr, 1.fr],
                                  rowSizes:
                                      List<IntrinsicContentTrackSize>.generate(
                                    (_popularSongs.length / 2).round(),
                                    (int index) => auto,
                                  ),
                                  children: _popularSongs
                                      .map((song) => SongCard(
                                            song: song,
                                            onTap: _handleSongSelected,
                                          ))
                                      .toList(),
                                ),
                              )
                            ],
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF0E0E10),
    );
  }
}
