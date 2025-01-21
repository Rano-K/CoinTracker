# CoinTracker
<img src = "https://file.notion.so/f/f/6eaeed49-aa3c-4cb4-91d7-a92fcc3b7971/a21c74c4-1bc0-4926-bdb0-c101d02359b6/Apple_iPhone_Xs_Max_Presentation_(1)_%E1%84%87%E1%85%A9%E1%86%A8%E1%84%89%E1%85%A1%E1%84%87%E1%85%A9%E1%86%AB_2.jpg?table=block&id=120e9da4-b740-80e2-ac67-df0fba022a40&spaceId=6eaeed49-aa3c-4cb4-91d7-a92fcc3b7971&expirationTimestamp=1737460800000&signature=LVBUZB6dsfOeDSazNQv7qW7MtZpiFGmuB0sfKTY4eO0&downloadName=Apple+iPhone+Xs+Max+Presentation+%281%29+%E1%84%87%E1%85%A9%E1%86%A8%E1%84%89%E1%85%A1%E1%84%87%E1%85%A9%E1%86%AB+2.jpg" />
API를 이용한 coin시세 Tracking앱
실시간 가격, 변동폭 표시
실시간 시가총액에 따른 순위 표시
흑백 테마 변경 가능

### Detail
- Restful API, WebSocket을 APP에 연동<br>
  - WebSocket을 코인 거래데이터를 수신하는데 사용
    - JSON형식 디코딩 후 main thread에서 UI업데이트
    - 연결 실패시 세션 닫고 리소스 해제, reconnect과정 구현
- Async/Await를 활용해 Thread블럭 방지

