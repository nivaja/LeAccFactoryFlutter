
import 'package:flutter/material.dart';
import 'package:leacc_factory/app/modules/common/util/get_value.dart';


class FrappeSearchDelegate extends SearchDelegate {
  String docType;
  String? referenceDoctype;
  Map<String,dynamic>? filters;
  FrappeSearchDelegate({required this.docType, this.referenceDoctype,this.filters}) {}

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<DropDownItem>>(
      future: FrappeGet.dropDownValue(
          docType: docType, txt: query, referenceDoctype: referenceDoctype, filters:filters),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].value),
                subtitle: Text(snapshot.data![index].description),
                onTap: () {
                  close(context, snapshot.data![index].value);
                },
              );
            },
            itemCount: snapshot.data?.length,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
