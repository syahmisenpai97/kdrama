// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kdrama_app/playerpage.dart';
import 'aboutpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Running Man",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.amber.shade100,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text(
                "Running Man",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text("Kissasian"),
              decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                image: DecorationImage(
                  image: NetworkImage(
                    "https://1.bp.blogspot.com/-Rf4tLwKSq4c/WHow_DQGAJI/AAAAAAAACZ0/jAEaa5d81e8iSFz4RlnYm--VjiecfBrpACLcB/s640/rm.PNG",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              otherAccountsPictures: const [
                // CircleAvatar(
                //   backgroundColor: Colors.white,
                //   backgroundImage: NetworkImage(
                //       "https://randomuser.me/api/portraits/women/74.jpg"),
                // ),
                // CircleAvatar(
                //   backgroundColor: Colors.white,
                //   backgroundImage: NetworkImage(
                //       "https://randomuser.me/api/portraits/men/47.jpg"),
                // ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text("About"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => PopupDialog.build(context),
                );
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.rule),
            //   title: const Text("TOS"),
            //   onTap: () {},
            // ),
            // ListTile(
            //   leading: const Icon(Icons.privacy_tip),
            //   title: const Text("Privacy Policy"),
            //   onTap: () {},
            // ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.logout,
            //   ),
            //   title: const Text("Logout"),
            //   onTap: () {},
            // )
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Running Man (Game-Show)")
            .orderBy("index", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text("Error");
          if (snapshot.data == null) return Container();
          if (snapshot.data!.docs.isEmpty) {
            return const Text("No Data");
          }
          final data = snapshot.data!;
          // int dataLength = data.docs.length;
          return ListView.builder(
            itemCount: data.docs.length,
            padding: EdgeInsets.zero,
            clipBehavior: Clip.none,
            itemBuilder: (context, index) {
              Map<String, dynamic> item =
                  (data.docs[index].data() as Map<String, dynamic>);
              item["id"] = data.docs[index].id;
              int num = item["index"] ?? "";

              String ep = item["episode"] ?? "";
              String url_sw = item["url_sw"] ?? "";
              String media_sw = item["media_sw"] ?? "";
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    backgroundImage: const NetworkImage(
                      "https://i.pinimg.com/originals/6f/16/aa/6f16aa7a7394dd68e81799947ca4c6d6.jpg",
                    ),
                  ),
                  title: Text("Running Man: Episode $ep"),
                  // subtitle: Text("$url_sw"),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Player(ep: ep, url: url_sw, media: media_sw)),
                      );
                    },
                    icon: const Icon(
                      Icons.play_circle,
                      size: 24.0,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
