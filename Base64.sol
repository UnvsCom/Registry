// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library Base64 {
    bytes internal constant TABLE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    function encode(bytes memory data) internal pure returns (string memory) {
        uint256 len = data.length;
        if (len == 0) return "";

        uint256 encodedLen = 4 * ((len + 2) / 3);
        bytes memory result = new bytes(encodedLen);

        uint256 j = 0;
        uint256 i;

        for (i = 0; i < len - (len % 3); i += 3) {
            uint256 a = uint256(uint8(data[i])) << 16 |
                        uint256(uint8(data[i + 1])) << 8 |
                        uint256(uint8(data[i + 2]));

            result[j++] = TABLE[(a >> 18) & 0x3F];
            result[j++] = TABLE[(a >> 12) & 0x3F];
            result[j++] = TABLE[(a >> 6) & 0x3F];
            result[j++] = TABLE[a & 0x3F];
        }

        if (len % 3 == 1) {
            uint256 a = uint256(uint8(data[len - 1])) << 16;
            result[j++] = TABLE[(a >> 18) & 0x3F];
            result[j++] = TABLE[(a >> 12) & 0x3F];
            result[j++] = '=';
            result[j++] = '=';
        } else if (len % 3 == 2) {
            uint256 a = uint256(uint8(data[len - 2])) << 16 |
                        uint256(uint8(data[len - 1])) << 8;
            result[j++] = TABLE[(a >> 18) & 0x3F];
            result[j++] = TABLE[(a >> 12) & 0x3F];
            result[j++] = TABLE[(a >> 6) & 0x3F];
            result[j++] = '=';
        }

        return string(result);
    }
}
