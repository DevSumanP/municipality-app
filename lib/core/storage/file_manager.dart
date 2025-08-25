import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:municipality_app/core/constants/app_constants.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static Directory? _applicationDocumentsDirectory;
  static Directory? _applicationSupportDirectory;

  static Future<void> init() async{
    _applicationDocumentsDirectory = await getApplicationDocumentsDirectory();
    _applicationSupportDirectory = await getApplicationSupportDirectory();
  }

  // Get application documents directory
  static Future<Directory> getAppDocumentsDirectory() async{
    return _applicationDocumentsDirectory ??= await getApplicationDocumentsDirectory();
  }

  // Get application support directory
  static Future<Directory> getAppSupportDirectory() async {
    return _applicationSupportDirectory ??= await getApplicationSupportDirectory();
  }

  // Create folder strucuture
  static Future<void> createFolderStructure() async{
    final appDir = await getAppDocumentsDirectory();

    final  folders = [
      AppConstants.documentsFolder,
      AppConstants.imagesFolder,
      AppConstants.videosFolder,
    ];

    for(final folder in folders){
      final dir = Directory(path.join(appDir.path, folder));
      if(!await dir.exists()){
        await dir.create(recursive: true);
      }
    }
  }


  // Get sprecifi folder path
  static Future<String> getFolderPath(String folderName) async{
    final appDir = await getAppDocumentsDirectory();
    return path.join(appDir.path, folderName);
  }

  // Get file path in specific folder
  static Future<String> getFilePath(String folderName, String fileName) async{
    final folderPath = await getFolderPath(folderName);
    return path.join(folderPath, fileName);
  }

  // Chekc if file exists
  static Future<bool> fileExists(String filePath) async{
    final file = File(filePath);
    return await file.exists();
  }

  // Get file size
  static Future<int> getFileSize(String filePath) async{
    final file = File(filePath);
    if (await file.exists()) {
      return await file.length();
    }
    return 0;
  }

  // Delete file
  static Future<bool> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Copy file
  static Future<bool> copyFile(String sourcePath, String destinationPath) async {
    try {
      final sourceFile = File(sourcePath);
      if (await sourceFile.exists()) {
        await sourceFile.copy(destinationPath);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Move file
  static Future<bool> moveFile(String sourcePath, String destinationPath) async {
    try {
      final sourceFile = File(sourcePath);
      if (await sourceFile.exists()) {
        await sourceFile.rename(destinationPath);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Clear folder
  static Future<void> clearFolder(String folderName) async {
    try {
      final folderPath = await getFolderPath(folderName);
      final dir = Directory(folderPath);
      if (await dir.exists()) {
        await dir.delete(recursive: true);
        await dir.create(recursive: true);
      }
    } catch (e) {
      // Handle error
    }
  }
 
  // Get folder size
  static Future<int> getFolderSize(String folderPath) async {
    try {
      final dir = Directory(folderPath);
      if (await dir.exists()) {
        int totalSize = 0;
        await for (final entity in dir.list(recursive: true)) {
          if (entity is File) {
            totalSize += await entity.length();
          }
        }
        return totalSize;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  // List files in folder
  static Future<List<FileSystemEntity>> listFilesInFolder(String folderPath) async {
    try {
      final dir = Directory(folderPath);
      if (await dir.exists()) {
        return dir.listSync();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

}
