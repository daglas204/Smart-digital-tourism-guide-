import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jordan_guide/services/firestore_service.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreService().getPlacesStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Center(child: Text('حدث خطأ في جلب البيانات'));
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final places = snapshot.data?.docs ?? [];

        if (places.isEmpty) {
          return const Center(child: Text('جاري تحميل الأماكن...'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: places.length,
          itemBuilder: (context, index) {
            var place = places[index].data() as Map<String, dynamic>;
            return Card(
              margin: const EdgeInsets.only(bottom: 20),
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.network(
                    place['image'] ?? 'https://images.unsplash.com/photo-1541432901042-2d8bd64b4a9b',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, size: 50),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 20),
                                const SizedBox(width: 4),
                                Text(place['rating']?.toString() ?? '4.5', style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Text(
                              place['name'] ?? '',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF8D1B3D)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(place['location'] ?? '', style: const TextStyle(color: Colors.grey)),
                            const Icon(Icons.location_on, size: 16, color: Color(0xFFC49A45)),
                          ],
                        ),
                        const Divider(height: 20),
                        Text(
                          place['desc'] ?? '',
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}