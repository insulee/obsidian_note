---
share_link: https://share.note.sx/vf3jpqxj#SnFHofdYSw10bl8U16sjej/QWI11nFc63HvW3H8GGds
share_updated: 2025-04-28T08:16:44+09:00
---
## 5/8 수정사항
- RS485 연결시 0번도 전송되는 문제


## 4/25 수정사항
### 수정파일:
- src/main/resources/dbps/dbps/fxmls/dabitNet.fxml
- 수정사항:
	- Controller Client Mode 내 컴포넌트들을 오른쪽으로 이동해 종속성 표시
	- UI 개선
#### 수정전(좌)/수정후(우)
![[dbNet_network_수정전후.png]]


### 수정파일:
- src/main/resources/dbps/dbps/fxmls/sizeOfDisplayBoard.fxml
- src/main/resources/dbps/dbps/fxmls/setting.fxml
- 수정사항:
	- Label과 컴포넌트간 간격 조정 및 중앙정렬(빨간선 참고)
	- Pane내의 컴포넌트 좌우 여백 같게 조정
	 
#### 수정전(좌)/수정후(우) 
![[설정_수정전후1.png]]

### 수정파일:
- src/main/resources/dbps/dbps/fxmls/HEXMessage.fxml
- 수정사항:
	- 섹션번호의 라디오버튼 위로 이동하여 간격 동일하게
	- 페이지 메시지 선택시 페이지 라벨 투명하게, 콤보박스 크게
	- 문자색상, 문자배경색상, 문구 입력 텍스트필드 크게
	 
#### 수정전(좌)/수정후(우) 
![[프로토콜전송_수정전후1.png]]


## 4/24 수정사항
### 수정파일:
- src/main/resources/dbps/dbps/fxmls/communicationSetting.fxml

1. **UI 요소 간 간격 통일**
   - 모든 패널(Pane) 사이 간격을 14픽셀로 일관되게 조정
   - Serial 패널 내부의 요소들(라벨, 콤보박스, 체크박스, 버튼) 간 간격을 균일하게 조정
   - 버튼 행 간 간격도 일정하게 정리

2. **MQTT 관련 개선**
   - 라디오 버튼 텍스트를 "mqtt"에서 "MQTT"로 대문자화
   - 버튼 텍스트를 "MqttSetting"에서 "MQTT Setting"으로, "MqttServer"에서 "MQTT Server"로 일관성 있게 변경
   - MQTT 패널 버튼 높이를 다른 버튼들과 동일하게 27픽셀로 조정
   - MQTT 패널 자체 높이도 적절하게 축소

3. **버튼 텍스트 표기법 변경**
   - "dBNet"을 "dbNet"으로, "dBBle"을 "dbBle"로 변경

1. **전체 UI 크기 최적화**
   - AnchorPane 전체 높이를 700픽셀에서 680픽셀로 축소하여 로그를 가리는 문제 해결
#### 수정전(좌)/수정후(우)

![[통신설정_수정전후.png]]



### 수정파일:

- src/main/resources/dbps/dbps/fxmls/HEXMessage.fxml
#### 수정전(좌)/수정후(우)![[hex_수정전후.png]]


### 수정파일:

- src/main/resources/dbps/dbps/fxmls/boardSettings.fxml
- 수정내용:
	- Label과 Combobox 간격 넓게
	- 버튼을 아래로 내려 UI 개선
#### 수정전(좌)/수정후(우)
![[보드기능설정_수정전후.png]]


### 수정파일:

- src/main/resources/dbps/dbps/fxmls/messageSetting.fxml]
- 수정내용:
	- Label 왼쪽 기준 정렬
	- Pane내의 컴포넌트 좌우 여백 같게 조정

#### 수정전(좌)/수정후(우)
![[페이지메시지설정_수정전후.png]]

## 4/23 수정사항

- Simulator.code-workspace 파일 생성


## 4/20 수정사항

수정파일:
- src/main/resources/dbps/dbps/fxmls/HEXMessage.fxml
- src/main/resources/dbps/dbps/fxmls/setting.fxml

#### 상단 검은색 테두리 제거

- HEXMessage.fxml과 setting.fxml 파일의 루트 AnchorPane에 적용된 인라인 스타일로 인해 탭 영역에 검은색 테두리가 표시
- 이 인라인 스타일이 main.css에 정의된 스타일보다 우선 적용되어 탭 스타일이 일관되지 않음
- 개선내용:
	- 각 탭 컨텐츠 영역 상단에 있던 검은색 테두리가 제거
	- main.css에 정의된.tab-header-background 스타일이 올바르게 적용
	- 모든 탭 영역이 dabitNet.fxml과 동일한 스타일로 표시

- HEXMessage.fxml:
```Java
// 기존
<AnchorPane fx:id="HEXMsgAP" ... style="-fx-border-color: black; -fx-border-width: 1 0 0 0" ...>

// 개선: style="" 제거
<AnchorPane fx:id="HEXMsgAP" ... >
```
- setting.fxml:
```Java
// 기존   
<AnchorPane minHeight="0.0" minWidth="0.0" ... style="-fx-border-color: black; -fx-border-width: 1 0 0 0" ...>
    
// 개선: style="" 제거
<AnchorPane minHeight="0.0" minWidth="0.0" ...>
```

#### 수정전(좌)/수정후(우)
![[프로토콜전송_수정전후.png]]![[설정_수정전후.png]]



## 4/19 수정사항

수정파일:
src/main/java/dbps/dbps/controller/DisplaySignalSettingController.java
#### 자동 스크롤링 기능 개선
- autoTransfer 기능 사용 시 선택된 항목이 ListView의 현재 보이는 영역을 벗어나면 스크롤이 자동으로 따라가지 않아 사용자가 어떤 항목이 처리되고 있는지 확인할 수 없음
- 개선 내용:
	- 처음 ~ 6번째: 스크롤 없이 항목 선택만 변경
	- 중간 항목: 선택된 항목이 항상 리스트뷰의 중간에 위치하도록 스크롤 자동 조정
	- 마지막 항목: 스크롤 위치를 고정하고 선택만 계속 이동
	- 결과적으로 사용자가 항상 현재 처리 중인 항목을 볼 수 있으며, 자연스러운 스크롤 경험 제공
```java
// 스마트 스크롤링 로직 추가
if (index < middlePosition) {
    // 처음 몇 개 항목은 스크롤 없음 (이미 보이므로)
    signalList.scrollTo(0);
} else if (index >= signalCount - (visibleItemCount - middlePosition)) {
    // 마지막 항목들은 스크롤 최대 위치 유지
    signalList.scrollTo(signalCount - visibleItemCount);
} else {
    // 중간 항목들은 항상 리스트뷰 중간에 위치하도록
    signalList.scrollTo(index - middlePosition);
}
```
#### 선택 항목 하이라이트 시각효과 개선
- 자동 전송 모드에서 선택된 항목이 회색으로만 하이라이트 되어 눈에 잘 띄지 않음
- 사용자가 직접 클릭할 때는 파란색으로 선택되어 시각적으로 더 명확했음
- 개선 내용:
	- 자동 전송 모드에서도 항목이 파란색으로 하이라이트 되어 사용자가 현재 선택된 항목을 쉽게 확인 가능
	- 사용자가 직접 클릭했을 때와 동일한 시각적 피드백 제공
```java
// 기존: 
signalList.getSelectionModel().select(index);

// 개선: 파란색 하이라이트로 표시되도록 수정
signalList.getSelectionModel().clearAndSelect(index);
signalList.getFocusModel().focus(index);
signalList.requestFocus();
```

#### 표출신호 자동전송 마지막 패킷 설정간격 적용 
- Timeline 실행 방식의 불일치로 인해 마지막 패킷이 너무 빨리 처리
- 개선 내용:
	- Timeline 실행 방식 변경
		- 이전: timeline.setCycleCount(signalCount) - 신호 개수만큼 Timeline을 반복 실행
		- 수정: timeline.setCycleCount(1) - Timeline을 한 번만 실행하고 모든 KeyFrame이 순차적으로 처리되도록 변경
	- 처리할 항목 수 정확히 계산 
		- int itemsToProcess = signalCount - startIdx - 선택한 항목부터 마지막까지 처리해야 할 정확한 항목 수 계산
	- 반복문과 인덱스 계산 방식 개선
		- 이전: for (int i = startIdx; i < signalCount; i++) {
		          int index = i; // 직접 i 값 사용
		- 수정: for (int i = 0; i < itemsToProcess; i++) {
		          int index = startIdx + i; // 정확한 인덱스 계산
	- KeyFrame 타이밍 계산 간소화
		- 이전: Duration.seconds((i - startIdx) * time) - 복잡한 계산식
		- 수정: Duration.seconds(i * time) - 간결하고 직관적인 계산식

#### 수정전
![[자동전송_수정전.gif|300]]
#### 수정후
![[자동전송_수정후.gif|300]]





## 4/18 수정사항
- 수정파일: src/main/resources/dbps/dbps/fxmls/defaultChange.fxml
	- label+textField 세트별로 간격을 조정해 같은 메뉴로 보이게 ui 수정
	- (좌)수정전, (우)수정후
	- ![[default_ip_이전.png|200]]![[default_ip_이후.png|200]]
- 수정파일: src/main/resources/dbps/dbps/fxmls/advancedSetting.fxml
	- 컨트롤러 재시작 버튼과 컨트롤러 공장초기화 버튼 사이에 간격을 두어 ui 개선
	- (좌)수정전, (우)수정후
	- ![[재시작_초기화버튼변경.png|300]]
- 수정파일: src/main/resources/dbps/dbps/fxmls/dabitNet.fxml
	- Subnet Mask와 Gateway의 textField 간격 나머지와 동일하게 변경
	- IP Config Method 아래로 이동해 간격 조정
	- (좌)수정전, (우)수정후
	- ![[dbnet변경.png]]



