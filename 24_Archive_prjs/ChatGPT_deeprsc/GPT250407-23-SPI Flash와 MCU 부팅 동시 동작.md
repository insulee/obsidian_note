감사합니다. 키패드에서 MCU가 부팅과 동시에 패킷을 시차 없이 보내고 있다는 점이 핵심인 것 같네요. 지금부터 이 상황에서 SPI Flash 메모리(W25Q32)가 리셋되거나, 저장된 데이터가 손상될 가능성이 있는지를 집중적으로 분석해보겠습니다.

패킷 재전송 시점, MCU 초기화 상태, 플래시 내부 명령 처리 타이밍 등을 고려한 위험 요소들을 함께 점검하여 알려드릴게요.

# SPI Flash와 MCU 부팅 동시 동작에 대한 위험 요소 분석

## 1. 부팅 중 UART 수신 및 Flash 읽기 병행의 위험 요소

MCU가 부팅 초기에 완전히 초기화되기 전에 UART로 명령을 받고 SPI Flash에서 데이터를 읽으려고 하면 **타이밍 문제**가 발생할 수 있습니다. 예를 들어, MCU가 아직 SPI Flash 인터페이스를 설정하거나 Flash를 준비하기 전에 명령을 처리하면 **명령 실행이 불완전하게 끝나거나 실패**할 수 있습니다. 특히 LPC4330처럼 외부 SPI Flash(W25Q32)에 저장된 코드를 실행하거나 데이터를 읽는 경우, **부팅 과정에서 MCU가 Flash로부터 코드를 읽는 작업과 UART 인터럽트로 들어온 명령 처리 작업이 겹칠 수 있습니다.** 이러한 경합 상태에서는 Flash에서 데이터를 제대로 읽지 못해 **동일 명령을 반복 수신**하는 상황이 발생할 수 있습니다. 결과적으로 MCU가 해당 명령에 즉시 응답하지 못하고, 키패드 측에서는 응답 누락으로 판단하여 **명령을 재전송**하게 됩니다. 이는 로그에서 부팅 중 동일한 명령 패킷이 여러 번 수신되는 것으로 나타납니다.

이러한 **동시 처리**는 Flash 메모리 자체의 물리적 손상보다는 **데이터 읽기 오류**나 MCU 측의 처리 지연으로 이어질 가능성이 큽니다. 부팅 시점에 **Flash 초기화가 완료되기 전에 데이터를 읽으려고 하면 실패**할 수 있으므로, **MCU 부팅 완료 신호 이후에 키패드 명령을 보내는 프로토콜**을 갖추는 것이 안전합니다. 간단히 말해, **MCU가 완전히 준비되기 전에 들어온 명령은 처리 도중 실패할 위험이 높습니다.** 다만 이러한 실패는 Flash 데이터의 손상을 의미하는 것은 아니며, **재시도하면 정상적으로 처리**될 수 있습니다.

## 2. SPI Flash 내부 상태에 미치는 영향 (Continuous Read Mode 등)

**Continuous Read Mode**: Winbond W25Q32 같은 SPI Flash에는 **연속 읽기 모드(Continuous Read Mode)**라는 기능이 있습니다. 이는 한 번 명령을 보내고 여러 바이트를 연속해서 읽을 때 명령 오버헤드를 줄이는 기능인데, **MCU 부팅 중에 이 모드가 남아 있을 경우** 문제가 될 수 있습니다. 예를 들어, MCU가 부팅 과정에서 SPI Flash로부터 코드를 **XIP(eXecute In Place)** 방식 등으로 연속 읽기하면서 Continuous Read Mode 상태(Axh 패턴의 모드 비트)가 설정되었을 수 있습니다. 이런 상태에서 MCU가 리셋되거나 새 명령을 보내면, Flash는 여전히 **이전 연속 읽기 상태**에 머물러 있어서 **새로운 표준 명령을 인식하지 못할 수 있습니다 ([](https://datasheet.octopart.com/W25Q64BVSFIG-Winbond-datasheet-14152614.pdf#:~:text=If%20the%20system%20controller%20is,Reset%20instruction%20as%20the%20first))**. Winbond 데이터시트에서도 **“시스템 리셋 후 첫 명령으로 _Continuous Read Mode Reset_ 명령(0xFF)을 보내 연속 읽기 모드를 해제하라”**고 권고하고 있습니다 ([](https://datasheet.octopart.com/W25Q64BVSFIG-Winbond-datasheet-14152614.pdf#:~:text=is%20recommended%20to%20issue%20a,%E2%80%9CAx%E2%80%9D%20hex%20state%20and%20allow)). 이는 연속 읽기 모드의 잔여 상태를 풀어주어 Flash가 **다시 정상 명령을 받아들이게 하기 위한 조치**입니다.

**부분 해독(Partial Decode)**: MCU가 Flash로 보낸 SPI 명령이 **중간에 끊기거나** (예: CS 신호가 일찍 High로 올라감) **다른 작업으로 끼어들어 불완전하게 수신**되면, Flash 입장에서는 명령을 끝까지 받지 못해 **아무 동작도 수행되지 않거나 잘못된 해석**이 될 수 있습니다. 일반적으로 SPI Flash는 **/CS 핀이 High로 돌아가면 현재 진행 중이던 명령 입력을 취소**하고 대기 상태로 복귀합니다. 실제로 Winbond Flash의 Page Program(페이지 쓰기) 시퀀스를 보면, **모든 바이트를 다 보낸 뒤 /CS를 High로 만들어야 명령이 실행**되며, 그렇지 않으면 명령이 수행되지 않는다고 명시되어 있습니다 ([](https://datasheet.octopart.com/W25Q64BVSFIG-Winbond-datasheet-14152614.pdf#:~:text=As%20with%20the%20write%20and,BUSY%20bit%20is%20a%201)). 따라서 **명령이 불완전하게 전달되면 Flash는 해당 명령을 무시**하고 대기하게 되므로, 내부적으로 **잘못된 상태로 남아있는 일은 드뭅니다**. 다만, 앞서 언급한 Continuous Read Mode처럼 **특정 모드 비트가 설정된 상태**에서는 다음 명령 해독 방식에 영향을 줄 수 있으므로, **필요시 소프트리셋 명령이나 더미 클럭**을 보내 Flash의 상태를 초기화해주는 것이 좋습니다 ([](https://datasheet.octopart.com/W25Q64BVSFIG-Winbond-datasheet-14152614.pdf#:~:text=is%20recommended%20to%20issue%20a,%E2%80%9CAx%E2%80%9D%20hex%20state%20and%20allow)).

요약하면, **MCU 부팅 중 UART 수신과 Flash 읽기가 겹쳐도 Flash 내부의 논리 상태(명령 해독기 등)가 영구적으로 망가질 가능성은 낮습니다.** 하지만 **Continuous Read Mode를 해제하지 않으면 첫 명령이 먹히지 않아** 재시도하게 되는 등 **일시적인 통신 문제**는 발생할 수 있습니다.

## 3. UART 패킷 재전송과 SPI 명령 타이밍 충돌의 데이터 무결성 영향

**동시에 여러 작업이 겹치는 상황**에서 **데이터 무결성** 측면을 고려해보면, 다행히 읽기 동작 자체는 Flash의 저장된 데이터를 변경하지는 않습니다. *"읽기 동작이 Flash를 손상시킬 가능성은 매우 낮으며, 특별한 결함이 없는 한 읽기로 데이터가 손상되지는 않는다"*는 업계의 의견도 있습니다 ([arduino - Flash memory corruption possible reasons? - Electrical Engineering Stack Exchange](https://electronics.stackexchange.com/questions/706697/flash-memory-corruption-possible-reasons#:~:text=Reading%20could%20corrupt%20the%20flash%2C,it%20is%20rated%20for%20reading)). 따라서 **UART로 동일 명령이 연이어 들어와 Flash 읽기 명령을 반복한다 해도 그 행위만으로 Flash 저장 내용이 변질되지는 않습니다.**

다만, **타이밍 충돌로 인해 잘못된 데이터가 읽히거나 MCU가 오동작할 가능성**은 존재합니다. 예를 들어, 첫 번째 명령에 대한 Flash 읽기가 완료되기 전에 두 번째 UART 명령이 들어와 버리면, 앞서 설명한 대로 SPI 명령이 중첩되어 **Flash가 아무 동작도 못하거나 잘못된 응답**을 할 수 있습니다. 그 결과 MCU는 **읽은 데이터가 없거나 엉뚱하게 나와서 실패**로 인지하고, 키패드는 다시 명령을 보내는 식의 **반복 시도**가 발생합니다. 이런 현상은 **데이터 무결성(Flash에 저장된 값 자체의 변질)** 문제가 아니라 **통신상의 일시적 오류**로 봐야 합니다. 통신이 제대로 동기화되지 않아 **MCU가 데이터를 제때 못 받아 화면 출력에 실패**하지만, Flash에 저장된 내용 자체는 그대로입니다.

**대처 방안**으로, **SPI Flash 액세스 중에는 UART 인터럽트를 잠시 마스킹**하거나, **명령 큐**를 두어 순차적으로 처리하는 것이 안전합니다. 이렇게 하면 **한 번에 하나의 SPI 명령만 수행**되어 Flash 명령들이 충돌하지 않으므로, 항상 올바른 데이터 읽기가 보장됩니다. 또한 **UART 측에도 흐름 제어**나 **ACK 신호**를 도입하여 MCU가 명령을 처리 중일 때는 추가 명령을 보내지 않도록 설계하면 이러한 충돌을 예방할 수 있습니다.

## 4. Flash 쓰기 보호 미설정 시 의도치 않은 명령 해석 가능성

외부 SPI Flash의 **쓰기 보호 기능(WP 핀, Status Register의 Block Protect 등)**이 활성화되어 있지 않으면, **잘못된 SPI 명령이 해석되어 예기치 않은 쓰기/삭제 동작으로 이어질 가능성**을 고려해야 합니다. 정상적인 환경에서는 Flash에 데이터를 쓰거나 지우려면 **반드시 사전에 “Write Enable”(0x06) 명령을 보내 WEL(Status Register의 Write Enable Latch)을 1로 세트**해야 하며, 그런 다음에야 프로그램/삭제 명령이 받아들여집니다 ([](https://datasheet.octopart.com/W25Q64BVSFIG-Winbond-datasheet-14152614.pdf#:~:text=The%20Page%20Program%20instruction%20allows,must%20be%20held%20low%20for)). 더욱이, **명령이 완전히 입력되고 /CS가 정확한 시점에 High로 올라가야 내부 쓰기 동작이 시작**되므로, **조금이라도 어긋나면 쓰기/삭제 명령은 실행되지 않습니다 ([](https://datasheet.octopart.com/W25Q64BVSFIG-Winbond-datasheet-14152614.pdf#:~:text=As%20with%20the%20write%20and,BUSY%20bit%20is%20a%201))**. 이러한 다단계 보호 덕분에 UART 통신 충돌만으로 **우발적으로 Flash에 쓰기나 삭제가 발생할 확률은 극히 낮습니다**.

그러나 완전히 배제할 수는 없습니다. 만약 **노이즈나 프로토콜 오류로 잘못된 바이트 시퀀스**가 Flash로 전달되어 하필 **0x06(Write Enable)**과 **0x02/Page Program 또는 0x20/Sector Erase** 등에 해당하는 패턴이 잡힌다면, 이론적으로 Flash는 쓰기 동작을 수행할 수도 있습니다. **특히 WP 핀이 활성(low)되지 않고, 소프트웨어적으로도 모든 영역이 보호되지 않은 상태**라면 이러한 우발적 명령을 100% 막을 수는 없습니다. 실제 Winbond Flash의 데이터시트에서도 **시스템에서 발생하는 노이즈나 예기치 않은 상황으로 인한 데이터 무결성 문제를 고려**해야 하며, 이를 대비해 **전원이 임계치 이하로 내려가면 내부 리셋**, **전원 투입 후 일정 시간 동안 자동으로 쓰기 비활성화**, **명령어 기반의 쓰기 활성/비활성 및 자동 쓰기 비활성화**, **하드웨어 WP 핀 및 소프트웨어 보호**, **일부 영역 잠금 기능** 등의 여러 보호 메커니즘을 제공한다고 명시하고 있습니다 ([W25Q32FV Datasheet](https://media.digikey.com/pdf/Data%20Sheets/Winbond%20PDFs/W25Q32FV.pdf#:~:text=6,write%20disable%20after%20erase%20or)). 이러한 보호장치들 (예: 전원 켜짐 시 **일시적인 쓰기 금지**, WEL 초기값 0, 명령어 수준의 쓰기 활성화 요구, **WP 핀을 통한 하드웨어 잠금**) 덕분에, **아무 보호도 없이 사용하는 상황에서도 웬만해선 잘못된 명령이 Flash 데이터를 지우거나 쓰는 사태는 드물게 일어납니다.**

그래도 만일을 대비한다면:

- **WP 핀**을 사용 가능한 상태로 설계하고 필요시 활성화하여 **중요한 섹터가 보호**되도록 하는 것,
    
- **Flash의 Status Register의 Block Protect 비트**를 설정해 **중요 데이터 영역을 상시 보호**하는 것,
    
- MCU 소프트웨어적으로는 **의도치 않은 쓰기 동작을 피하기 위해 Write Enable 명령을 남발하지 않고 필요한 시점에만 사용**하는 것 등이 있습니다. 이러한 대비책을 쓰면 **노이즈나 프로토콜 오류로 인한 의도치 않은 데이터 변조 위험**을 더욱 낮출 수 있습니다.
    

## 5. Flash 데이터 손상의 가능성이 있는 하드웨어/소프트웨어 시나리오들

앞서 언급한 사항들을 종합해볼 때, 현재 상황 자체만으로는 **SPI Flash의 내부 데이터가 손상되거나 Flash가 리셋(초기화)되는 일은 일반적으로 발생하지 않습니다.** 다만, 다음과 같은 시나리오는 주의해야 합니다:

- **전원 불안정**: MCU 부팅 시 전광판 등 주변 장치가 한꺼번에 켜지면서 **전원 공급이 순간적으로 불안정**해질 경우, Flash 메모리가 **정상 동작 전압 범위를 이탈**할 수 있습니다. Winbond Flash는 전원이 일정 임계치 이하로 떨어지면 내부적으로 리셋이 걸리도록 설계되어 있으며, 이 과정에서 진행 중이던 동작이 있었다면 문제가 될 수 있습니다 ([W25Q32FV Datasheet](https://media.digikey.com/pdf/Data%20Sheets/Winbond%20PDFs/W25Q32FV.pdf#:~:text=6,write%20disable%20after%20erase%20or)). 예를 들어 **프로그램/삭제 작업 도중 전원 강하나 리셋 명령으로 중단**되면 해당 메모리 셀의 데이터가 망가질 수 있다고 보고되어 있습니다 ([W25Q32JV Datasheet](https://www.mouser.com/datasheet/2/949/w25q32jv_revg_03272018_plus-1489806.pdf?srsltid=AfmBOopoBsRFo_x2znB-Top9CDqWg1yGL03Jr_bazmSbGlXZt3JCLIMK#:~:text=Data%20corruption%20may%20happen%20if,the%20BUSY%20bit%20and%20the)). 비록 지금 시나리오에서는 **읽기 작업만** 있지만, **전원 이슈로 예기치 않게 Flash가 리셋**되면 이후 첫 명령이 통하지 않는 등 오동작할 수 있으므로 **전원 안정을 위한 디커플링 캐패시터 확보, 전원 시퀀싱** 등이 필요합니다.
    
- **동시에 두 개의 SPI 액세스**: LPC4330은 코어가 둘(M4/M0)인데, 만약 두 코어가 동시 또는 엇갈려 SPI Flash에 접근하도록 잘못 프로그래밍된다면 **경합으로 인해 통신 오류**가 발생할 수 있습니다. 이런 경우도 Flash 자체 데이터가 망가지는 것보다는 **SPI 버스상의 충돌**로 읽기 실패나 잘못된 명령 수신 등이 생길 가능성이 큽니다. 해결책은 **SPI 버스 액세스에 대해 뮤텍스나 세마포어 등 동기화 기법을 적용**하여 한 번에 한 코어만 접근하게 하는 것입니다.
    
- **버그로 인한 잘못된 명령**: 소프트웨어 버그로 엉뚱한 SPI 명령이 나가거나, 잘못된 주소 영역에 쓰기 동작을 시도하는 경우 실제 데이터 손상이 있을 수 있습니다. 이때도 **Write Enable 관리**와 **영역 보호 설정**이 최후의 방어선이 되어줄 것입니다.
    
- **ESD/EMI 등의 외부 영향**: 키패드 연결선이나 UART 통신, 혹은 전광판 구동으로 인한 전자기 간섭이 SPI 라인에 유입되면, 아주 드물게 **스파이크 신호가 SPI 명령처럼 인식**될 수 있습니다. 앞서 말한 보호 메커니즘들(WEL 필요 등) 덕분에 간섭 하나로 바로 데이터가 지워지진 않겠지만, 반복적인 강한 노이즈는 누적 효과를 낼 수도 있으므로 **배선 차폐, 필터링** 등에 신경 써야 합니다.
    
- **지나치게 잦은 읽기와 수명**: 읽기 자체로 메모리 셀이 망가지는 일은 거의 없지만, **일부 메모리는 동일 셀을 매우 빈번히 읽을 경우 전하 트래핑 등 미세한 영향**을 받을 수 있다는 보고도 있습니다. W25Q32은 NOR Flash로서 NAND에 비해 읽기로 인한 소자는 문제 없지만, **지나치게 연속적인 읽기**를 장시간 지속하는 경우 **일시적인 발열이나 응답 지연** 정도는 고려해야 합니다. 그러나 이 역시 데이터 “손상”과는 거리가 있습니다.
    

종합하면, **현재 사용자가 겪고 있는 부팅 시 명령 반복 수신 현상은 주로 시간상의 경합과 Flash의 모드 상태 때문이지, Flash 메모리의 물리적 손상이나 데이터 손실 때문은 아닌 것으로 판단**됩니다. SPI Flash는 설계상 **읽기 동작만으로는 데이터가 지워지지 않도록 보호**되어 있고, **잘못된 명령 해독을 방지하는 여러 장치 ([](https://datasheet.octopart.com/W25Q64BVSFIG-Winbond-datasheet-14152614.pdf#:~:text=The%20Page%20Program%20instruction%20allows,must%20be%20held%20low%20for)) ([](https://datasheet.octopart.com/W25Q64BVSFIG-Winbond-datasheet-14152614.pdf#:~:text=As%20with%20the%20write%20and,BUSY%20bit%20is%20a%201))와 보호 기능 ([W25Q32FV Datasheet](https://media.digikey.com/pdf/Data%20Sheets/Winbond%20PDFs/W25Q32FV.pdf#:~:text=6,write%20disable%20after%20erase%20or))**을 갖추고 있습니다. 다만 **Continuous Read Mode 상태 유지**나 **동시 처리로 인한 일시적 읽기 실패**가 발생할 수 있으므로, **MCU 부팅 직후 Flash 모드 리셋 처리 ([](https://datasheet.octopart.com/W25Q64BVSFIG-Winbond-datasheet-14152614.pdf#:~:text=is%20recommended%20to%20issue%20a,%E2%80%9CAx%E2%80%9D%20hex%20state%20and%20allow))**, **명령 처리 시 동기화**, **필요시 쓰기 보호 활성화** 등의 조치를 취하면 안정성을 높일 수 있습니다.

**참고자료:** 연속 읽기 모드 관련 Winbond 데이터시트 조언 ([](https://datasheet.octopart.com/W25Q64BVSFIG-Winbond-datasheet-14152614.pdf#:~:text=If%20the%20system%20controller%20is,Reset%20instruction%20as%20the%20first)) ([](https://datasheet.octopart.com/W25Q64BVSFIG-Winbond-datasheet-14152614.pdf#:~:text=is%20recommended%20to%20issue%20a,%E2%80%9CAx%E2%80%9D%20hex%20state%20and%20allow)), Reset 타이밍과 데이터 변질에 대한 경고 ([W25Q32JV Datasheet](https://www.mouser.com/datasheet/2/949/w25q32jv_revg_03272018_plus-1489806.pdf?srsltid=AfmBOopoBsRFo_x2znB-Top9CDqWg1yGL03Jr_bazmSbGlXZt3JCLIMK#:~:text=Data%20corruption%20may%20happen%20if,the%20BUSY%20bit%20and%20the)), Flash 메모리 보호 메커니즘 (WEL, WP 등) ([](https://datasheet.octopart.com/W25Q64BVSFIG-Winbond-datasheet-14152614.pdf#:~:text=The%20Page%20Program%20instruction%20allows,must%20be%20held%20low%20for)) ([](https://datasheet.octopart.com/W25Q64BVSFIG-Winbond-datasheet-14152614.pdf#:~:text=As%20with%20the%20write%20and,BUSY%20bit%20is%20a%201)) ([W25Q32FV Datasheet](https://media.digikey.com/pdf/Data%20Sheets/Winbond%20PDFs/W25Q32FV.pdf#:~:text=6,write%20disable%20after%20erase%20or)), 읽기 동작의 안전성에 대한 논의 ([arduino - Flash memory corruption possible reasons? - Electrical Engineering Stack Exchange](https://electronics.stackexchange.com/questions/706697/flash-memory-corruption-possible-reasons#:~:text=Reading%20could%20corrupt%20the%20flash%2C,it%20is%20rated%20for%20reading)).