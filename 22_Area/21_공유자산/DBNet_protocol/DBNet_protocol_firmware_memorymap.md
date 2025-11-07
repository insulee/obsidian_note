### EEPROM MEMORY MAP

|   0 | A'   | Mac Addr            | 1              |     |
| --: | :--- | :------------------ | :------------- | --- |
|   1 | B'   | Mac Addr            | 2              |     |
|   2 | -'   | Mac Addr            | 3              |     |
|   3 | C'   | Mac Addr            | 4              |     |
|   4 | D'   | Mac Addr            | 5              |     |
|   5 | -'   | Mac Addr            | 6              |     |
|   6 | E'   | Mac Addr            | 7              |     |
|   7 | F'   | Mac Addr            | 8              |     |
|   8 | -'   | Mac Addr            | 9              |     |
|   9 | G'   | Mac Addr            | 10             |     |
|  10 | H'   | Mac Addr            | 11             |     |
|  11 | -'   | Mac Addr            | 12             |     |
|  12 | I'   | Mac Addr            | 13             |     |
|  13 | J'   | Mac Addr            | 14             |     |
|  14 | -'   | Mac Addr            | 15             |     |
|  15 | K'   | Mac Addr            | 16             |     |
|  16 | L'   | Mac Addr            | 17             |     |
|  17 | 0x20 | Space               |                |     |
|  18 | 0x20 | Space               |                |     |
|  19 | 1'   | Local IP            | 1              |     |
|  20 | 9'   | Local IP            | 2              |     |
|  21 | 2'   | Local IP            | 3              |     |
|  22 | .'   | Local IP            | 4              |     |
|  23 | 1'   | Local IP            | 5              |     |
|  24 | 6'   | Local IP            | 6              |     |
|  25 | 8'   | Local IP            | 7              |     |
|  26 | .'   | Local IP            | 8              |     |
|  27 | 0'   | Local IP            | 9              |     |
|  28 | 0'   | Local IP            | 10             |     |
|  29 | 0'   | Local IP            | 11             |     |
|  30 | .'   | Local IP            | 12             |     |
|  31 | 0'   | Local IP            | 13             |     |
|  32 | 7'   | Local IP            | 14             |     |
|  33 | 4'   | Local IP            | 15             |     |
|  34 | 0x20 | Space               |                |     |
|  35 | 0x20 | Space               |                |     |
|  36 | 2'   | Subnet Mask         | 1              |     |
|  37 | 5'   | Subnet Mask         | 2              |     |
|  38 | 5'   | Subnet Mask         | 3              |     |
|  39 | .'   | Subnet Mask         | 4              |     |
|  40 | 2'   | Subnet Mask         | 5              |     |
|  41 | 5'   | Subnet Mask         | 6              |     |
|  42 | 5'   | Subnet Mask         | 7              |     |
|  43 | .'   | Subnet Mask         | 8              |     |
|  44 | 2'   | Subnet Mask         | 9              |     |
|  45 | 5'   | Subnet Mask         | 10             |     |
|  46 | 5'   | Subnet Mask         | 11             |     |
|  47 | .'   | Subnet Mask         | 12             |     |
|  48 | 0'   | Subnet Mask         | 13             |     |
|  49 | 0'   | Subnet Mask         | 14             |     |
|  50 | 0'   | Subnet Mask         | 15             |     |
|  51 | 0x20 | Space               |                |     |
|  52 | 0x20 | Space               |                |     |
|  53 | 1'   | Gateway IP          | 1              |     |
|  54 | 9'   | Gateway IP          | 2              |     |
|  55 | 2'   | Gateway IP          | 3              |     |
|  56 | .'   | Gateway IP          | 4              |     |
|  57 | 1'   | Gateway IP          | 5              |     |
|  58 | 6'   | Gateway IP          | 6              |     |
|  59 | 8'   | Gateway IP          | 7              |     |
|  60 | .'   | Gateway IP          | 8              |     |
|  61 | 0'   | Gateway IP          | 9              |     |
|  62 | 0'   | Gateway IP          | 10             |     |
|  63 | 0'   | Gateway IP          | 11             |     |
|  64 | .'   | Gateway IP          | 12             |     |
|  65 | 0'   | Gateway IP          | 13             |     |
|  66 | 0'   | Gateway IP          | 14             |     |
|  67 | 1'   | Gateway IP          | 15             |     |
|  68 | 0x20 | Space               |                |     |
|  69 | 0x20 | Space               |                |     |
|  70 | 0'   | Port                | 1              |     |
|  71 | 6'   | Port                | 2              |     |
|  72 | 0'   | Port                | 3              |     |
|  73 | 0'   | Port                | 4              |     |
|  74 | 1'   | Port                | 5              |     |
|  75 | 0x20 | Space               |                |     |
|  76 | 0x20 | Space               |                |     |
|  77 | 3'   | DHCP Mode           | '0': Static    |     |
|  78 | 0'   | DHCP Mode           | '1': DHCP      |     |
|  79 | 0x20 | Space               |                |     |
|  80 | 0x20 | Space               |                |     |
|  81 | 1'   | Server IP           | 1              |     |
|  82 | 9'   | Server IP           | 2              |     |
|  83 | 2'   | Server IP           | 3              |     |
|  84 | .'   | Server IP           | 4              |     |
|  85 | 1'   | Server IP           | 5              |     |
|  86 | 6'   | Server IP           | 6              |     |
|  87 | 8'   | Server IP           | 7              |     |
|  88 | .'   | Server IP           | 8              |     |
|  89 | 0'   | Server IP           | 9              |     |
|  90 | 0'   | Server IP           | 10             |     |
|  91 | 0'   | Server IP           | 11             |     |
|  92 | .'   | Server IP           | 12             |     |
|  93 | 0'   | Server IP           | 13             |     |
|  94 | 0'   | Server IP           | 14             |     |
|  95 | 0'   | Server IP           | 15             |     |
|  96 | 0x20 | Space               |                |     |
|  97 | 0x20 | Space               |                |     |
|  98 | 0'   | Server Port         | 1              |     |
|  99 | 0'   | Server Port         | 2              |     |
| 100 | 0'   | Server Port         | 3              |     |
| 101 | 0'   | Server Port         | 4              |     |
| 102 | 0'   | Server Port         | 5              |     |
| 103 | 0x20 | Space               |                |     |
| 104 | 0x20 | Space               |                |     |
| 105 | 3'   | Server Mode         | '0': Client    |     |
| 106 | 0'   | Server Mode         | '1': Server    |     |
| 107 | 0x20 | Space               |                |     |
| 108 | 0x20 | Space               |                |     |
| 109 | 0'   | Name                | 1              |     |
| 110 | 0'   | Name                | 2              |     |
| 111 | 0'   | Name                | 3              |     |
| 112 | 0'   | Name                | 4              |     |
| 113 | 0'   | Name                | 5              |     |
| 114 | 0'   | Name                | 6              |     |
| 115 | 0'   | Name                | 7              |     |
| 116 | 0'   | Name                | 8              |     |
| 117 | 0'   | Name                | 9              |     |
| 118 | 0'   | Name                | 10             |     |
| 119 | 0'   | Name                | 11             |     |
| 120 | 0'   | Name                | 12             |     |
| 121 | 0'   | Name                | 13             |     |
| 122 | 0'   | Name                | 14             |     |
| 123 | 0'   | Name                | 15             |     |
| 124 | 0'   | Name                | 16             |     |
| 125 | 0'   | Name                | 17             |     |
| 126 | 0'   | Name                | 18             |     |
| 127 | 0'   | Name                | 19             |     |
| 128 | 0'   | Name                | 20             |     |
| 129 | 0x20 | Space               |                |     |
| 130 | 0x20 | Space               |                |     |
| 131 | 0'   | KeepAlive           | 1              |     |
| 132 | 0'   | KeepAlive           | 2              |     |
| 133 | 0'   | KeepAlive           | 3              |     |
| 134 | 0x20 | Space               |                |     |
| 135 | 0x20 | Space               |                |     |
| 136 | 0'   | DNS Name            | 1              |     |
| 137 | 0'   | DNS Name            | 2              |     |
| 138 | 0'   | DNS Name            | 3              |     |
| 139 | 0'   | DNS Name            | 4              |     |
| 140 | 0'   | DNS Name            | 5              |     |
| 141 | 0'   | DNS Name            | 6              |     |
| 142 | 0'   | DNS Name            | 7              |     |
| 143 | 0'   | DNS Name            | 8              |     |
| 144 | 0'   | DNS Name            | 9              |     |
| 145 | 0'   | DNS Name            | 10             |     |
| 146 | 0'   | DNS Name            | 11             |     |
| 147 | 0'   | DNS Name            | 12             |     |
| 148 | 0'   | DNS Name            | 13             |     |
| 149 | 0'   | DNS Name            | 14             |     |
| 150 | 0'   | DNS Name            | 15             |     |
| 151 | 0'   | DNS Name            | 16             |     |
| 152 | 0'   | DNS Name            | 17             |     |
| 153 | 0'   | DNS Name            | 18             |     |
| 154 | 0'   | DNS Name            | 19             |     |
| 155 | 0'   | DNS Name            | 20             |     |
| 156 | 0'   | DNS Name            | 21             |     |
| 157 | 0'   | DNS Name            | 22             |     |
| 158 | 0'   | DNS Name            | 23             |     |
| 159 | 0'   | DNS Name            | 24             |     |
| 160 | 0'   | DNS Name            | 25             |     |
| 161 | 0'   | DNS Name            | 26             |     |
| 162 | 0'   | DNS Name            | 27             |     |
| 163 | 0'   | DNS Name            | 28             |     |
| 164 | 0'   | DNS Name            | 29             |     |
| 165 | 0'   | DNS Name            | 30             |     |
| 166 | 0x20 | Space               |                |     |
| 167 | 0x20 | Space               |                |     |
| 168 | 0'   | AP&SSID 이름          | 1              |     |
| 169 | 0'   | AP&SSID 이름          | 2              |     |
| 170 | 0'   | AP&SSID 이름          | 3              |     |
| 171 | 0'   | AP&SSID 이름          | 4              |     |
| 172 | 0'   | AP&SSID 이름          | 5              |     |
| 173 | 0'   | AP&SSID 이름          | 6              |     |
| 174 | 0'   | AP&SSID 이름          | 7              |     |
| 175 | 0'   | AP&SSID 이름          | 8              |     |
| 176 | 0'   | AP&SSID 이름          | 9              |     |
| 177 | 0'   | AP&SSID 이름          | 10             |     |
| 178 | 0'   | AP&SSID 이름          | 11             |     |
| 179 | 0'   | AP&SSID 이름          | 12             |     |
| 180 | 0'   | AP&SSID 이름          | 13             |     |
| 181 | 0'   | AP&SSID 이름          | 14             |     |
| 182 | 0'   | AP&SSID 이름          | 15             |     |
| 183 | 0'   | AP&SSID 이름          | 16             |     |
| 184 | 0'   | AP&SSID 이름          | 17             |     |
| 185 | 0'   | AP&SSID 이름          | 18             |     |
| 186 | 0'   | AP&SSID 이름          | 19             |     |
| 187 | 0'   | AP&SSID 이름          | 20             |     |
| 188 | 0x20 | Space               |                |     |
| 189 | 0x20 | Space               |                |     |
| 190 | 0'   | AP&SSID  비번         | 1              |     |
| 191 | 0'   | AP&SSID  비번         | 2              |     |
| 192 | 0'   | AP&SSID  비번         | 3              |     |
| 193 | 0'   | AP&SSID  비번         | 4              |     |
| 194 | 0'   | AP&SSID  비번         | 5              |     |
| 195 | 0'   | AP&SSID  비번         | 6              |     |
| 196 | 0'   | AP&SSID  비번         | 7              |     |
| 197 | 0'   | AP&SSID  비번         | 8              |     |
| 198 | 0'   | AP&SSID  비번         | 9              |     |
| 199 | 0'   | AP&SSID  비번         | 10             |     |
| 200 | 0'   | AP&SSID  비번         | 11             |     |
| 201 | 0'   | AP&SSID  비번         | 12             |     |
| 202 | 0'   | AP&SSID  비번         | 13             |     |
| 203 | 0'   | AP&SSID  비번         | 14             |     |
| 204 | 0'   | AP&SSID  비번         | 15             |     |
| 205 | 0'   | AP&SSID  비번         | 16             |     |
| 206 | 0'   | AP&SSID  비번         | 17             |     |
| 207 | 0'   | AP&SSID  비번         | 18             |     |
| 208 | 0'   | AP&SSID  비번         | 19             |     |
| 209 | 0'   | AP&SSID  비번         | 20             |     |
| 210 | 0x20 | Space               |                |     |
| 211 | 0x20 | Space               |                |     |
| 212 | 3'   | AP&State모드          | '0': State     |     |
| 213 | 0'   | AP&State모드          | '1': AP        |     |
| 214 | 0x20 | Space               |                |     |
| 215 | 0x20 | Space               |                |     |
| 216 | 3'   | Wifi & Bluetooth 모드 | '0': Bouetooth | 0   |
| 217 | 0'   | Wifi & Bluetooth 모드 | '1': Wifi      | 1   |
| 218 | 0x20 | Space               |                | 2   |
| 219 | 0x20 | Space               |                | 3   |
| 220 | 0'   | Bluetooth 이름        | 1              | 4   |
| 221 | 0'   | Bluetooth 이름        | 2              | 5   |
| 222 | 0'   | Bluetooth 이름        | 3              | 6   |
| 223 | 0'   | Bluetooth 이름        | 4              | 7   |
| 224 | 0'   | Bluetooth 이름        | 5              | 8   |
| 225 | 0'   | Bluetooth 이름        | 6              | 9   |
| 226 | 0'   | Bluetooth 이름        | 7              | 10  |
| 227 | 0'   | Bluetooth 이름        | 8              | 11  |
| 228 | 0'   | Bluetooth 이름        | 9              | 12  |
| 229 | 0'   | Bluetooth 이름        | 10             | 13  |
| 230 | 0'   | Bluetooth 이름        | 11             | 14  |
| 231 | 0'   | Bluetooth 이름        | 12             | 15  |
| 232 | 0'   | Bluetooth 이름        | 13             | 16  |
| 233 | 0'   | Bluetooth 이름        | 14             | 17  |
| 234 | 0'   | Bluetooth 이름        | 15             | 18  |
| 235 | 0'   | Bluetooth 이름        | 16             | 19  |
| 236 | 0'   | Bluetooth 이름        | 17             | 20  |
| 237 | 0'   | Bluetooth 이름        | 18             | 21  |
| 238 | 0'   | Bluetooth 이름        | 19             | 22  |
| 239 | 0'   | Bluetooth 이름        | 20             | 23  |
| 240 | 0x20 | Space               |                | 24  |
| 241 | 0x20 | Space               |                | 25  |
| 242 | 0'   | Bluetooth  비번       | 1              | 26  |
| 243 | 0'   | Bluetooth  비번       | 2              | 27  |
| 244 | 0'   | Bluetooth  비번       | 3              | 28  |
| 245 | 0'   | Bluetooth  비번       | 4              | 29  |
| 246 | 0'   | Bluetooth  비번       | 5              | 30  |
| 247 | 0'   | Bluetooth  비번       | 6              | 31  |
| 248 | 0'   | Bluetooth  비번       | 7              | 32  |
| 249 | 0'   | Bluetooth  비번       | 8              | 33  |
| 250 | 0'   | Bluetooth  비번       | 9              | 34  |
| 251 | 0'   | Bluetooth  비번       | 10             | 35  |
| 252 | 0'   | Bluetooth  비번       | 11             | 36  |
| 253 | 0'   | Bluetooth  비번       | 12             | 37  |
| 254 | 0'   | Bluetooth  비번       | 13             | 38  |
| 255 | 0'   | Bluetooth  비번       | 14             | 39  |
| 256 | 0'   | Bluetooth  비번       | 15             | 40  |
| 257 | 0'   | Bluetooth  비번       | 16             | 41  |
| 258 | 0'   | Bluetooth  비번       | 17             | 42  |
| 259 | 0'   | Bluetooth  비번       | 18             | 43  |
| 260 | 0'   | Bluetooth  비번       | 19             | 44  |
| 261 | 0'   | Bluetooth  비번       | 20             | 45  |
| 262 | 0x20 | Space               |                | 46  |
| 263 | 0x20 | Space               |                | 47  |
| 264 | A'   | Mac Addr            | 1              | 0   |
| 265 | B'   | Mac Addr            | 2              | 1   |
| 266 | -'   | Mac Addr            | 3              | 2   |
| 267 | C'   | Mac Addr            | 4              | 3   |
| 268 | D'   | Mac Addr            | 5              | 4   |
| 269 | -'   | Mac Addr            | 6              | 5   |
| 270 | E'   | Mac Addr            | 7              | 6   |
| 271 | F'   | Mac Addr            | 8              | 7   |
| 272 | -'   | Mac Addr            | 9              | 8   |
| 273 | G'   | Mac Addr            | 10             | 9   |
| 274 | H'   | Mac Addr            | 11             | 10  |
| 275 | -'   | Mac Addr            | 12             | 11  |
| 276 | I'   | Mac Addr            | 13             | 12  |
| 277 | J'   | Mac Addr            | 14             | 13  |
| 278 | -'   | Mac Addr            | 15             | 14  |
| 279 | K'   | Mac Addr            | 16             | 15  |
| 280 | L'   | Mac Addr            | 17             | 16  |
| 281 | 0x20 | Space               |                | 17  |
| 282 | 0x20 | Space               |                | 18  |
| 283 | 1'   | Local IP            | 1              | 19  |
| 284 | 9'   | Local IP            | 2              | 20  |
| 285 | 2'   | Local IP            | 3              | 21  |
| 286 | .'   | Local IP            | 4              | 22  |
| 287 | 1'   | Local IP            | 5              | 23  |
| 288 | 6'   | Local IP            | 6              | 24  |
| 289 | 8'   | Local IP            | 7              | 25  |
| 290 | .'   | Local IP            | 8              | 26  |
| 291 | 0'   | Local IP            | 9              | 27  |
| 292 | 0'   | Local IP            | 10             | 28  |
| 293 | 0'   | Local IP            | 11             | 29  |
| 294 | .'   | Local IP            | 12             | 30  |
| 295 | 0'   | Local IP            | 13             | 31  |
| 296 | 7'   | Local IP            | 14             | 32  |
| 297 | 4'   | Local IP            | 15             | 33  |
| 298 | 0x20 | Space               |                | 34  |
| 299 | 0x20 | Space               |                | 35  |
| 300 | 2'   | Subnet Mask         | 1              | 36  |
| 301 | 5'   | Subnet Mask         | 2              | 37  |
| 302 | 5'   | Subnet Mask         | 3              | 38  |
| 303 | .'   | Subnet Mask         | 4              | 39  |
| 304 | 2'   | Subnet Mask         | 5              | 40  |
| 305 | 5'   | Subnet Mask         | 6              | 41  |
| 306 | 5'   | Subnet Mask         | 7              | 42  |
| 307 | .'   | Subnet Mask         | 8              | 43  |
| 308 | 2'   | Subnet Mask         | 9              | 44  |
| 309 | 5'   | Subnet Mask         | 10             | 45  |
| 310 | 5'   | Subnet Mask         | 11             | 46  |
| 311 | .'   | Subnet Mask         | 12             | 47  |
| 312 | 0'   | Subnet Mask         | 13             | 48  |
| 313 | 0'   | Subnet Mask         | 14             | 49  |
| 314 | 0'   | Subnet Mask         | 15             | 50  |
| 315 | 0x20 | Space               |                | 51  |
| 316 | 0x20 | Space               |                | 52  |
| 317 | 1'   | Gateway IP          | 1              | 53  |
| 318 | 9'   | Gateway IP          | 2              | 54  |
| 319 | 2'   | Gateway IP          | 3              | 55  |
| 320 | .'   | Gateway IP          | 4              | 56  |
| 321 | 1'   | Gateway IP          | 5              | 57  |
| 322 | 6'   | Gateway IP          | 6              | 58  |
| 323 | 8'   | Gateway IP          | 7              | 59  |
| 324 | .'   | Gateway IP          | 8              | 60  |
| 325 | 0'   | Gateway IP          | 9              | 61  |
| 326 | 0'   | Gateway IP          | 10             | 62  |
| 327 | 0'   | Gateway IP          | 11             | 63  |
| 328 | .'   | Gateway IP          | 12             | 64  |
| 329 | 0'   | Gateway IP          | 13             | 65  |
| 330 | 0'   | Gateway IP          | 14             | 66  |
| 331 | 1'   | Gateway IP          | 15             | 67  |
| 332 | 0x20 | Space               |                | 68  |
| 333 | 0x20 | Space               |                | 69  |
| 334 | 0'   | Port                | 1              | 70  |
| 335 | 6'   | Port                | 2              | 71  |
| 336 | 0'   | Port                | 3              | 72  |
| 337 | 0'   | Port                | 4              | 73  |
| 338 | 1'   | Port                | 5              | 74  |
| 339 | 0x20 | Space               |                | 75  |
| 340 | 0x20 | Space               |                | 76  |
| 341 | 3'   | DHCP Mode           | '0': Static    | 77  |
| 342 | 0'   | DHCP Mode           | '1': DHCP      | 78  |
| 343 | 0x20 | Space               |                | 79  |
| 344 | 0x20 | Space               |                | 80  |
| 345 | 1'   | Server IP           | 1              | 81  |
| 346 | 9'   | Server IP           | 2              | 82  |
| 347 | 2'   | Server IP           | 3              | 83  |
| 348 | .'   | Server IP           | 4              | 84  |
| 349 | 1'   | Server IP           | 5              | 85  |
| 350 | 6'   | Server IP           | 6              | 86  |
| 351 | 8'   | Server IP           | 7              | 87  |
| 352 | .'   | Server IP           | 8              | 88  |
| 353 | 0'   | Server IP           | 9              | 89  |
| 354 | 0'   | Server IP           | 10             | 90  |
| 355 | 0'   | Server IP           | 11             | 91  |
| 356 | .'   | Server IP           | 12             | 92  |
| 357 | 0'   | Server IP           | 13             | 93  |
| 358 | 0'   | Server IP           | 14             | 94  |
| 359 | 0'   | Server IP           | 15             | 95  |
| 360 | 0x20 | Space               |                | 96  |
| 361 | 0x20 | Space               |                | 97  |
| 362 | 0'   | Server Port         | 1              | 98  |
| 363 | 0'   | Server Port         | 2              | 99  |
| 364 | 0'   | Server Port         | 3              | 100 |
| 365 | 0'   | Server Port         | 4              | 101 |
| 366 | 0'   | Server Port         | 5              | 102 |
| 367 | 0x20 | Space               |                | 103 |
| 368 | 0x20 | Space               |                | 104 |
| 369 | 3'   | Server Mode         | '0': Client    | 105 |
| 370 | 0'   | Server Mode         | '1': Server    | 106 |
| 371 | 0x20 | Space               |                | 107 |
| 372 | 0x20 | Space               |                | 108 |
| 373 | 0'   | Name                | 1              | 109 |
| 374 | 0'   | Name                | 2              | 110 |
| 375 | 0'   | Name                | 3              | 111 |
| 376 | 0'   | Name                | 4              | 112 |
| 377 | 0'   | Name                | 5              | 113 |
| 378 | 0'   | Name                | 6              | 114 |
| 379 | 0'   | Name                | 7              | 115 |
| 380 | 0'   | Name                | 8              | 116 |
| 381 | 0'   | Name                | 9              | 117 |
| 382 | 0'   | Name                | 10             | 118 |
| 383 | 0'   | Name                | 11             | 119 |
| 384 | 0'   | Name                | 12             | 120 |
| 385 | 0'   | Name                | 13             | 121 |
| 386 | 0'   | Name                | 14             | 122 |
| 387 | 0'   | Name                | 15             | 123 |
| 388 | 0'   | Name                | 16             | 124 |
| 389 | 0'   | Name                | 17             | 125 |
| 390 | 0'   | Name                | 18             | 126 |
| 391 | 0'   | Name                | 19             | 127 |
| 392 | 0'   | Name                | 20             | 128 |
| 393 | 0x20 | Space               |                | 129 |
| 394 | 0x20 | Space               |                | 130 |
| 395 | 0'   | KeepAlive           | 1              | 131 |
| 396 | 0'   | KeepAlive           | 2              | 132 |
| 397 | 0'   | KeepAlive           | 3              | 133 |
| 398 | 0x20 | Space               |                | 134 |
| 399 | 0x20 | Space               |                | 135 |
| 400 | 0'   | DNS Name            | 1              | 136 |
| 401 | 0'   | DNS Name            | 2              | 137 |
| 402 | 0'   | DNS Name            | 3              | 138 |
| 403 | 0'   | DNS Name            | 4              | 139 |
| 404 | 0'   | DNS Name            | 5              | 140 |
| 405 | 0'   | DNS Name            | 6              | 141 |
| 406 | 0'   | DNS Name            | 7              | 142 |
| 407 | 0'   | DNS Name            | 8              | 143 |
| 408 | 0'   | DNS Name            | 9              | 144 |
| 409 | 0'   | DNS Name            | 10             | 145 |
| 410 | 0'   | DNS Name            | 11             | 146 |
| 411 | 0'   | DNS Name            | 12             | 147 |
| 412 | 0'   | DNS Name            | 13             | 148 |
| 413 | 0'   | DNS Name            | 14             | 149 |
| 414 | 0'   | DNS Name            | 15             | 150 |
| 415 | 0'   | DNS Name            | 16             | 151 |
| 416 | 0'   | DNS Name            | 17             | 152 |
| 417 | 0'   | DNS Name            | 18             | 153 |
| 418 | 0'   | DNS Name            | 19             | 154 |
| 419 | 0'   | DNS Name            | 20             | 155 |
| 420 | 0'   | DNS Name            | 21             | 156 |
| 421 | 0'   | DNS Name            | 22             | 157 |
| 422 | 0'   | DNS Name            | 23             | 158 |
| 423 | 0'   | DNS Name            | 24             | 159 |
| 424 | 0'   | DNS Name            | 25             | 160 |
| 425 | 0'   | DNS Name            | 26             | 161 |
| 426 | 0'   | DNS Name            | 27             | 162 |
| 427 | 0'   | DNS Name            | 28             | 163 |
| 428 | 0'   | DNS Name            | 29             | 164 |
| 429 | 0'   | DNS Name            | 30             | 165 |
| 430 | 0x20 | Space               |                | 166 |
| 431 | 0x20 | Space               |                | 167 |
| 432 | 0'   | AP&SSID 이름          | 1              | 168 |
| 433 | 0'   | AP&SSID 이름          | 2              | 169 |
| 434 | 0'   | AP&SSID 이름          | 3              | 170 |
| 435 | 0'   | AP&SSID 이름          | 4              | 171 |
| 436 | 0'   | AP&SSID 이름          | 5              | 172 |
| 437 | 0'   | AP&SSID 이름          | 6              | 173 |
| 438 | 0'   | AP&SSID 이름          | 7              | 174 |
| 439 | 0'   | AP&SSID 이름          | 8              | 175 |
| 440 | 0'   | AP&SSID 이름          | 9              | 176 |
| 441 | 0'   | AP&SSID 이름          | 10             | 177 |
| 442 | 0'   | AP&SSID 이름          | 11             | 178 |
| 443 | 0'   | AP&SSID 이름          | 12             | 179 |
| 444 | 0'   | AP&SSID 이름          | 13             | 180 |
| 445 | 0'   | AP&SSID 이름          | 14             | 181 |
| 446 | 0'   | AP&SSID 이름          | 15             | 182 |
| 447 | 0'   | AP&SSID 이름          | 16             | 183 |
| 448 | 0'   | AP&SSID 이름          | 17             | 184 |
| 449 | 0'   | AP&SSID 이름          | 18             | 185 |
| 450 | 0'   | AP&SSID 이름          | 19             | 186 |
| 451 | 0'   | AP&SSID 이름          | 20             | 187 |
| 452 | 0x20 | Space               |                | 188 |
| 453 | 0x20 | Space               |                | 189 |
| 454 | 0'   | AP&SSID  비번         | 1              | 190 |
| 455 | 0'   | AP&SSID  비번         | 2              | 191 |
| 456 | 0'   | AP&SSID  비번         | 3              | 192 |
| 457 | 0'   | AP&SSID  비번         | 4              | 193 |
| 458 | 0'   | AP&SSID  비번         | 5              | 194 |
| 459 | 0'   | AP&SSID  비번         | 6              | 195 |
| 460 | 0'   | AP&SSID  비번         | 7              | 196 |
| 461 | 0'   | AP&SSID  비번         | 8              | 197 |
| 462 | 0'   | AP&SSID  비번         | 9              | 198 |
| 463 | 0'   | AP&SSID  비번         | 10             | 199 |
| 464 | 0'   | AP&SSID  비번         | 11             | 200 |
| 465 | 0'   | AP&SSID  비번         | 12             | 201 |
| 466 | 0'   | AP&SSID  비번         | 13             | 202 |
| 467 | 0'   | AP&SSID  비번         | 14             | 203 |
| 468 | 0'   | AP&SSID  비번         | 15             | 204 |
| 469 | 0'   | AP&SSID  비번         | 16             | 205 |
| 470 | 0'   | AP&SSID  비번         | 17             | 206 |
| 471 | 0'   | AP&SSID  비번         | 18             | 207 |
| 472 | 0'   | AP&SSID  비번         | 19             | 208 |
| 473 | 0'   | AP&SSID  비번         | 20             | 209 |
| 474 | 0x20 | Space               |                | 210 |
| 475 | 0x20 | Space               |                | 211 |
| 476 | 3'   | AP&State모드          | '0': State     | 212 |
| 477 | 0'   | AP&State모드          | '1': AP        | 213 |
| 478 | 0x20 | Space               |                | 214 |
| 479 | 0x20 | Space               |                | 215 |
| 480 | E    |                     |                | 1   |
| 481 | 0    |                     |                | 2   |
| 482 | 4    |                     |                | 3   |
| 483 | !    |                     |                | 4   |
| 484 | ]    |                     |                | 5   |
| 485 | 1    |                     |                | 6   |
| 486 | 0    |                     |                | 7   |
| 487 | 0    |                     |                | 8   |
| 488 | 3    |                     |                | 9   |
| 489 | 0    |                     |                | 10  |
| 490 | 1    |                     |                | 11  |
| 491 | 0    |                     |                | 12  |
| 492 |      |                     |                | 13  |
| 493 |      |                     |                | 14  |
| 494 |      |                     |                | 15  |
| 495 |      |                     |                | 16  |
| 496 |      |                     |                | 17  |
| 497 |      |                     |                | 18  |
| 498 | 0x20 |                     |                | 1   |
| 499 | 0x20 |                     |                | 2   |
| 500 | 5    |                     |                | 3   |
| 501 | 4    |                     |                | 4   |
| 502 | F    |                     |                | 5   |
| 503 | F    |                     |                | 6   |
| 504 | 8    |                     |                | 7   |
| 505 | 2    |                     |                | 8   |
| 506 | 8    |                     |                | 9   |
| 507 | F    |                     |                | 10  |
| 508 | F    |                     |                | 11  |
| 509 | F    |                     |                | 12  |
| 510 | F    |                     |                | 13  |
| 511 | F    |                     |                | 14  |

