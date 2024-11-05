import '../models/task.dart';

class TaskService {
  static final TaskService _instance = TaskService._internal();
  factory TaskService() => _instance;
  TaskService._internal();

  final List<Task> _tasks = [];
  int _nextId = 1;

  List<Task> getAllTasks() {
    return List.from(_tasks);
  }

  Task? getTaskById(int id) {
    try {
      return _tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }

  Task addTask(Task task) {
    task.id = _nextId++;
    _tasks.add(task);
    return task;
  }

  bool updateTask(Task task) {
    if (task.id == null) return false;

    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      return true;
    }
    return false;
  }

  bool deleteTask(int id) {
    int index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks.removeAt(index);
      return true;
    }
    return false;
  }

  List<Task> getCompletedTasks() {
    return _tasks.where((task) => task.isCompleted).toList();
  }

  List<Task> getPendingTasks() {
    return _tasks.where((task) => !task.isCompleted).toList();
  }

  bool toggleTaskCompletion(int id) {
    var task = getTaskById(id);
    if (task != null) {
      task.isCompleted = !task.isCompleted;
      return updateTask(task);
    }
    return false;
  }

  void clearAllTasks() {
    _tasks.clear();
    _nextId = 1;
  }
}
