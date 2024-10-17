## EnhancedConsoleLib

**EnhancedConsoleLib is a Solidity library that provides enhanced logging capabilities with colored and styled console outputs.**

### Features

- **Colored Logs**: Log messages with various colors such as red, green, yellow, blue, magenta, cyan, and white.
- **Styled Logs**: Log messages with styles like bold and underline.
- **Background Colors**: Log messages with background colors.
- **Tables**: Log structured data in a table format.
- **Banners**: Log messages fenced in within '*'.

## Documentation

### Functions

- `log(string memory message)`: Logs a simple message.
- `logColored(string memory message, string memory color)`: Logs a message with the specified color.
- `logStyled(string memory message, string memory color, string memory style)`: Logs a message with the specified color and style.
- `logRed(string memory message)`: Logs a message in red color.
- `logGreen(string memory message)`: Logs a message in green color.
- `logYellow(string memory message)`: Logs a message in yellow color.
- `logBlue(string memory message)`: Logs a message in blue color.
- `logMagenta(string memory message)`: Logs a message in magenta color.
- `logCyan(string memory message)`: Logs a message in cyan color.
- `logWhite(string memory message)`: Logs a message in white color.
- `logBold(string memory message)`: Logs a message in bold style.
- `logUnderline(string memory message)`: Logs a message in underline style.
- `logWithBackground(string memory message, string memory color, string memory bgColor)`: Logs a message with the specified text color and background color.
- `logTable(string[] memory headers, string[][] memory rows)`: Logs a table with the specified headers and rows.
- `logBanner(string memory message)`: Logs a message within a banner of stars.

## Usage

### Importing the Library

To use EnhancedConsoleLib in your Solidity project, import it as follows:

```solidity
import {EnhancedConsoleLib} from "./EnhancedConsoleLib.sol";

contract MyContract {
    function exampleUsage() public pure {
        // Log a simple message
        EnhancedConsoleLib.log("This is a simple log message");

        // Log messages with different colors
        EnhancedConsoleLib.logRed("This is a red message");
        EnhancedConsoleLib.logGreen("This is a green message");
        EnhancedConsoleLib.logYellow("This is a yellow message");
        EnhancedConsoleLib.logBlue("This is a blue message");
        EnhancedConsoleLib.logMagenta("This is a magenta message");
        EnhancedConsoleLib.logCyan("This is a cyan message");
        EnhancedConsoleLib.logWhite("This is a white message");

        // Log messages with different styles
        EnhancedConsoleLib.logBold("This is a bold message");
        EnhancedConsoleLib.logUnderline("This is an underlined message");

        // Log messages with background colors
        EnhancedConsoleLib.logWithBackground("White text on red background", EnhancedConsoleLib.WHITE, EnhancedConsoleLib.BG_RED);
        EnhancedConsoleLib.logWithBackground("Black text on yellow background", EnhancedConsoleLib.BLACK, EnhancedConsoleLib.BG_YELLOW);

        // Log a table
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

        // Log a banner
        EnhancedConsoleLib.logBanner("Starting Section");
    }
}



