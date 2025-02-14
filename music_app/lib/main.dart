import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:music_app/lib/spotify.dart';
import 'package:music_app/modules/songs/song.dart';
import 'package:music_app/widgets/player.dart';
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
  String _keyword = '';
  List<Song> _searchedSongs = []; // 検索結果の一覧が入る

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

  // 音楽を停止する処理
  void _stop() {
    _audioPlayer.stop();
    setState(() {
      _isPlay = false;
    });
  }

  // 音楽を選択した場合の処理
  void _handleSongSelected(Song song) {
    if (song.previewUrl == null) {
      _stop();
      return;
    }
    setState(() {
      _selectedSong = song;
    });
    _play();
  }

  void _handleTextFieldChanged(String value) {
    setState(() {
      _keyword = value;
    });
  }

  void _searchSongs() async {
    final songs = await spotify.searchSongs(_keyword);
    setState(() {
      _searchedSongs = songs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final songs = _searchedSongs.isEmpty ? _popularSongs : _searchedSongs;
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
                              onChanged: _handleTextFieldChanged,
                              onEditingComplete: () => _searchSongs(),
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
                                  rowSizes: [
                                    100.px,
                                    1.fr,
                                  ],
                                  children: songs
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
              if (_selectedSong != null)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IntrinsicHeight(
                    child: Player(
                      song: _selectedSong!,
                      isPlay: _isPlay,
                      onButtonTap: () => _isPlay ? _stop() : _play(),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF0E0E10),
    );
  }
}
