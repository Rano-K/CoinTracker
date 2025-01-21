# CoinTracker
<img src = "https://file.notion.so/f/f/6eaeed49-aa3c-4cb4-91d7-a92fcc3b7971/a21c74c4-1bc0-4926-bdb0-c101d02359b6/Apple_iPhone_Xs_Max_Presentation_(1)_%E1%84%87%E1%85%A9%E1%86%A8%E1%84%89%E1%85%A1%E1%84%87%E1%85%A9%E1%86%AB_2.jpg?table=block&id=120e9da4-b740-80e2-ac67-df0fba022a40&spaceId=6eaeed49-aa3c-4cb4-91d7-a92fcc3b7971&expirationTimestamp=1737460800000&signature=LVBUZB6dsfOeDSazNQv7qW7MtZpiFGmuB0sfKTY4eO0&downloadName=Apple+iPhone+Xs+Max+Presentation+%281%29+%E1%84%87%E1%85%A9%E1%86%A8%E1%84%89%E1%85%A1%E1%84%87%E1%85%A9%E1%86%AB+2.jpg" />
API를 이용한 coin시세 Tracking앱<br><br>

실시간 가격, 변동폭 표시<br>
실시간 시가총액에 따른 순위 표시<br>
흑백 테마 변경 가능<br>

### <a href="https://youtube.com/shorts/GF8x7Xl29nQ?feature=share">영상</a>

### 내용
- Restful API, WebSocket을 APP에 연동<br>
  - RestfulAPI를 이용해 정적데이터를 수신, WebSocket을 이용해 실시간 데이터를 갱신
  - viewLogic구현
- Async/Await를 활용해 Thread블럭 방지<br>
  - 네트워크 요청과 데이터 디코딩 작업을 비동기 처리
  - Thread가 죽는걸 방지
- WebSocket을 코인 거래데이터를 수신하는데 사용
  - JSON형식 디코딩 후 main thread에서 UI업데이트
  - 연결 실패시 세션 닫고 리소스 해제, reconnect과정 구현

### Detail
- quoteAllCoins(limit:)
  - 전체 코인 리스트 반환
  - limit : 가져올 코인 갯수 제한
  - 작동 방식 : URL생성 -> 네트워크 요청 -> JSON디코딩 -> Coin배열 반환
  <img src ="https://drive.google.com/file/d/1yTtrPnz_JwXU-59Y7kDARA55yfAkUkrw/view?usp=sharing" />
- quote(_ coinId:)
  - 특정 코인데이터 반환
  - coinId : 코인의 고유 식별자
  - 
