import 'package:testtest/data/api_client.dart';
import 'package:testtest/domain/user_repository.dart';
import '../domain/user.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiClient apiClient;

  UserRepositoryImpl({required this.apiClient});

  @override
  Future<List<User>> getUsers() async {
    final userData = await apiClient.getUsers();
    final List<User> users = userData.map((userData) => User(id: userData['id'], name: userData['name'], email: userData['email'])).toList();
    return users;
  }

  @override
  Future<User> getUser(int id) async {
    final userData = await apiClient.getUser(id);
    final User user = User(id: userData['id'], name: userData['name'], email: userData['email']);
    return user;
  }
}