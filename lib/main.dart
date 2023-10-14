import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PermissionStatus _microphoneStatus = PermissionStatus.denied;
  PermissionStatus _cameraStatus = PermissionStatus.denied;
  PermissionStatus _photosStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final microphoneStatus = await _getPermissionStatus(Permission.microphone);
    final cameraStatus = await _getPermissionStatus(Permission.camera);
    final photosStatus = await _getPermissionStatus(Permission.photos);

    setState(() {
      _microphoneStatus = microphoneStatus;
      _cameraStatus = cameraStatus;
      _photosStatus = photosStatus;
    });
  }

  Future<PermissionStatus> _getPermissionStatus(Permission permission) async {
    return await permission.status;
  }

  Future<void> _requestPermission(Permission permission) async {
    final status = await permission.request();
    final permissionName = _getPermissionName(permission);
    _showPermissionToast(status, permissionName);
    _updatePermissionStatus(permission, status);
  }

  String _getPermissionName(Permission permission) {
    if (permission == Permission.microphone) {
      return 'Microphone';
    } else if (permission == Permission.camera) {
      return 'Camera';
    } else if (permission == Permission.photos) {
      return 'Photos';
    }
    return 'Unknown';
  }

  void _updatePermissionStatus(Permission permission, PermissionStatus status) {
    setState(() {
      if (permission == Permission.microphone) {
        _microphoneStatus = status;
      } else if (permission == Permission.camera) {
        _cameraStatus = status;
      } else if (permission == Permission.photos) {
        _photosStatus = status;
      }
    });
  }

  void _showPermissionToast(PermissionStatus status, String permissionName) {
    // if (status.isGranted) {
    //   Fluttertoast.showToast(
    //     msg: '$permissionName - Thành Công',
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.green,
    //     textColor: Colors.white,
    //   );
    // } else if (status.isDenied || status.isPermanentlyDenied) {
    //   Fluttertoast.showToast(
    //     msg: '$permissionName - Từ Chối',
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xin Quyền'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildPermissionTile(Permission.microphone, _microphoneStatus),
            _buildPermissionTile(Permission.camera, _cameraStatus),
            _buildPermissionTile(Permission.photos, _photosStatus),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionTile(Permission permission, PermissionStatus status) {
    final permissionName = _getPermissionName(permission);
    String statusText;
    Color statusColor;

    if (status.isGranted) {
      statusText = 'Đã Cấp Quyền';
      statusColor = Colors.green;
    } else if (status.isDenied) {
      statusText = 'Từ Chối Quyền';
      statusColor = Colors.red;
    } else if (status.isPermanentlyDenied) {
      statusText = 'Từ Chối Vĩnh Viễn';
      statusColor = Colors.red;
    } else {
      statusText = 'Chưa Có Quyền';
      statusColor = Colors.grey;
    }

    return ListTile(
      title: Text(permissionName),
      subtitle: Text(statusText),
      trailing: ElevatedButton(
        onPressed: () => _requestPermission(permission),
        child: Text('Xin Quyền'),
      ),
    );
  }
}
