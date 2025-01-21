# CoinTracker
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

