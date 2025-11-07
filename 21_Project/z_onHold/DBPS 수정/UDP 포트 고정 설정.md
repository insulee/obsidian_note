---
share_link: https://share.note.sx/y9fu4qmh#n+pQAzhhic/PCkdTHT5cvFPRXR37S31TnRhoQkYss/U
share_updated: 2025-05-13T09:17:29+09:00
---
## 1. FXML 파일 변경 - 통신설정

**파일 경로:** `src/main/resources/dbps/dbps/fxmls/communicationSetting.fxml`

**변경 내용:**
- UDP IP Port 텍스트필드를 수정 불가능하게 설정하고 일반 텍스트처럼 보이도록 스타일 변경
- 텍스트필드의 값을 "5108"로 고정
- 테두리와 포커스 효과를 제거하여 일반 텍스트처럼 보이게 함

**변경 전 코드:**
```xml
<TextField fx:id="UDPIPPort" layoutX="210.0" layoutY="49.0" prefHeight="25.0" prefWidth="145.0" text="5108" />
```

**변경 후 코드:**
```xml
<TextField fx:id="UDPIPPort" layoutX="210.0" layoutY="49.0" prefHeight="25.0" prefWidth="145.0" 
    text="5108" editable="false" 
    style="-fx-background-color: #F4F4F4; -fx-border-width: 0; -fx-focus-color: transparent; -fx-faint-focus-color: transparent; -fx-text-fill: #555555;" />
```

## 2. FXML 파일 변경 - dabitNet

**파일 경로:** `src/main/resources/dbps/dbps/fxmls/dabitNet.fxml`

**변경 내용:**

- UDP 연결시 port를 5108로 할 것을 안내

**변경 전 코드:**
```xml
<Label layoutX="115.0" layoutY="304.0" prefHeight="14.0" prefWidth="220.0" text="(UDP-Ethernet: 5108, UDP-Wifi: 5107)" />
```

**변경 후 코드:**
```xml
<Label layoutX="115.0" layoutY="304.0" prefHeight="14.0" prefWidth="220.0" text="(UDP port: 5108)" />
```

## 3. 설정 파일 변경

**파일 경로:** `config/config.properties`

**변경 내용:**

- UDP 포트 기본값을 "5109"에서 "5108"로 변경

**변경 전 코드:**
```properties
UDPPort=5109
```

**변경 후 코드:**
```properties
UDPPort=5108
```


## 4. 기본값 설정 코드 변경

**파일 경로:** `src/main/java/dbps/dbps/service/ConfigService.java`

**변경 전 코드:**
```java
defaultProperties.setProperty("UDPPort", "5109");
```

**변경 후 코드:**
```java
defaultProperties.setProperty("UDPPort", "5108");
```

