import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;

class FileUtils {
  // Get file extension
  static String getFileExtension(String filePath) {
    return path.extension(filePath).toLowerCase();
  }

  // Get file name without extension
  static String getFileNameWithoutExtension(String filePath) {
    return path.basenameWithoutExtension(filePath);
  }

  // Get file name with extension
  static String getFileName(String filePath) {
    return path.basename(filePath);
  }

  // Check if file is image
  static bool isImage(String filePath) {
    const imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
    return imageExtensions.contains(getFileExtension(filePath));
  }

  // Check if file is video
  static bool isVideo(String filePath) {
    const videoExtensions = ['.mp4', '.avi', '.mov', '.wmv', '.flv', '.webm'];
    return videoExtensions.contains(getFileExtension(filePath));
  }

  // Check if file is audio
  static bool isAudio(String filePath) {
    const audioExtensions = ['.mp3', '.wav', '.aac', '.ogg', '.m4a'];
    return audioExtensions.contains(getFileExtension(filePath));
  }

  // Check if file is document
  static bool isDocument(String filePath) {
    const docExtensions = ['.pdf', '.doc', '.docx', '.xls', '.xlsx', '.ppt', '.pptx', '.txt'];
    return docExtensions.contains(getFileExtension(filePath));
  }

  // Get MIME type
  static String getMimeType(String filePath) {
    final extension = getFileExtension(filePath);
    const mimeTypes = {
      '.jpg': 'image/jpeg',
      '.jpeg': 'image/jpeg',
      '.png': 'image/png',
      '.gif': 'image/gif',
      '.bmp': 'image/bmp',
      '.webp': 'image/webp',
      '.mp4': 'video/mp4',
      '.avi': 'video/x-msvideo',
      '.mov': 'video/quicktime',
      '.wmv': 'video/x-ms-wmv',
      '.flv': 'video/x-flv',
      '.webm': 'video/webm',
      '.mp3': 'audio/mpeg',
      '.wav': 'audio/wav',
      '.aac': 'audio/aac',
      '.ogg': 'audio/ogg',
      '.m4a': 'audio/mp4',
      '.pdf': 'application/pdf',
      '.doc': 'application/msword',
      '.docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      '.xls': 'application/vnd.ms-excel',
      '.xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      '.ppt': 'application/vnd.ms-powerpoint',
      '.pptx': 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
      '.txt': 'text/plain',
    };
    return mimeTypes[extension] ?? 'application/octet-stream';
  }

  // Read file as bytes
  static Future<Uint8List?> readFileAsBytes(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.readAsBytes();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Write bytes to file
  static Future<bool> writeBytesToFile(String filePath, Uint8List bytes) async {
    try {
      final file = File(filePath);
      await file.writeAsBytes(bytes);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Create directory if not exists
  static Future<bool> createDirectoryIfNotExists(String dirPath) async {
    try {
      final dir = Directory(dirPath);
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get file size in bytes
  static Future<int> getFileSize(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.length();
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  // Check if file exists
  static Future<bool> fileExists(String filePath) async {
    try {
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }
}