# 플러터 개발을 위한 기본 아키텍쳐 세팅입니다.

### DIO를 통한 API CALL

* 주요 파일 위치
    * lib/utils/SendData.dart

* API Header Setting
```
static Future<Options> _abstractHeader(Map<String, String>? headers) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var sessAuthKey = prefs.get(KEYS.SESSION_TOKEN).toString(); // JWT 토큰 세팅

    var options = Options(
        headers: Map()
    );
    options.headers![KEYS.SESSION_TOKEN] = sessAuthKey;
    options.contentType = 'application/json';
    options.responseType = ResponseType.json;
    options.receiveDataWhenStatusError = true;
    return options;
}

```

* GET TYPE
```
    // 쿼리스트링에 현재 디바이스 타입을 답아 넘긴다.
    static Map<String, String> isQueryString(queryString){
        if(queryString == null) queryString = Map<String, String>();
        queryString[KEYS.SESSION_TYPE] = Device.get().isAndroid ? "W" : "I";
        return queryString;
    }

    static Future<ResponseData> doGet(BuildContext context, String url, {Map<String, String>? headers, Map<String, String>? queryString}) async {
        try{
            var options = await _abstractHeader(headers);
            Response response = await Dio().get('${APIS.DOMAIN}' + url, options: options, queryParameters: isQueryString(queryString));
            return ResponseData(response: response);
        }on DioError catch(e){
            deleteSharedPreferences(context, e);
            return ResponseData(e: e);
        }
    }
```

* 사용 예제
```
    // Map 타입의 오브젝트에 request 값을 넣어 보낸다
    Map<String, dynamic> data = {};
    data['something'] = 'something';
    Future<ResponseData> response = SendData.doGet(context, '/api/get-something', queryString: data);
    // 보낸 결과는 Future타입으로 받아 .then 혹은 async await 를 사용하여 비동기로 받아오는 데이터를 처리한다.
```

### Provider를 통한 Store 세팅

* 주요 파일 위치
    * lib/stores/   // 스토어로 정의하여 사용할 파일들 위치
    * lib/stores.dart   // lib/stores/ 하위에 정의된 스토어 파일들을 하나로 묶어서 combine 함
    * lib/main.dart // lib/stores.dart 에 정의한 combine을 main.dart에 위젯으로 정의한다.

* 정의
```
import 'package:flutter_guest_app/objects/SessionUser.dart';

class SessionStore with ChangeNotifier {
    SessionUser? sessionUser; // 해당 부분은 /lib/objects/SessionUser.dart 에 있는 정의를 가져옴

    Future setSession(Map<String, dynamic>? map) async {
        if(map == null) return;
        try{
            sessionUser = SessionUser.fromJson(map);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString(KEYS.SESSION_TOKEN, this.sessionUser!.sessionKey!);
            notifyListeners(); // 해당 함수를 요청하여 스토어의 변화를 화면에 rebuild하도록 처리한다.
        }catch(e){

        }
    }
}
```

* 사용 방법 예제
1. 함수 내부에서 불러오는 법
```
SessionStore sessionStore = Provider.of(context, listen: false);
```

2. 위젯에서 불러와 처리하는 법
```
Consumer<SessionStore>(
    builder: (context, store, widget) {
        return Container(
            child: Text(store.sessionUser.sessionEmail)
        );
    }
)
```

