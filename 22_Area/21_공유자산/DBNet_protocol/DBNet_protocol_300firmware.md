### 펌웨어정보 Write 송신 (0x8B)

| 0   | 'I'  | Command                |     |
| --- | ---- | ---------------------- | --- |
| 1   | 'N'  | Command                |     |
| 2   | 'F'  | Command                |     |
| 3   | 'O'  | Command                |     |
| 4   | '_'  | Command                |     |
| 5   | 'W'  | Command                |     |
| 6   | 0x20 | Space                  |     |
| 7   | 0x20 | Space                  |     |
| 8   | 'A'  | Mac Addr               | 1   |
| 9   | 'B'  | Mac Addr               | 2   |
| 10  | '-'  | Mac Addr               | 3   |
| 11  | 'C'  | Mac Addr               | 4   |
| 12  | 'D'  | Mac Addr               | 5   |
| 13  | '-'  | Mac Addr               | 6   |
| 14  | 'E'  | Mac Addr               | 7   |
| 15  | 'F'  | Mac Addr               | 8   |
| 16  | '-'  | Mac Addr               | 9   |
| 17  | 'G'  | Mac Addr               | 10  |
| 18  | 'H'  | Mac Addr               | 11  |
| 19  | '-'  | Mac Addr               | 12  |
| 20  | 'I'  | Mac Addr               | 13  |
| 21  | 'J'  | Mac Addr               | 14  |
| 22  | '-'  | Mac Addr               | 15  |
| 23  | 'K'  | Mac Addr               | 16  |
| 24  | 'L'  | Mac Addr               | 17  |
| 25  | 0x20 | Space                  |     |
| 26  | 0x20 | Space                  |     |
| 27  | 1    | Debugging State        | 1   |
| 28  | 0    | Device Connection Port | 2   |
| 29  | 4    | Device Baudrate        | 3   |
| 30  | !    | 1st End Text(ascii)    | 4   |
| 31  | ]    | 2nd End Text(ascii)    | 5   |
| 32  | 1    | 1st End Text(hex)      | 6   |
| 33  | 0    | 1st End Text(hex)      | 7   |
| 34  | 0    | 2nd End Text(hex)      | 8   |
| 35  | 3    | 2nd End Text(hex)      | 9   |
| 36  | 0    | Time(ms)               | 10  |
| 37  | 1    | Time(ms)               | 11  |
| 38  | 0    | Time(ms)               | 12  |
| 39  |      | NC1                    | 13  |
| 40  |      | NC2                    | 14  |
| 41  |      | NC3                    | 15  |
| 42  |      | NC4                    | 16  |
| 43  |      | NC5                    | 17  |
| 44  |      | NC6                    | 18  |
| 45  | 0x0d | \r                     |     |
| 46  | 0x0a | \n                     |     |
### 펌웨어 정보 READ 송신 (0x8C)

| 0   | 'I'  | Command  |     |
| --- | ---- | -------- | --- |
| 1   | 'N'  | Command  |     |
| 2   | 'F'  | Command  |     |
| 3   | 'O'  | Command  |     |
| 4   | '_'  | Command  |     |
| 5   | 'R'  | Command  |     |
| 6   | 0x20 | Space    |     |
| 7   | 0x20 | Space    |     |
| 8   | 'A'  | Mac Addr | 1   |
| 9   | 'B'  | Mac Addr | 2   |
| 10  | '-'  | Mac Addr | 3   |
| 11  | 'C'  | Mac Addr | 4   |
| 12  | 'D'  | Mac Addr | 5   |
| 13  | '-'  | Mac Addr | 6   |
| 14  | 'E'  | Mac Addr | 7   |
| 15  | 'F'  | Mac Addr | 8   |
| 16  | '-'  | Mac Addr | 9   |
| 17  | 'G'  | Mac Addr | 10  |
| 18  | 'H'  | Mac Addr | 11  |
| 19  | '-'  | Mac Addr | 12  |
| 20  | 'I'  | Mac Addr | 13  |
| 21  | 'J'  | Mac Addr | 14  |
| 22  | '-'  | Mac Addr | 15  |
| 23  | 'K'  | Mac Addr | 16  |
| 24  | 'L'  | Mac Addr | 17  |
| 25  | 0x0d | \r       |     |
| 26  | 0x0a | \n       |     |
### 펌웨어 정보 READ 수신 (0x8C)

| 0   | 'I'  | Command                |     |
| --- | ---- | ---------------------- | --- |
| 1   | 'N'  | Command                |     |
| 2   | 'F'  | Command                |     |
| 3   | 'O'  | Command                |     |
| 4   | '_'  | Command                |     |
| 5   | 'R'  | Command                |     |
| 6   | 0x0d | \r                     |     |
| 7   | 0x0a | \n                     |     |
| 8   | 'A'  | Mac Addr               | 1   |
| 9   | 'B'  | Mac Addr               | 2   |
| 10  | '-'  | Mac Addr               | 3   |
| 11  | 'C'  | Mac Addr               | 4   |
| 12  | 'D'  | Mac Addr               | 5   |
| 13  | '-'  | Mac Addr               | 6   |
| 14  | 'E'  | Mac Addr               | 7   |
| 15  | 'F'  | Mac Addr               | 8   |
| 16  | '-'  | Mac Addr               | 9   |
| 17  | 'G'  | Mac Addr               | 10  |
| 18  | 'H'  | Mac Addr               | 11  |
| 19  | '-'  | Mac Addr               | 12  |
| 20  | 'I'  | Mac Addr               | 13  |
| 21  | 'J'  | Mac Addr               | 14  |
| 22  | '-'  | Mac Addr               | 15  |
| 23  | 'K'  | Mac Addr               | 16  |
| 24  | 'L'  | Mac Addr               | 17  |
| 25  | 0x0d | \r                     |     |
| 26  | 0x0a | \n                     |     |
| 27  | 'E'  | Debugging State        | 1   |
| 28  | '0'  | Device Connection Port | 2   |
| 29  | '4'  | Device Baudrate        | 3   |
| 30  | '!'  | 1st End Text(ascii)    | 4   |
| 31  | ']'  | 2nd End Text(ascii)    | 5   |
| 32  | '1'  | 1st End Text(hex)      | 6   |
| 33  | '0'  | 1st End Text(hex)      | 7   |
| 34  | '0'  | 2nd End Text(hex)      | 8   |
| 35  | '3'  | 2nd End Text(hex)      | 9   |
| 36  | '0'  | Time(ms)               | 10  |
| 37  | '1'  | Time(ms)               | 11  |
| 38  | '0'  | Time(ms)               | 12  |
| 39  |      | NC1                    | 13  |
| 40  |      | NC2                    | 14  |
| 41  |      | NC3                    | 15  |
| 42  |      | NC4                    | 16  |
| 43  |      | NC5                    | 17  |
| 44  |      | NC6                    | 18  |
| 45  | 0x0d | \r                     |     |
| 46  | 0x0a | \n                     |     |
| 47  | 'E'  | Ethernet('E'/' ')      | 1   |
| 48  | 'W'  | WIFI('W'/' ')          | 2   |
| 49  | 'B'  | Bluetooth('B'/' ')     | 3   |
| 50  |      |                        | 4   |
| 51  | 'V'  | Version                | 5   |
| 52  | '0'  | Version                | 6   |
| 53  | '4'  | Version                | 7   |
| 54  | '.'  | Version                | 8   |
| 55  | '3'  | Version                | 9   |
| 56  | '0'  | Version                | 10  |
| 57  |      |                        | 11  |
| 58  | '2'  | YYYY-MM-DD             | 12  |
| 59  | '0'  | YYYY-MM-DD             | 13  |
| 60  | '2'  | YYYY-MM-DD             | 14  |
| 61  | '2'  | YYYY-MM-DD             | 15  |
| 62  | '-'  | YYYY-MM-DD             | 16  |
| 63  | '1'  | YYYY-MM-DD             | 17  |
| 64  | '2'  | YYYY-MM-DD             | 18  |
| 65  | '-'  | YYYY-MM-DD             | 19  |
| 66  | '0'  | YYYY-MM-DD             | 20  |
| 67  | '9'  | YYYY-MM-DD             | 21  |
| 68  | 0x0d | \r                     |     |
| 69  | 0x0a | \n                     |     |


|     | **Device Connection Port** |
| --- | -------------------------- |
| 값   | 설정                         |
| 0   | TTL                        |
| 1   | RS232                      |

|     | **Debugging State**    |
| --- | ---------------------- |
| 값   | 설정                     |
| 0   | Disable                |
| 1   | Enable                 |

|     | **RS232/TTL Baudrate** |
| --- | ---------------------- |
| 값   | Baudrate               |
| 0   | 9600                   |
| 1   | 19200                  |
| 2   | 38400                  |
| 3   | 57600                  |
| 4   | 115200                 |
| 5   | 230400                 |
| 6   | 460800                 |
| 7   | 921600                 |
