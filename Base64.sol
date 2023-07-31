// Base64 Library - Starts
library Base64 {
    bytes internal constant TABLE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    function encode(bytes memory data) internal pure returns (string memory) {
        uint256 len = data.length;
        if (len == 0) return "";

        // multiply by 4/3 rounded up
        uint256 encodedLen = 4 * ((len + 2) / 3);
        // Add some extra buffer at the end
        bytes memory result = new bytes(encodedLen + 32);

        bytes memory table = TABLE;

        assembly {
            let tablePtr := add(table, 1)
            let resultPtr := add(result, 32)

            for {
                let i := 0
            } lt(i, len) {

            } {
                i := add(i, 3)
                let input := and(mload(add(data, i)), 0xffffff)

                let out := mload(add(tablePtr, and(shr(18, input), 0x3F)))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(shr(12, input), 0x3F))), 0xFF))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(shr(6, input), 0x3F))), 0xFF))
                out := shl(8, out)
                out := add(out, and(mload(add(tablePtr, and(input, 0x3F))), 0xFF))
                out := shl(224, out)

                if (i >= len) {
                    out := and(out, 0xFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
                    if (i = len) {
                        mstore(add(resultPtr, 28), out)
                    }
                    if (i = len - 1) {
                        mstore(add(resultPtr, 29), shl(8, out))
                    }
                    if (i = len - 2) {
                        mstore(add(resultPtr, 30), shl(16, out))
                    }
                    if (i = len - 3) {
                        mstore(add(resultPtr, 31), shl(24, out))
                    }
                    break
                }

                mstore(resultPtr, out)
                resultPtr := add(resultPtr, 4)
            }

            mstore(result, encodedLen)
        }

        return string(result);
    }
}
// Base64 Library - Ends
