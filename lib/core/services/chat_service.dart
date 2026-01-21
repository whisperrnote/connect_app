import 'package:appwrite/appwrite.dart';
import '../constants/appwrite_constants.dart';
import 'appwrite_service.dart';
import '../models/conversation_model.dart';
import '../models/message_model.dart';

class ChatService {
  final Databases _databases = AppwriteService().databases;
  final Realtime _realtime = AppwriteService().realtime;

  Future<List<Conversation>> listConversations(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.conversationsCollectionId,
        queries: [
          Query.contains('participants', [userId]),
          Query.orderDesc('updatedAt'),
        ],
      );
      return response.documents
          .map((doc) => Conversation.fromJson(doc.data))
          .toList();
    } catch (e) {
      throw Exception('Failed to list conversations: $e');
    }
  }

  Future<List<Message>> listMessages(String conversationId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.messagesCollectionId,
        queries: [
          Query.equal('conversationId', conversationId),
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
    required String conversationId,
    required String senderId,
    required String content,
    String type = 'text',
    List<String>? attachments,
  }) async {
    try {
      final doc = await _databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.messagesCollectionId,
        documentId: ID.unique(),
        data: {
          'conversationId': conversationId,
          'senderId': senderId,
          'content': content,
          'type': type,
          'attachments': attachments,
        },
      );

      // Update conversation's last message and updatedAt
      await _databases.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.conversationsCollectionId,
        documentId: conversationId,
        data: {
          'lastMessageId': doc.$id,
          'lastMessageAt': DateTime.now().toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );

      return Message.fromJson(doc.data);
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  RealtimeSubscription subscribeToMessages(String conversationId) {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.messagesCollectionId}.documents',
    ]);
  }

  Future<Conversation> createConversation({
    required List<String> participants,
    String type = 'direct',
    String? name,
    String? avatar,
  }) async {
    try {
      final doc = await _databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.conversationsCollectionId,
        documentId: ID.unique(),
        data: {
          'participants': participants,
          'type': type,
          'name': name,
          'avatar': avatar,
          'updatedAt': DateTime.now().toIso8601String(),
        },
        permissions: [
          ...participants.map((id) => Permission.read(Role.user(id))),
          ...participants.map((id) => Permission.update(Role.user(id))),
        ],
      );
      return Conversation.fromJson(doc.data);
    } catch (e) {
      throw Exception('Failed to create conversation: $e');
    }
  }
}
