import 'package:flutter/material.dart';
import 'package:yadg/backend/backend.dart';
import 'package:yadg/frontend/screens/game_view.dart';
import 'package:yadg/frontend/widgets/custom_button.dart';
import 'package:yadg/frontend/widgets/player_tile.dart';
import 'package:yadg/frontend/widgets/title.dart';

class PlayerSelection extends StatefulWidget {
  const PlayerSelection({super.key});

  @override
  State<PlayerSelection> createState() => _PlayerSelectionState();
}

class _PlayerSelectionState extends State<PlayerSelection> {
  late TextEditingController _controller;
  List<String> players = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void deletePlayer(int index) {
    setState(() {
      players.removeAt(index);
    });
  }

  void addPlayer(String name) {
    setState(() {
      players.add(name);
      _controller.clear();
    });
  }

  void startGame() {
    if (players.length > 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => GameView(
              backend: Backend(players),
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomTitle(),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: players.length,
                  itemBuilder: ((context, index) => PlayerTile(
                        name: players[index],
                        onPressed: () => deletePlayer(index),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Lisää pelaaja',
                  ),
                  onSubmitted: (String str) => addPlayer(str),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CustomButton(
                  onPressed: () => startGame(),
                  text: "Aloita peli 🍻",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
