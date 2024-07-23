import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}



class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _allResults = [
    'NataKong: - NataKong',
    'Natanael Cano: - Natanael Cano',
    'Giza: - Giza',
    'Pyramo: - Pyramo',
    'Sharif: - Sharif',
    'Bye: - Bye',
  ];
  List<String> _filteredResults = [];

  @override
  void initState() {
    super.initState();
    _filteredResults = _allResults;
  }

  void _search(String query) {
    final results = _allResults.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();
    setState(() {
      _filteredResults = results;
    });
  }

  

  List<String> _sortResults(List<String> results, String query) {

    

    List<String> sortedResults = [];
    List<String> matchingResults = [];
    List<String> nonMatchingResults = [];

    for (String result in results) {
      if (result.toLowerCase().contains(query.toLowerCase())) {
        matchingResults.add(result);
      } else {
        nonMatchingResults.add(result);
      }
    }

    sortedResults.addAll(matchingResults);
    sortedResults.addAll(nonMatchingResults);

    return sortedResults;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar...'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (query) {
                _search(query);
              },
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredResults[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
