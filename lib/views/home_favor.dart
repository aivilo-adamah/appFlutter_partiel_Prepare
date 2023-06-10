import 'package:flutter/material.dart';

import 'add_favor.dart';

class HomeFavorView extends StatefulWidget {
  const HomeFavorView({Key? key}) : super(key: key);

  @override
  State<HomeFavorView> createState() => _HomeFavorViewState();
}

class _HomeFavorViewState extends State<HomeFavorView> {
  @override
  Widget build(BuildContext context) {
    var floatingActionButton2 = FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddFavorView()));
      },
      child: Icon(Icons.edit),
    );
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("BKE FAVOR"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Demandes",
              ),
              Tab(
                text: "Acceptations",
              ),
              Tab(
                text: "Refus",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [Text("text1"), Text("text2"), Text("text3")],
        ),
        floatingActionButton: floatingActionButton2,
      ),
    );
  }
}
