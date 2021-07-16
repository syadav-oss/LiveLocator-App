import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
late User? _username = _auth.currentUser;

List<String> _usernames = <String>[];
List<String> _selectedusernames = <String>[];
Map<String, bool> _selectedusernamesbool = <String, bool>{};

class Search extends StatefulWidget {
  const Search({ Key? key }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}


class _SearchState extends State<Search> with SingleTickerProviderStateMixin {

 // late Map<String, dynamic> userMap;

  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  late TextEditingController _searchQuery;

  bool isSearching = false;
  String searchQuery = "Search query";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchQuery = new TextEditingController();
    // FirebaseFirestore _firestore = FirebaseFirestore.instance;
    // _firestore.collection('users').where("email", isEqualTo: _username!.email).get().then((value) {
     // setState(() {
     //   userMap = value.docs[0].data();
     // });
    //});
  }

 
  void _startSearch() {
    print("open search box");
    ModalRoute.of(context)!
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      isSearching = false;
      _isLoading = false;
    });
  }

  void _clearSearchQuery() {
    print("close search box");
    setState(() {
      _searchQuery.clear();
      updateSearchQuery("Search query");
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
    print("search query " + newQuery);
  }



  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return new InkWell(
      onTap: () => scaffoldKey.currentState!.openDrawer(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
             const Text('Search box'),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return new TextField(
        controller: _searchQuery,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Colors.white30),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 16.0),
        onChanged: (text) {
          int i = 0;
          _usernames.clear();
          FirebaseFirestore.instance
              .collection('users')
              .where('name', isEqualTo: text)
              .get()
              .then((snapshot) {
            setState(() {

              _isLoading = true;
              snapshot.docs.forEach((element) {
                //print(element['name']);
                if (element['name'] != _username!.displayName) {
                  if (!_usernames.contains(element['name'])) {
                    _usernames.insert(i, element['name']);
                    if (_selectedusernames.contains(element['name'])) {
                      _selectedusernamesbool.update(
                          element['name'], (value) => true,
                          ifAbsent: () => true);
                    } else {
                      _selectedusernamesbool.update(
                          element['name'], (value) => false,
                          ifAbsent: () => false);
                    }
                  }
                  i++;
                }
              });
              //_isLoading = false;
            });
          });
        });
  }

   //cross icon button
  List<Widget> _buildActions() {
    if (isSearching) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    //main search function search
    return <Widget>[
      new IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _deleteselected(String label) {
    setState(
      () {
        _selectedusernames.removeAt(_selectedusernames.indexOf(label));
      },
    );
  }


  Widget _buildChip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.black,
        child: Text(label[0].toUpperCase()),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      deleteIcon: Icon(
        Icons.close,
      ),
      onDeleted: () => _deleteselected(label),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: new AppBar(
        leading: isSearching ? const BackButton() : null,
        title: isSearching ? _buildSearchField() : _buildTitle(context),
        actions:_buildActions(),
      ),

      body:// _isLoading
         // ? Center(child: CircularProgressIndicator())
         // :
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          
                Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      spacing: 6.0,
                      runSpacing: 6.0,
                      children: _selectedusernames
                          .map((item) => _buildChip(item, Color(0xFFFF)))
                          .toList()
                          .cast<Widget>(),
                    ),
                  ),
                ),
                Divider(thickness: 1.0),
               // Text(_username!.displayName),
               
                Expanded(
                  child: ListView.builder(
                    itemCount: _usernames.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 53,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  child: Icon(Icons.person,
                                  size: 45,
                                  ),
                                  radius: 23,
                                  backgroundColor: Colors.blueGrey[200],
                                ),
                                
                              ],
                            ),
                          ),
                          title: Text(
                            _usernames[index],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            ),

                          ),
                      );
                     
                    },
                  ),
                ),
              ],
          ),

     /* appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height/14,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 14,
                    width: size.width ,
                child: TextField(
                  controller: _search,
                  decoration: InputDecoration(
                    hintText: "Search Username",
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    
                  ),
                ),
                ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search,size: 26)
            ),
            
        
        ],
      )*/
    );
  }
}