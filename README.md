# logistics

# APK Download Link
[Download APK](https://github.com/amorenew/FlutterLogistics/raw/master/apk_build_01.apk "APK")

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
# FlutterLogistics
## Screenshots
### Splash
![alt text](https://raw.githubusercontent.com/amorenew/FlutterLogistics/master/Screenshot_1558590080.png)
### Login
![alt text](https://raw.githubusercontent.com/amorenew/FlutterLogistics/master/Screenshot_1558590096.png)
#### Dashboard
![alt text](https://raw.githubusercontent.com/amorenew/FlutterLogistics/master/Screenshot_1558590102.png)
### Shipments List
![alt text](https://raw.githubusercontent.com/amorenew/FlutterLogistics/master/Screenshot_1558590107.png)
### Filter Shipments
![alt text](https://raw.githubusercontent.com/amorenew/FlutterLogistics/master/Screenshot_1558590120.png)


## APIs ( Base URL: https://quiz.logistechs.co/api )

Login:
/login POST application/json
Request: {"username":"user1", "password":"123456"}
Response: {"status":"ok", "token":"....", "msg":""}

List: /list?token={token} GET application/json
Response: {"status":"ok","shipments":[{"reference":"AB123456","from":"ABC Company","status":"out_for_delivery","created_at":"09-05-2019","deliver_at":"09-05-2019 11:50:00","location":"26.1582106,50.5056794","price":"BHD 12.000"}]}

Action: /action?token={token} POST application/json
Request: {"shipment":"AB123456", "action":"hold|cancel"}
Response: {"status":"ok", "msg":"Shipment Updated"}
