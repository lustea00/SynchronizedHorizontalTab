import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:synchronized_horizontal_tab/synchronized_tab.dart';

class SynchronizedHorizontalTab extends StatefulWidget {
  @required
  final List<Widget> page;
  @required
  final List<Widget> tab;
  SynchronizedHorizontalTab({Key key, this.page, this.tab}) : super(key: key);

  @override
  _SynchronizedHorizontalTabState createState() =>
      _SynchronizedHorizontalTabState();
}

class _SynchronizedHorizontalTabState extends State<SynchronizedHorizontalTab>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;

  List<GlobalKey> key = []; // untuk menyimpan key halaman
  List<Widget> page = []; // variable biasa untuk generate halaman
  List<TabSynchronized> tab = []; // variable untuk menyimpan widget tab button
  List<double> offsetList =
      []; // variable untuk mneytimpan ofset halaman (0 = 0, 1 = a.height + b.height, 2 = 1 + c.height)
  List<GlobalKey<TabSynchronizedState>> _myKey =
      []; // untuk menyimpan key tab button

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController = ScrollController();

    // tambahkan halaman ke dalam container yang sudah dipasangi key
    widget.page.forEach((element) {
      // key yang ditambahkan digunakan untuk mendapatkan tinggi tiap widgetnya
      GlobalKey tempKey = new GlobalKey();
      key.add(tempKey);
      page.add(
        Container(
          key: tempKey,
          child: element,
        ),
      );
    });

    // tunggu widget selesai dibuild baru jalanain fungsi ini
    WidgetsBinding.instance.addPostFrameCallback((_) {
      offsetList.add(
          0); //index pertama scroll offsetnya selalau 0, karena diatas sendiri
      double tempOffset = 0;
      key.forEach((element) {
        tempOffset += element.currentContext.size
            .height; // nilai awalnya 0, lalu seiring widget dibuild maka nilainya selalu bertambah
        offsetList.add(tempOffset);
      });

      // untuk menambahkan tab
      widget.tab.forEach((element) {
        int currentIndex = widget.tab.indexOf(element);
        _myKey.add(
            new GlobalKey()); // tambahakn key untuk mangil fungsi buat ngeset tab mana yang aktive
        tab.add(
          TabSynchronized(
            scrollController: _scrollController,
            listOffset: offsetList,
            child: element,
            currentIndex: currentIndex,
            key: _myKey[currentIndex],
            isActivated: currentIndex == 0 ? true : false, // index pertama nilai defaultnya aktif
          ),
        );
      });

      setState(() {});
    });
    
    // untuk dapetin event scrollnya
    _scrollController.addListener(() {
      double currentScroll = _scrollController.offset + 2;
      double newOfseet = 0;
      offsetList.forEach((element) {
        if (offsetList.last != element) {
          int currentIndex = offsetList.indexOf(element);
          double nextOffset = offsetList[currentIndex + 1];
          if (currentScroll > element && currentScroll < nextOffset) { // cek ofsetnya dari variabel offsetList
            // looping setiap key dari tab untuk ngeset aktif adn not aktifnya
            _myKey.forEach((element2) {
              element2.currentState.deactivate();
            });
            _myKey[currentIndex].currentState.activate();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tab,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: page,
            ),
          ),
        ),
      ],
    );
  }
}
