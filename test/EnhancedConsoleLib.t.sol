// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {EnhancedConsoleLib} from "../src/EnhancedConsoleLib.sol";

contract EnhancedConsoleLibTest is Test {
    using EnhancedConsoleLib for *;

    function testColors() public pure {
        EnhancedConsoleLib.logRed("Red");
        EnhancedConsoleLib.logGreen("Green");
        EnhancedConsoleLib.logYellow("Yellow");
        EnhancedConsoleLib.logBlue("Blue");
        EnhancedConsoleLib.logMagenta("Magenta");
        EnhancedConsoleLib.logCyan("Cyan");
        EnhancedConsoleLib.logWhite("White");
    }

    function testFormatting() public pure {
        EnhancedConsoleLib.logBold("Bold");
        EnhancedConsoleLib.logUnderline("Underline");
    }

    function testLogTable() public pure {
        string[] memory headers = new string[](3);
        headers[0] = "Name";
        headers[1] = "Age";
        headers[2] = "City";

        string[][] memory rows = new string[][](2);
        rows[0] = new string[](3);
        rows[0][0] = "Alice";
        rows[0][1] = "30";
        rows[0][2] = "New York";
        rows[1] = new string[](3);
        rows[1][0] = "Bob";
        rows[1][1] = "25";
        rows[1][2] = "San Francisco";

        EnhancedConsoleLib.logTable(headers, rows);
    }

    function testLogBox() public pure {
        string[] memory headers = new string[](1);
        headers[0] = "Message";

        string[][] memory rows = new string[][](1);
        rows[0] = new string[](1);
        rows[0][0] = "This is a boxed message";

        EnhancedConsoleLib.logTable(headers, rows);
    }

    function testLogWithBackground() public pure {
        EnhancedConsoleLib.logWithBackground(
            "White text on red background", EnhancedConsoleLib.WHITE, EnhancedConsoleLib.BG_RED
        );
        EnhancedConsoleLib.logWithBackground(
            "Black text on yellow background",
            EnhancedConsoleLib.BLACK,
            EnhancedConsoleLib.BG_YELLOW
        );
    }

    function testLogWithBackgroundMultipleColors() public pure {
        EnhancedConsoleLib.logWithBackground(
            "Blue text on green background", EnhancedConsoleLib.BLUE, EnhancedConsoleLib.BG_GREEN
        );
        EnhancedConsoleLib.logWithBackground(
            "Magenta text on cyan background",
            EnhancedConsoleLib.MAGENTA,
            EnhancedConsoleLib.BG_CYAN
        );
    }

    function testLogBanner() public pure {
        EnhancedConsoleLib.logBanner("Starting Section");
    }
}
