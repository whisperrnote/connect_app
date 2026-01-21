import 'package:appwrite/appwrite.dart';
import '../constants/appwrite_constants.dart';
import 'appwrite_service.dart';
import '../models/moment_model.dart';
import '../models/follow_model.dart';

class SocialService {
  final Databases _databases = AppwriteService().databases;

  // Moments
  Future<List<Moment>> listMoments() async {
    try {
      final response = await _databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.momentsCollectionId,
        queries: [Query.orderDesc('\$createdAt')],
      );
      return response.documents
          .map((doc) => Moment.fromJson(doc.data))
          .toList();
    } catch (e) {
      throw Exception('Failed to list moments: $e');
    }
  }

  Future<Moment> createMoment({
    required String userId,
    required String content,
    List<String>? images,
    String? video,
  }) async {
    try {
      final doc = await _databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.momentsCollectionId,
        documentId: ID.unique(),
        data: {
          'userId': userId,
          'content': content,
          'images': images,
          'video': video,
        },
      );
      return Moment.fromJson(doc.data);
    } catch (e) {
      throw Exception('Failed to create moment: $e');
    }
  }

  // Follows
  Future<List<Follow>> listFollowing(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.followsCollectionId,
        queries: [Query.equal('followerId', userId)],
      );
      return response.documents
          .map((doc) => Follow.fromJson(doc.data))
          .toList();
    } catch (e) {
      throw Exception('Failed to list following: $e');
    }
  }

  Future<Follow> followUser(String followerId, String followingId) async {
    try {
      final doc = await _databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.followsCollectionId,
        documentId: ID.unique(),
        data: {'followerId': followerId, 'followingId': followingId},
      );
      return Follow.fromJson(doc.data);
    } catch (e) {
      throw Exception('Failed to follow user: $e');
    }
  }
}
