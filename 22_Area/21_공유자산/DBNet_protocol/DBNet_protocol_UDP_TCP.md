### UDP - Broad Cast 송신

| 0   | 'S'        |                                |
| --- | ---------- | ------------------------------ |
| 1   | 'E'        |                                |
| 2   | 'A'        |                                |
| 3   | 'R'        |                                |
| 4   | 'C'        |                                |
| 5   | 'H'        |                                |
| 6   | 'I'        |                                |
| 7   | 'N'        |                                |
| 8   | 'G'        |                                |
| 9   | 0x20       |                                |
| 10  | 'D'        |                                |
| 11  | 'I'        |                                |
| 12  | 'B'        |                                |
| 13  | 'D'        |                                |
| 14  | 0x20       |                                |
| 15  | 0x20       |                                |
| 16  | 'U' 또는 'B' | 'U': Unicast<br>'B': Broadcast |
| 17  | 0x0D       |                                |
| 18  | 0x0A       |                                |

### UDP/TCP

#### Set Data Request 송신 (0x88 질문)

| 0   | 'S'  | Command  |     |
| --- | ---- | -------- | --- |
| 1   | 'E'  | Command  |     |
| 2   | 'T'  | Command  |     |
| 3   | 'R'  | Command  |     |
| 4   | 0x20 | Space    |     |
| 5   | 0x20 | Space    |     |
| 6   | 'A'  | Mac Addr | 1   |
| 7   | 'B'  | Mac Addr | 2   |
| 8   | '-'  | Mac Addr | 3   |
| 9   | 'C'  | Mac Addr | 4   |
| 10  | 'D'  | Mac Addr | 5   |
| 11  | '-'  | Mac Addr | 6   |
| 12  | 'E'  | Mac Addr | 7   |
| 13  | 'F'  | Mac Addr | 8   |
| 14  | '-'  | Mac Addr | 9   |
| 15  | 'G'  | Mac Addr | 10  |
| 16  | 'H'  | Mac Addr | 11  |
| 17  | '-'  | Mac Addr | 12  |
| 18  | 'I'  | Mac Addr | 13  |
| 19  | 'J'  | Mac Addr | 14  |
| 20  | '-'  | Mac Addr | 15  |
| 21  | 'K'  | Mac Addr | 16  |
| 22  | 'L'  | Mac Addr | 17  |
| 23  | 0x0D |          |     |
| 24  | 0x0A |          |     |
#### Broad Cast 수신 (0x88 응답)

| 0   | 'D'  | Command     |             |
| --- | ---- | ----------- | ----------- |
| 1   | 'I'  | Command     |             |
| 2   | 'B'  | Command     |             |
| 3   | 'D'  | Command     |             |
| 4   | 0x0d | \r          |             |
| 5   | 0x0a | \n          |             |
| 6   | 'A'  | Mac Addr    | 1           |
| 7   | 'B'  | Mac Addr    | 2           |
| 8   | '-'  | Mac Addr    | 3           |
| 9   | 'C'  | Mac Addr    | 4           |
| 10  | 'D'  | Mac Addr    | 5           |
| 11  | '-'  | Mac Addr    | 6           |
| 12  | 'E'  | Mac Addr    | 7           |
| 13  | 'F'  | Mac Addr    | 8           |
| 14  | '-'  | Mac Addr    | 9           |
| 15  | 'G'  | Mac Addr    | 10          |
| 16  | 'H'  | Mac Addr    | 11          |
| 17  | '-'  | Mac Addr    | 12          |
| 18  | 'I'  | Mac Addr    | 13          |
| 19  | 'J'  | Mac Addr    | 14          |
| 20  | '-'  | Mac Addr    | 15          |
| 21  | 'K'  | Mac Addr    | 16          |
| 22  | 'L'  | Mac Addr    | 17          |
| 23  | 0x0d | \r          |             |
| 24  | 0x0a | \n          |             |
| 25  | '1'  | Local IP    | 1           |
| 26  | '9'  | Local IP    | 2           |
| 27  | '2'  | Local IP    | 3           |
| 28  | '.'  | Local IP    | 4           |
| 29  | '1'  | Local IP    | 5           |
| 30  | '6'  | Local IP    | 6           |
| 31  | '8'  | Local IP    | 7           |
| 32  | '.'  | Local IP    | 8           |
| 33  | '0'  | Local IP    | 9           |
| 34  | '0'  | Local IP    | 10          |
| 35  | '0'  | Local IP    | 11          |
| 36  | '.'  | Local IP    | 12          |
| 37  | '0'  | Local IP    | 13          |
| 38  | '7'  | Local IP    | 14          |
| 39  | '4'  | Local IP    | 15          |
| 40  | 0x0d | \r          |             |
| 41  | 0x0a | \n          |             |
| 42  | '2'  | Subnet Mask | 1           |
| 43  | '5'  | Subnet Mask | 2           |
| 44  | '5'  | Subnet Mask | 3           |
| 45  | '.'  | Subnet Mask | 4           |
| 46  | '2'  | Subnet Mask | 5           |
| 47  | '5'  | Subnet Mask | 6           |
| 48  | '5'  | Subnet Mask | 7           |
| 49  | '.'  | Subnet Mask | 8           |
| 50  | '2'  | Subnet Mask | 9           |
| 51  | '5'  | Subnet Mask | 10          |
| 52  | '5'  | Subnet Mask | 11          |
| 53  | '.'  | Subnet Mask | 12          |
| 54  | '0'  | Subnet Mask | 13          |
| 55  | '0'  | Subnet Mask | 14          |
| 56  | '0'  | Subnet Mask | 15          |
| 57  | 0x0d | \r          |             |
| 58  | 0x0a | \n          |             |
| 59  | '1'  | Gateway IP  | 1           |
| 60  | '9'  | Gateway IP  | 2           |
| 61  | '2'  | Gateway IP  | 3           |
| 62  | '.'  | Gateway IP  | 4           |
| 63  | '1'  | Gateway IP  | 5           |
| 64  | '6'  | Gateway IP  | 6           |
| 65  | '8'  | Gateway IP  | 7           |
| 66  | '.'  | Gateway IP  | 8           |
| 67  | '0'  | Gateway IP  | 9           |
| 68  | '0'  | Gateway IP  | 10          |
| 69  | '0'  | Gateway IP  | 11          |
| 70  | '.'  | Gateway IP  | 12          |
| 71  | '0'  | Gateway IP  | 13          |
| 72  | '0'  | Gateway IP  | 14          |
| 73  | '1'  | Gateway IP  | 15          |
| 74  | 0x0d | \r          |             |
| 75  | 0x0a | \n          |             |
| 76  | '0'  | Port        | 1           |
| 77  | '6'  | Port        | 2           |
| 78  | '0'  | Port        | 3           |
| 79  | '0'  | Port        | 4           |
| 80  | '1'  | Port        | 5           |
| 81  | 0x0d | \r          |             |
| 82  | 0x0a | \n          |             |
| 83  | '3'  | DHCP Mode   | '0': Static |
| 84  | '0'  | DHCP Mode   | '1': DHCP   |
| 85  | 0x0d | \r          |             |
| 86  | 0x0a | \n          |             |
| 87  | '1'  | Server IP   | 1           |
| 88  | '9'  | Server IP   | 2           |
| 89  | '2'  | Server IP   | 3           |
| 90  | '.'  | Server IP   | 4           |
| 91  | '1'  | Server IP   | 5           |
| 92  | '6'  | Server IP   | 6           |
| 93  | '8'  | Server IP   | 7           |
| 94  | '.'  | Server IP   | 8           |
| 95  | '0'  | Server IP   | 9           |
| 96  | '0'  | Server IP   | 10          |
| 97  | '0'  | Server IP   | 11          |
| 98  | '.'  | Server IP   | 12          |
| 99  | '0'  | Server IP   | 13          |
| 100 | '0'  | Server IP   | 14          |
| 101 | '0'  | Server IP   | 15          |
| 102 | 0x0d | \r          |             |
| 103 | 0x0a | \n          |             |
| 104 | '0'  | Server Port | 1           |
| 105 | '0'  | Server Port | 2           |
| 106 | '0'  | Server Port | 3           |
| 107 | '0'  | Server Port | 4           |
| 108 | '0'  | Server Port | 5           |
| 109 | 0x0d | \r          |             |
| 110 | 0x0a | \n          |             |
| 111 | '3'  | Server Mode | '0': Client |
| 112 | '0'  | Server Mode | '1': Server |
| 113 | 0x0d | \r          |             |
| 114 | 0x0a | \n          |             |
| 115 | '0'  | Name        | 1           |
| 116 | '0'  | Name        | 2           |
| 117 | '0'  | Name        | 3           |
| 118 | '0'  | Name        | 4           |
| 119 | '0'  | Name        | 5           |
| 120 | '0'  | Name        | 6           |
| 121 | '0'  | Name        | 7           |
| 122 | '0'  | Name        | 8           |
| 123 | '0'  | Name        | 9           |
| 124 | '0'  | Name        | 10          |
| 125 | '0'  | Name        | 11          |
| 126 | '0'  | Name        | 12          |
| 127 | '0'  | Name        | 13          |
| 128 | '0'  | Name        | 14          |
| 129 | '0'  | Name        | 15          |
| 130 | '0'  | Name        | 16          |
| 131 | '0'  | Name        | 17          |
| 132 | '0'  | Name        | 18          |
| 133 | '0'  | Name        | 19          |
| 134 | '0'  | Name        | 20          |
| 135 | 0x0d | \r          |             |
| 136 | 0x0a | \n          |             |
| 137 | '0'  | KeepAlive   | 1           |
| 138 | '0'  | KeepAlive   | 2           |
| 139 | '0'  | KeepAlive   | 3           |
| 140 | 0x0d | \r          |             |
| 141 | 0x0a | \n          |             |
| 142 | '0'  | DNS Name    | 1           |
| 143 | '0'  | DNS Name    | 2           |
| 144 | '0'  | DNS Name    | 3           |
| 145 | '0'  | DNS Name    | 4           |
| 146 | '0'  | DNS Name    | 5           |
| 147 | '0'  | DNS Name    | 6           |
| 148 | '0'  | DNS Name    | 7           |
| 149 | '0'  | DNS Name    | 8           |
| 150 | '0'  | DNS Name    | 9           |
| 151 | '0'  | DNS Name    | 10          |
| 152 | '0'  | DNS Name    | 11          |
| 153 | '0'  | DNS Name    | 12          |
| 154 | '0'  | DNS Name    | 13          |
| 155 | '0'  | DNS Name    | 14          |
| 156 | '0'  | DNS Name    | 15          |
| 157 | '0'  | DNS Name    | 16          |
| 158 | '0'  | DNS Name    | 17          |
| 159 | '0'  | DNS Name    | 18          |
| 160 | '0'  | DNS Name    | 19          |
| 161 | '0'  | DNS Name    | 20          |
| 162 | '0'  | DNS Name    | 21          |
| 163 | '0'  | DNS Name    | 22          |
| 164 | '0'  | DNS Name    | 23          |
| 165 | '0'  | DNS Name    | 24          |
| 166 | '0'  | DNS Name    | 25          |
| 167 | '0'  | DNS Name    | 26          |
| 168 | '0'  | DNS Name    | 27          |
| 169 | '0'  | DNS Name    | 28          |
| 170 | '0'  | DNS Name    | 29          |
| 171 | '0'  | DNS Name    | 30          |
| 172 | 0x0d | \r          |             |
| 173 | 0x0a | \n          |             |
| 174 | '0'  | AP&SSID 이름  | 1           |
| 175 | '0'  | AP&SSID 이름  | 2           |
| 176 | '0'  | AP&SSID 이름  | 3           |
| 177 | '0'  | AP&SSID 이름  | 4           |
| 178 | '0'  | AP&SSID 이름  | 5           |
| 179 | '0'  | AP&SSID 이름  | 6           |
| 180 | '0'  | AP&SSID 이름  | 7           |
| 181 | '0'  | AP&SSID 이름  | 8           |
| 182 | '0'  | AP&SSID 이름  | 9           |
| 183 | '0'  | AP&SSID 이름  | 10          |
| 184 | '0'  | AP&SSID 이름  | 11          |
| 185 | '0'  | AP&SSID 이름  | 12          |
| 186 | '0'  | AP&SSID 이름  | 13          |
| 187 | '0'  | AP&SSID 이름  | 14          |
| 188 | '0'  | AP&SSID 이름  | 15          |
| 189 | '0'  | AP&SSID 이름  | 16          |
| 190 | '0'  | AP&SSID 이름  | 17          |
| 191 | '0'  | AP&SSID 이름  | 18          |
| 192 | '0'  | AP&SSID 이름  | 19          |
| 193 | '0'  | AP&SSID 이름  | 20          |
| 194 | 0x0d | \r          |             |
| 195 | 0x0a | \n          |             |
| 196 | '0'  | AP&SSID 비번  | 1           |
| 197 | '0'  | AP&SSID 비번  | 2           |
| 198 | '0'  | AP&SSID 비번  | 3           |
| 199 | '0'  | AP&SSID 비번  | 4           |
| 200 | '0'  | AP&SSID 비번  | 5           |
| 201 | '0'  | AP&SSID 비번  | 6           |
| 202 | '0'  | AP&SSID 비번  | 7           |
| 203 | '0'  | AP&SSID 비번  | 8           |
| 204 | '0'  | AP&SSID 비번  | 9           |
| 205 | '0'  | AP&SSID 비번  | 10          |
| 206 | '0'  | AP&SSID 비번  | 11          |
| 207 | '0'  | AP&SSID 비번  | 12          |
| 208 | '0'  | AP&SSID 비번  | 13          |
| 209 | '0'  | AP&SSID 비번  | 14          |
| 210 | '0'  | AP&SSID 비번  | 15          |
| 211 | '0'  | AP&SSID 비번  | 16          |
| 212 | '0'  | AP&SSID 비번  | 17          |
| 213 | '0'  | AP&SSID 비번  | 18          |
| 214 | '0'  | AP&SSID 비번  | 19          |
| 215 | '0'  | AP&SSID 비번  | 20          |
| 216 | 0x0d | \r          |             |
| 217 | 0x0a | \n          |             |
| 218 | '3'  | AP&State모드  | '0': State  |
| 219 | '0'  | AP&State모드  | '1': AP     |
| 220 | 0x0d | \r          |             |
| 221 | 0x0a | \n          |             |

#### Broad Cast Setting 송신(0x89)

| 0   | 'S'  | Command     |             |
| --- | ---- | ----------- | ----------- |
| 1   | 'E'  | Command     |             |
| 2   | 'T'  | Command     |             |
| 3   | 'T'  | Command     |             |
| 4   | 0x20 | Space       |             |
| 5   | 0x20 | Space       |             |
| 6   | 'A'  | Mac Addr    | 1           |
| 7   | 'B'  | Mac Addr    | 2           |
| 8   | '-'  | Mac Addr    | 3           |
| 9   | 'C'  | Mac Addr    | 4           |
| 10  | 'D'  | Mac Addr    | 5           |
| 11  | '-'  | Mac Addr    | 6           |
| 12  | 'E'  | Mac Addr    | 7           |
| 13  | 'F'  | Mac Addr    | 8           |
| 14  | '-'  | Mac Addr    | 9           |
| 15  | 'G'  | Mac Addr    | 10          |
| 16  | 'H'  | Mac Addr    | 11          |
| 17  | '-'  | Mac Addr    | 12          |
| 18  | 'I'  | Mac Addr    | 13          |
| 19  | 'J'  | Mac Addr    | 14          |
| 20  | '-'  | Mac Addr    | 15          |
| 21  | 'K'  | Mac Addr    | 16          |
| 22  | 'L'  | Mac Addr    | 17          |
| 23  | 0x20 | Space       |             |
| 24  | 0x20 | Space       |             |
| 25  | '1'  | Local IP    | 1           |
| 26  | '9'  | Local IP    | 2           |
| 27  | '2'  | Local IP    | 3           |
| 28  | '.'  | Local IP    | 4           |
| 29  | '1'  | Local IP    | 5           |
| 30  | '6'  | Local IP    | 6           |
| 31  | '8'  | Local IP    | 7           |
| 32  | '.'  | Local IP    | 8           |
| 33  | '0'  | Local IP    | 9           |
| 34  | '0'  | Local IP    | 10          |
| 35  | '0'  | Local IP    | 11          |
| 36  | '.'  | Local IP    | 12          |
| 37  | '0'  | Local IP    | 13          |
| 38  | '7'  | Local IP    | 14          |
| 39  | '4'  | Local IP    | 15          |
| 40  | 0x20 | Space       |             |
| 41  | 0x20 | Space       |             |
| 42  | '2'  | Subnet Mask | 1           |
| 43  | '5'  | Subnet Mask | 2           |
| 44  | '5'  | Subnet Mask | 3           |
| 45  | '.'  | Subnet Mask | 4           |
| 46  | '2'  | Subnet Mask | 5           |
| 47  | '5'  | Subnet Mask | 6           |
| 48  | '5'  | Subnet Mask | 7           |
| 49  | '.'  | Subnet Mask | 8           |
| 50  | '2'  | Subnet Mask | 9           |
| 51  | '5'  | Subnet Mask | 10          |
| 52  | '5'  | Subnet Mask | 11          |
| 53  | '.'  | Subnet Mask | 12          |
| 54  | '0'  | Subnet Mask | 13          |
| 55  | '0'  | Subnet Mask | 14          |
| 56  | '0'  | Subnet Mask | 15          |
| 57  | 0x20 | Space       |             |
| 58  | 0x20 | Space       |             |
| 59  | '1'  | Gateway IP  | 1           |
| 60  | '9'  | Gateway IP  | 2           |
| 61  | '2'  | Gateway IP  | 3           |
| 62  | '.'  | Gateway IP  | 4           |
| 63  | '1'  | Gateway IP  | 5           |
| 64  | '6'  | Gateway IP  | 6           |
| 65  | '8'  | Gateway IP  | 7           |
| 66  | '.'  | Gateway IP  | 8           |
| 67  | '0'  | Gateway IP  | 9           |
| 68  | '0'  | Gateway IP  | 10          |
| 69  | '0'  | Gateway IP  | 11          |
| 70  | '.'  | Gateway IP  | 12          |
| 71  | '0'  | Gateway IP  | 13          |
| 72  | '0'  | Gateway IP  | 14          |
| 73  | '1'  | Gateway IP  | 15          |
| 74  | 0x20 | Space       |             |
| 75  | 0x20 | Space       |             |
| 76  | '0'  | Port        | 1           |
| 77  | '6'  | Port        | 2           |
| 78  | '0'  | Port        | 3           |
| 79  | '0'  | Port        | 4           |
| 80  | '1'  | Port        | 5           |
| 81  | 0x20 | Space       |             |
| 82  | 0x20 | Space       |             |
| 83  | '3'  | DHCP Mode   | '0': Static |
| 84  | '0'  | DHCP Mode   | '1': DHCP   |
| 85  | 0x20 | Space       |             |
| 86  | 0x20 | Space       |             |
| 87  | '1'  | Server IP   | 1           |
| 88  | '9'  | Server IP   | 2           |
| 89  | '2'  | Server IP   | 3           |
| 90  | '.'  | Server IP   | 4           |
| 91  | '1'  | Server IP   | 5           |
| 92  | '6'  | Server IP   | 6           |
| 93  | '8'  | Server IP   | 7           |
| 94  | '.'  | Server IP   | 8           |
| 95  | '0'  | Server IP   | 9           |
| 96  | '0'  | Server IP   | 10          |
| 97  | '0'  | Server IP   | 11          |
| 98  | '.'  | Server IP   | 12          |
| 99  | '0'  | Server IP   | 13          |
| 100 | '0'  | Server IP   | 14          |
| 101 | '0'  | Server IP   | 15          |
| 102 | 0x20 | Space       |             |
| 103 | 0x20 | Space       |             |
| 104 | '0'  | Server Port | 1           |
| 105 | '0'  | Server Port | 2           |
| 106 | '0'  | Server Port | 3           |
| 107 | '0'  | Server Port | 4           |
| 108 | '0'  | Server Port | 5           |
| 109 | 0x20 | Space       |             |
| 110 | 0x20 | Space       |             |
| 111 | '3'  | Server Mode | '0': Client |
| 112 | '0'  | Server Mode | '1': Server |
| 113 | 0x20 | Space       |             |
| 114 | 0x20 | Space       |             |
| 115 | '0'  | Name        | 1           |
| 116 | '0'  | Name        | 2           |
| 117 | '0'  | Name        | 3           |
| 118 | '0'  | Name        | 4           |
| 119 | '0'  | Name        | 5           |
| 120 | '0'  | Name        | 6           |
| 121 | '0'  | Name        | 7           |
| 122 | '0'  | Name        | 8           |
| 123 | '0'  | Name        | 9           |
| 124 | '0'  | Name        | 10          |
| 125 | '0'  | Name        | 11          |
| 126 | '0'  | Name        | 12          |
| 127 | '0'  | Name        | 13          |
| 128 | '0'  | Name        | 14          |
| 129 | '0'  | Name        | 15          |
| 130 | '0'  | Name        | 16          |
| 131 | '0'  | Name        | 17          |
| 132 | '0'  | Name        | 18          |
| 133 | '0'  | Name        | 19          |
| 134 | '0'  | Name        | 20          |
| 135 | 0x20 | Space       |             |
| 136 | 0x20 | Space       |             |
| 137 | '0'  | KeepAlive   | 1           |
| 138 | '0'  | KeepAlive   | 2           |
| 139 | '0'  | KeepAlive   | 3           |
| 140 | 0x20 | Space       |             |
| 141 | 0x20 | Space       |             |
| 142 | '0'  | DNS Name    | 1           |
| 143 | '0'  | DNS Name    | 2           |
| 144 | '0'  | DNS Name    | 3           |
| 145 | '0'  | DNS Name    | 4           |
| 146 | '0'  | DNS Name    | 5           |
| 147 | '0'  | DNS Name    | 6           |
| 148 | '0'  | DNS Name    | 7           |
| 149 | '0'  | DNS Name    | 8           |
| 150 | '0'  | DNS Name    | 9           |
| 151 | '0'  | DNS Name    | 10          |
| 152 | '0'  | DNS Name    | 11          |
| 153 | '0'  | DNS Name    | 12          |
| 154 | '0'  | DNS Name    | 13          |
| 155 | '0'  | DNS Name    | 14          |
| 156 | '0'  | DNS Name    | 15          |
| 157 | '0'  | DNS Name    | 16          |
| 158 | '0'  | DNS Name    | 17          |
| 159 | '0'  | DNS Name    | 18          |
| 160 | '0'  | DNS Name    | 19          |
| 161 | '0'  | DNS Name    | 20          |
| 162 | '0'  | DNS Name    | 21          |
| 163 | '0'  | DNS Name    | 22          |
| 164 | '0'  | DNS Name    | 23          |
| 165 | '0'  | DNS Name    | 24          |
| 166 | '0'  | DNS Name    | 25          |
| 167 | '0'  | DNS Name    | 26          |
| 168 | '0'  | DNS Name    | 27          |
| 169 | '0'  | DNS Name    | 28          |
| 170 | '0'  | DNS Name    | 29          |
| 171 | '0'  | DNS Name    | 30          |
| 172 | 0x20 | Space       |             |
| 173 | 0x20 | Space       |             |
| 174 | '0'  | AP&SSID 이름  | 1           |
| 175 | '0'  | AP&SSID 이름  | 2           |
| 176 | '0'  | AP&SSID 이름  | 3           |
| 177 | '0'  | AP&SSID 이름  | 4           |
| 178 | '0'  | AP&SSID 이름  | 5           |
| 179 | '0'  | AP&SSID 이름  | 6           |
| 180 | '0'  | AP&SSID 이름  | 7           |
| 181 | '0'  | AP&SSID 이름  | 8           |
| 182 | '0'  | AP&SSID 이름  | 9           |
| 183 | '0'  | AP&SSID 이름  | 10          |
| 184 | '0'  | AP&SSID 이름  | 11          |
| 185 | '0'  | AP&SSID 이름  | 12          |
| 186 | '0'  | AP&SSID 이름  | 13          |
| 187 | '0'  | AP&SSID 이름  | 14          |
| 188 | '0'  | AP&SSID 이름  | 15          |
| 189 | '0'  | AP&SSID 이름  | 16          |
| 190 | '0'  | AP&SSID 이름  | 17          |
| 191 | '0'  | AP&SSID 이름  | 18          |
| 192 | '0'  | AP&SSID 이름  | 19          |
| 193 | '0'  | AP&SSID 이름  | 20          |
| 194 | 0x20 | Space       |             |
| 195 | 0x20 | Space       |             |
| 196 | '0'  | AP&SSID 비번  | 1           |
| 197 | '0'  | AP&SSID 비번  | 2           |
| 198 | '0'  | AP&SSID 비번  | 3           |
| 199 | '0'  | AP&SSID 비번  | 4           |
| 200 | '0'  | AP&SSID 비번  | 5           |
| 201 | '0'  | AP&SSID 비번  | 6           |
| 202 | '0'  | AP&SSID 비번  | 7           |
| 203 | '0'  | AP&SSID 비번  | 8           |
| 204 | '0'  | AP&SSID 비번  | 9           |
| 205 | '0'  | AP&SSID 비번  | 10          |
| 206 | '0'  | AP&SSID 비번  | 11          |
| 207 | '0'  | AP&SSID 비번  | 12          |
| 208 | '0'  | AP&SSID 비번  | 13          |
| 209 | '0'  | AP&SSID 비번  | 14          |
| 210 | '0'  | AP&SSID 비번  | 15          |
| 211 | '0'  | AP&SSID 비번  | 16          |
| 212 | '0'  | AP&SSID 비번  | 17          |
| 213 | '0'  | AP&SSID 비번  | 18          |
| 214 | '0'  | AP&SSID 비번  | 19          |
| 215 | '0'  | AP&SSID 비번  | 20          |
| 216 | 0x20 | Space       |             |
| 217 | 0x20 | Space       |             |
| 218 | '3'  | AP&State모드  | '0': State  |
| 219 | '0'  | AP&State모드  | '1': AP     |
| 220 | 0x0d | \r          |             |
| 221 | 0x0a | \n          |             |
#### 선택한 맥어드레스 리셋(0x8A)

| 0   | 'R'  | Command  |     |
| --- | ---- | -------- | --- |
| 1   | 'E'  | Command  |     |
| 2   | 'S'  | Command  |     |
| 3   | 'E'  | Command  |     |
| 4   | 'T'  | Command  |     |
| 5   | 0x20 | Space    |     |
| 6   | 0x20 | Space    |     |
| 7   | 'A'  | Mac Addr | 1   |
| 8   | 'B'  | Mac Addr | 2   |
| 9   | '-'  | Mac Addr | 3   |
| 10  | 'C'  | Mac Addr | 4   |
| 11  | 'D'  | Mac Addr | 5   |
| 12  | '-'  | Mac Addr | 6   |
| 13  | 'E'  | Mac Addr | 7   |
| 14  | 'F'  | Mac Addr | 8   |
| 15  | '-'  | Mac Addr | 9   |
| 16  | 'G'  | Mac Addr | 10  |
| 17  | 'H'  | Mac Addr | 11  |
| 18  | '-'  | Mac Addr | 12  |
| 19  | 'I'  | Mac Addr | 13  |
| 20  | 'J'  | Mac Addr | 14  |
| 21  | '-'  | Mac Addr | 15  |
| 22  | 'K'  | Mac Addr | 16  |
| 23  | 'L'  | Mac Addr | 17  |
| 24  | 0x0d | \r       |     |
| 25  | 0x0a | \n       |     |
