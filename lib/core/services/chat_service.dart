import 'package:appwrite/appwrite.dart';
import '../constants/appwrite_constants.dart';
import 'appwrite_service.dart';
import '../models/chat_model.dart';

class ChatService {
  final Databases _databases = AppwriteService().databases;
  final Realtime _realtime = AppwriteService().realtime;

  Future<List<Chat>> listChats(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.chatsCollectionId,
        queries: [
          Query.contains('participantIds', [userId]),
          Query.orderDesc('\$updatedAt'),
        ],
      );
      return response.documents.map((doc) => Chat.fromJson(doc.data)).toList();
    } catch (e) {
      throw Exception('Failed to list chats: $e');
    }
  }

  Future<List<Message>> listMessages(String chatId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.messagesCollectionId,
        queries: [
          Query.equal('chatId', chatId),
          Query.orderDesc('\$createdAt'),
        ],
      );
      return response.documents
          .map((doc) => Message.fromJson(doc.data))
          .toList();
    } catch (e) {
      throw Exception('Failed to list messages: $e');
    }
  }

  Future<Message> sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String content,
    String type = 'text',
  }) async {
    try {
      final doc = await _databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.messagesCollectionId,
        documentId: ID.unique(),
        data: {
          'chatId': chatId,
          'senderId': senderId,
          'receiverId': receiverId,
          'content': content,
          'type': type,
          'createdAt': DateTime.now().toIso8601String(),
        },
      );

      // Update chat's last message and updatedAt
      await _databases.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.chatsCollectionId,
        documentId: chatId,
        data: {
          'lastMessage': doc.data,
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );

      return Message.fromJson(doc.data);
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  RealtimeSubscription subscribeToMessages(String chatId) {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.messagesCollectionId}.documents',
    ]);
  }

  Future<Chat> createChat(List<String> participantIds) async {
    try {
      final doc = await _databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.chatsCollectionId,
        documentId: ID.unique(),
        data: {
          'participantIds': participantIds,
          'createdAt': DateTime.now().toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String(),
        },
        permissions: [
          ...participantIds.map((id) => Permission.read(Role.user(id))),
          ...participantIds.map((id) => Permission.update(Role.user(id))),
        ],
      );
      return Chat.fromJson(doc.data);
    } catch (e) {
      throw Exception('Failed to create chat: $e');
    }
  }
}
