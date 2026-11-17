import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('استكشف الأردن'),
        leading: const BackButton(),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Fetches real-time data from the "places" collection in Firestore
        stream: FirebaseFirestore.instance.collection('places').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('حدث خطأ في تحميل البيانات من قاعدة البيانات'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد أماكن سياحية مضافة حالياً.\n(تأكد من وجود مجموعة "places" في Firestore)',
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final data = doc.data() as Map<String, dynamic>;
              final String docId = doc.id; // Get the Document ID

              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // Adding a subtle side border for a premium look
                    border: const Border(
                      right: BorderSide(
                        color: Color(0xFFC49A45), // Golden Sand
                        width: 5,
                      ),
                    ),
                  ),
                  child: Theme(
                    // Removes the default ExpansionTile dividers for a cleaner look
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Text(
                        docId, // Set Document ID as Title
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8D1B3D),
                        ),
                      ),
                      leading: const Icon(Icons.folder_open, color: Color(0xFFC49A45)),
                      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      children: data.entries.map((entry) {
                        // Dynamically list all fields in the document
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${entry.key}: ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, color: Color(0xFF8D1B3D)),
                              ),
                              Expanded(child: Text(entry.value.toString())),
                            ],
                          ),
                        );
                      }).toList(),
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