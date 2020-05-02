import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestorePagination extends StatefulWidget {
  const FirestorePagination({
    @required this.query,
    @required this.itemBuilder,
    @required this.loaderBuilder,
    @required this.separatorBuilder,
    this.batchSize = 7,
  });

  final Query query;
  final int batchSize;
  final Function(BuildContext, DocumentSnapshot) itemBuilder;
  final Function(BuildContext) loaderBuilder;
  final Function(BuildContext) separatorBuilder;

  @override
  _FirestorePaginationState createState() => _FirestorePaginationState();
}

class _FirestorePaginationState extends State<FirestorePagination> {
  List<DocumentSnapshot> _documentSnapshots;
  ScrollController _scrollController;
  bool loading;

  @override
  initState() {
    super.initState();
    _documentSnapshots = List();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    loading = false;
    _update();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        if (index == _documentSnapshots.length) {
          return loading ? this.widget.loaderBuilder(context) : Container();
        } else {
          return this.widget.itemBuilder(context, _documentSnapshots[index]);
        }
      },
      separatorBuilder: (BuildContext context, int index) =>
          this.widget.separatorBuilder(context),
      itemCount: _documentSnapshots.length + 1,
      controller: _scrollController,
    );
  }

  _update() async {
    if (!loading) {
      setState(() {
        loading = true;
      });
      Query query;
      if (_documentSnapshots.isEmpty) {
        query = this.widget.query.limit(this.widget.batchSize);
      } else {
        final DocumentSnapshot last = _documentSnapshots.last;
        query = this
            .widget
            .query
            .startAfterDocument(last)
            .limit(this.widget.batchSize);
      }
      QuerySnapshot querySnapshot;
      try {
        querySnapshot = await query.getDocuments();
      } catch (anything) {
        return;
      }
      setState(() {
        if (querySnapshot.documents.isNotEmpty) {
          _documentSnapshots.addAll(querySnapshot.documents);
        }
        loading = false;
      });
    }
  }

  _scrollListener() {
    if (loading) return;
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      _update();
    }
  }
}
