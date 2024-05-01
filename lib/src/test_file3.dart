// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import '../utils/helper.dart';
//
// class SearchPage extends StatefulWidget {
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage> {
//   final TextEditingController _searchController = TextEditingController();
//   List<dynamic> _searchResults = [];
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   Future<void> searchGroups(String searchTerm) async {
//     final baseUrl = 'https://api.dateifyapp.com/api/v1';
//     final endpoint = '/groups/search';
//     final queryParameters = {
//       'name': searchTerm,
//       'is_global': '0',
//     };
//
//     // final uri = Uri.parse(baseUrl + endpoint).replace(queryParameters: queryParameters);
//     var token = await Helper.Token();
//     final uri=Uri.parse('https://api.dateifyapp.com/api/v1/groups/search?name=${searchTerm}&is_global=1');
//     final response = await http.get(uri,headers: {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ${token}'
//     });
//     print('${response.body}');
//     if (response.statusCode == 200) {
//       final jsonData = json.decode(response.body);
//       setState(() {
//         _searchResults = jsonData['content']['groups']['data'];
//       });
//     } else {
//       print('Request failed with status: ${response.statusCode}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Group Search'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               onChanged: (value) {
//                 final searchTerm = value.trim();
//                 searchGroups(searchTerm);
//               },
//               decoration: InputDecoration(
//                 labelText: 'Search',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.clear),
//                   onPressed: () {
//                     _searchController.clear();
//                     setState(() {
//                       _searchResults = [];
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _searchResults.length,
//               itemBuilder: (context, index) {
//                 final group = _searchResults[index];
//                 return ListTile(
//                   title: Text(group['name']),
//                   // subtitle: Text(group['description']),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/helper.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> searchGroups(String searchTerm) async {
    setState(() {
      _isLoading = true;
    });

    final baseUrl = '{{BaseUrl}}';
    final endpoint = '/groups/search';
    final queryParameters = {
      'name': searchTerm,
      'is_global': '0',
    };

    // final uri = Uri.parse(baseUrl + endpoint).replace(queryParameters: queryParameters);
    // final response = await http.get(uri);
        var token = await Helper.Token();
    final uri=Uri.parse('https://api.dateifyapp.com/api/v1/groups/search?name=${searchTerm}&is_global=1');
    final response = await http.get(uri,headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    });

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _searchResults = jsonData['content']['groups']['data'];
        _isLoading = false;
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
      setState(() {
        _isLoading = false;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                final searchTerm = value.trim();
                searchGroups(searchTerm);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchResults = [];
                    });
                  },
                ),
              ),
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final group = _searchResults[index];
                  return ListTile(
                    title: Text(group['name']),
                    // subtitle: Text(group['description']),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
