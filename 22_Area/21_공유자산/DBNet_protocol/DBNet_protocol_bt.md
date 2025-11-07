### Broad Cast 송신

| 0   | 'B'  | Command |     |
| --- | ---- | ------- | --- |
| 1   | 'T'  | Command |     |
| 2   | 0x20 | Space   |     |
| 3   | 'S'  | Command |     |
| 4   | 'E'  | Command |     |
| 5   | 'A'  | Command |     |
| 6   | 'R'  | Command |     |
| 7   | 'C'  | Command |     |
| 8   | 'H'  | Command |     |
| 9   | 'I'  | Command |     |
| 10  | 'N'  | Command |     |
| 11  | 'G'  | Command |     |
| 12  | 0x20 | Space   |     |
| 13  | 'D'  | Command |     |
| 14  | 'I'  | Command |     |
| 15  | 'B'  | Command |     |
| 16  | 'D'  | Command |     |
| 25  | 0x0d | \r      |     |
| 26  | 0x0a | \n      |     |
### Broad Cast 수신

| 0   | 'B'  | Command             |                |     |
| --- | ---- | ------------------- | -------------- | --- |
| 1   | 'T'  | Command             |                |     |
| 2   | 0x20 | Command             |                |     |
| 3   | 'D'  | Command             |                |     |
| 4   | 'I'  | Command             |                |     |
| 5   | 'B'  | Command             |                |     |
| 6   | 'D'  | Command             |                |     |
| 7   | 0x0d | \r                  |                |     |
| 8   | 0x0a | \n                  |                |     |
| 9   | '3'  | Wifi & Bluetooth 모드 | '0': Wifi      | 0   |
| 10  | '0'  | Wifi & Bluetooth 모드 | '1': Bluetooth | 1   |
| 11  | 0x0d | \r                  |                | 2   |
| 12  | 0x0a | \n                  |                | 3   |
| 13  | '0'  | Bluetooth 이름        | 0              | 4   |
| 14  | '0'  | Bluetooth 이름        | 1              | 5   |
| 15  | '0'  | Bluetooth 이름        | 2              | 6   |
| 16  | '0'  | Bluetooth 이름        | 3              | 7   |
| 17  | '0'  | Bluetooth 이름        | 4              | 8   |
| 18  | '0'  | Bluetooth 이름        | 5              | 9   |
| 19  | '0'  | Bluetooth 이름        | 6              | 10  |
| 20  | '0'  | Bluetooth 이름        | 7              | 11  |
| 21  | '0'  | Bluetooth 이름        | 8              | 12  |
| 22  | '0'  | Bluetooth 이름        | 9              | 13  |
| 23  | '0'  | Bluetooth 이름        | 10             | 14  |
| 24  | '0'  | Bluetooth 이름        | 11             | 15  |
| 25  | '0'  | Bluetooth 이름        | 12             | 16  |
| 26  | '0'  | Bluetooth 이름        | 13             | 17  |
| 27  | '0'  | Bluetooth 이름        | 14             | 18  |
| 28  | '0'  | Bluetooth 이름        | 15             | 19  |
| 29  | '0'  | Bluetooth 이름        | 16             | 20  |
| 30  | '0'  | Bluetooth 이름        | 17             | 21  |
| 31  | '0'  | Bluetooth 이름        | 18             | 22  |
| 32  | '0'  | Bluetooth 이름        | 19             | 23  |
| 33  | 0x0d | \r                  |                | 24  |
| 34  | 0x0a | \n                  |                | 25  |
| 35  | '0'  | Bluetooth 비번        | 0              | 26  |
| 36  | '0'  | Bluetooth 비번        | 1              | 27  |
| 37  | '0'  | Bluetooth 비번        | 2              | 28  |
| 38  | '0'  | Bluetooth 비번        | 3              | 29  |
| 39  | '0'  | Bluetooth 비번        | 4              | 30  |
| 40  | '0'  | Bluetooth 비번        | 5              | 31  |
| 41  | '0'  | Bluetooth 비번        | 6              | 32  |
| 42  | '0'  | Bluetooth 비번        | 7              | 33  |
| 43  | '0'  | Bluetooth 비번        | 8              | 34  |
| 44  | '0'  | Bluetooth 비번        | 9              | 35  |
| 45  | '0'  | Bluetooth 비번        | 10             | 36  |
| 46  | '0'  | Bluetooth 비번        | 11             | 37  |
| 47  | '0'  | Bluetooth 비번        | 12             | 38  |
| 48  | '0'  | Bluetooth 비번        | 13             | 39  |
| 49  | '0'  | Bluetooth 비번        | 14             | 40  |
| 50  | '0'  | Bluetooth 비번        | 15             | 41  |
| 51  | '0'  | Bluetooth 비번        | 16             | 42  |
| 52  | '0'  | Bluetooth 비번        | 17             | 43  |
| 53  | '0'  | Bluetooth 비번        | 18             | 44  |
| 54  | '0'  | Bluetooth 비번        | 19             | 45  |
| 55  | 0x0d | \r                  |                | 46  |
| 56  | 0x0a | \n                  |                | 47  |
### Broad Cast Setting 송신

| 0   | 'B'  | Command             |                |     |
| --- | ---- | ------------------- | -------------- | --- |
| 1   | 'T'  | Command             |                |     |
| 2   | 0x20 | Command             |                |     |
| 3   | 'S'  | Command             |                |     |
| 4   | 'E'  | Command             |                |     |
| 5   | 'T'  | Command             |                |     |
| 6   | 'T'  | Command             |                |     |
| 7   | 0x20 | Space               |                |     |
| 8   | 0x20 | Space               |                |     |
| 9   | '3'  | Wifi & Bluetooth 모드 | '0': Wifi      | 0   |
| 10  | '0'  | Wifi & Bluetooth 모드 | '1': Bluetooth | 1   |
| 11  | 0x20 | Space               |                | 2   |
| 12  | 0x20 | Space               |                | 3   |
| 13  | '0'  | Bluetooth 이름        | 0              | 4   |
| 14  | '0'  | Bluetooth 이름        | 1              | 5   |
| 15  | '0'  | Bluetooth 이름        | 2              | 6   |
| 16  | '0'  | Bluetooth 이름        | 3              | 7   |
| 17  | '0'  | Bluetooth 이름        | 4              | 8   |
| 18  | '0'  | Bluetooth 이름        | 5              | 9   |
| 19  | '0'  | Bluetooth 이름        | 6              | 10  |
| 20  | '0'  | Bluetooth 이름        | 7              | 11  |
| 21  | '0'  | Bluetooth 이름        | 8              | 12  |
| 22  | '0'  | Bluetooth 이름        | 9              | 13  |
| 23  | '0'  | Bluetooth 이름        | 10             | 14  |
| 24  | '0'  | Bluetooth 이름        | 11             | 15  |
| 25  | '0'  | Bluetooth 이름        | 12             | 16  |
| 26  | '0'  | Bluetooth 이름        | 13             | 17  |
| 27  | '0'  | Bluetooth 이름        | 14             | 18  |
| 28  | '0'  | Bluetooth 이름        | 15             | 19  |
| 29  | '0'  | Bluetooth 이름        | 16             | 20  |
| 30  | '0'  | Bluetooth 이름        | 17             | 21  |
| 31  | '0'  | Bluetooth 이름        | 18             | 22  |
| 32  | '0'  | Bluetooth 이름        | 19             | 23  |
| 33  | 0x20 | Space               |                | 24  |
| 34  | 0x20 | Space               |                | 25  |
| 35  | '0'  | Bluetooth 비번        | 0              | 26  |
| 36  | '0'  | Bluetooth 비번        | 1              | 27  |
| 37  | '0'  | Bluetooth 비번        | 2              | 28  |
| 38  | '0'  | Bluetooth 비번        | 3              | 29  |
| 39  | '0'  | Bluetooth 비번        | 4              | 30  |
| 40  | '0'  | Bluetooth 비번        | 5              | 31  |
| 41  | '0'  | Bluetooth 비번        | 6              | 32  |
| 42  | '0'  | Bluetooth 비번        | 7              | 33  |
| 43  | '0'  | Bluetooth 비번        | 8              | 34  |
| 44  | '0'  | Bluetooth 비번        | 9              | 35  |
| 45  | '0'  | Bluetooth 비번        | 10             | 36  |
| 46  | '0'  | Bluetooth 비번        | 11             | 37  |
| 47  | '0'  | Bluetooth 비번        | 12             | 38  |
| 48  | '0'  | Bluetooth 비번        | 13             | 39  |
| 49  | '0'  | Bluetooth 비번        | 14             | 40  |
| 50  | '0'  | Bluetooth 비번        | 15             | 41  |
| 51  | '0'  | Bluetooth 비번        | 16             | 42  |
| 52  | '0'  | Bluetooth 비번        | 17             | 43  |
| 53  | '0'  | Bluetooth 비번        | 18             | 44  |
| 54  | '0'  | Bluetooth 비번        | 19             | 45  |
| 55  | 0x0d | \r                  |                | 46  |
| 56  | 0x0a | \n                  |                | 47  |
