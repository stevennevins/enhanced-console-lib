// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {console2 as console} from "forge-std/console2.sol";

library EnhancedConsoleLib {
    // Font colors
    string internal constant BLACK = "\x1b[30m";
    string internal constant RESET = "\x1b[0m";
    string internal constant RED = "\x1b[31m";
    string internal constant GREEN = "\x1b[32m";
    string internal constant YELLOW = "\x1b[33m";
    string internal constant BLUE = "\x1b[34m";
    string internal constant MAGENTA = "\x1b[35m";
    string internal constant CYAN = "\x1b[36m";
    string internal constant WHITE = "\x1b[37m";

    // Style codes
    string internal constant BOLD = "\x1b[1m";
    string internal constant UNDERLINE = "\x1b[4m";

    // Background color codes
    string internal constant BG_RED = "\x1b[41m";
    string internal constant BG_GREEN = "\x1b[42m";
    string internal constant BG_YELLOW = "\x1b[43m";
    string internal constant BG_CYAN = "\x1b[46m";

    function log(string memory message) internal pure {
        console.log(message);
    }

    function logColored(string memory message, string memory color) internal pure {
        console.log(string.concat(color, message, RESET));
    }

    function logStyled(string memory message, string memory color, string memory style) internal pure {
        console.log(string.concat(style, color, message, RESET));
    }

    function logRed(string memory message) internal pure {
        logColored(message, RED);
    }

    function logGreen(string memory message) internal pure {
        logColored(message, GREEN);
    }

    function logYellow(string memory message) internal pure {
        logColored(message, YELLOW);
    }

    function logBlue(string memory message) internal pure {
        logColored(message, BLUE);
    }

    function logMagenta(string memory message) internal pure {
        logColored(message, MAGENTA);
    }

    function logCyan(string memory message) internal pure {
        logColored(message, CYAN);
    }

    function logWhite(string memory message) internal pure {
        logColored(message, WHITE);
    }

    function logBold(string memory message) internal pure {
        logStyled(message, WHITE, BOLD);
    }

    function logUnderline(string memory message) internal pure {
        logStyled(message, WHITE, UNDERLINE);
    }

    function logWithBackground(string memory message, string memory color, string memory bgColor) internal pure {
        console.log(string.concat(color, bgColor, message, RESET));
    }

    function logTable(string[] memory headers, string[][] memory rows) internal pure {
        require(headers.length > 0 && rows.length > 0 && headers.length == rows[0].length, "Invalid table structure");

        uint[] memory columnWidths = new uint[](headers.length);
        for (uint i = 0; i < headers.length; i++) {
            columnWidths[i] = bytes(headers[i]).length;
            for (uint j = 0; j < rows.length; j++) {
                if (bytes(rows[j][i]).length > columnWidths[i]) {
                    columnWidths[i] = bytes(rows[j][i]).length;
                }
            }
        }

        string memory separator = "+";
        for (uint i = 0; i < headers.length; i++) {
            for (uint j = 0; j < columnWidths[i] + 2; j++) {
                separator = string.concat(separator, "-");
            }
            separator = string.concat(separator, "+");
        }

        console.log(separator);
        string memory headerRow = "|";
        for (uint i = 0; i < headers.length; i++) {
            headerRow = string.concat(headerRow, " ", padRight(headers[i], columnWidths[i]), " |");
        }
        console.log(headerRow);
        console.log(separator);

        for (uint i = 0; i < rows.length; i++) {
            string memory row = "|";
            for (uint j = 0; j < headers.length; j++) {
                row = string.concat(row, " ", padRight(rows[i][j], columnWidths[j]), " |");
            }
            console.log(row);
        }
        console.log(separator);
    }


    function logBanner(string memory message) internal pure {
        uint length = bytes(message).length;
        string memory stars = "";
        for (uint i = 0; i < length + 4; i++) {
            stars = string.concat(stars, "*");
        }

        console.log(string.concat(YELLOW, stars));
        console.log(string.concat("* ", WHITE, message, YELLOW, " *"));
        console.log(string.concat(stars, RESET));
    }

    function padRight(string memory str, uint length) private pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        if (strBytes.length >= length) return str;
        bytes memory result = new bytes(length);
        uint j = 0;
        for (; j < strBytes.length; j++) {
            result[j] = strBytes[j];
        }
        for (; j < length; j++) {
            result[j] = " ";
        }
        return string(result);
    }
}
