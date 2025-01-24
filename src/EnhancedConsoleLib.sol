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

    function log(
        string memory message
    ) internal pure {
        console.log(message);
    }

    function logColored(string memory message, string memory color) internal pure {
        console.log(string.concat(color, message, RESET));
    }

    function logStyled(
        string memory message,
        string memory color,
        string memory style
    ) internal pure {
        console.log(string.concat(style, color, message, RESET));
    }

    function logRed(
        string memory message
    ) internal pure {
        logColored(message, RED);
    }

    function logGreen(
        string memory message
    ) internal pure {
        logColored(message, GREEN);
    }

    function logYellow(
        string memory message
    ) internal pure {
        logColored(message, YELLOW);
    }

    function logBlue(
        string memory message
    ) internal pure {
        logColored(message, BLUE);
    }

    function logMagenta(
        string memory message
    ) internal pure {
        logColored(message, MAGENTA);
    }

    function logCyan(
        string memory message
    ) internal pure {
        logColored(message, CYAN);
    }

    function logWhite(
        string memory message
    ) internal pure {
        logColored(message, WHITE);
    }

    function logBold(
        string memory message
    ) internal pure {
        logStyled(message, WHITE, BOLD);
    }

    function logUnderline(
        string memory message
    ) internal pure {
        logStyled(message, WHITE, UNDERLINE);
    }

    function logWithBackground(
        string memory message,
        string memory color,
        string memory bgColor
    ) internal pure {
        console.log(string.concat(color, bgColor, message, RESET));
    }

    function logTable(string[] memory headers, string[][] memory rows) internal pure {
        require(
            headers.length > 0 && rows.length > 0 && headers.length == rows[0].length,
            "Invalid table structure"
        );

        uint256[] memory columnWidths = new uint256[](headers.length);
        for (uint256 i = 0; i < headers.length; i++) {
            columnWidths[i] = bytes(headers[i]).length;
            for (uint256 j = 0; j < rows.length; j++) {
                if (bytes(rows[j][i]).length > columnWidths[i]) {
                    columnWidths[i] = bytes(rows[j][i]).length;
                }
            }
        }

        string memory separator = "+";
        for (uint256 i = 0; i < headers.length; i++) {
            for (uint256 j = 0; j < columnWidths[i] + 2; j++) {
                separator = string.concat(separator, "-");
            }
            separator = string.concat(separator, "+");
        }

        console.log(separator);
        string memory headerRow = "|";
        for (uint256 i = 0; i < headers.length; i++) {
            headerRow = string.concat(headerRow, " ", padRight(headers[i], columnWidths[i]), " |");
        }
        console.log(headerRow);
        console.log(separator);

        for (uint256 i = 0; i < rows.length; i++) {
            string memory row = "|";
            for (uint256 j = 0; j < headers.length; j++) {
                row = string.concat(row, " ", padRight(rows[i][j], columnWidths[j]), " |");
            }
            console.log(row);
        }
        console.log(separator);
    }

    function logBanner(
        string memory message
    ) internal pure {
        uint256 length = bytes(message).length;
        string memory stars = "";
        for (uint256 i = 0; i < length + 4; i++) {
            stars = string.concat(stars, "*");
        }

        console.log(string.concat(YELLOW, stars));
        console.log(string.concat("* ", WHITE, message, YELLOW, " *"));
        console.log(string.concat(stars, RESET));
    }

    function padRight(string memory str, uint256 length) private pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        if (strBytes.length >= length) return str;
        bytes memory result = new bytes(length);
        uint256 j = 0;
        for (; j < strBytes.length; j++) {
            result[j] = strBytes[j];
        }
        for (; j < length; j++) {
            result[j] = " ";
        }
        return string(result);
    }

    /**
     * @notice Generates an ASCII bar chart for numeric data visualization
     * @param dataPoints Array of uint256 data points to plot
     * @param height Height of the chart (number of rows). Default is 10 if 0 is passed
     */
    function plotAsciiChart(uint256[] memory dataPoints, uint256 height) internal pure {
        if (dataPoints.length == 0) {
            console.log("No data points to plot.");
            return;
        }

        uint256 chartHeight = height == 0 ? 10 : height;
        uint256 maxValue = dataPoints[0];
        uint256 minValue = dataPoints[0];

        // Find min and max values
        for (uint256 i = 1; i < dataPoints.length; i++) {
            if (dataPoints[i] > maxValue) maxValue = dataPoints[i];
            if (dataPoints[i] < minValue) minValue = dataPoints[i];
        }

        // Print max value at top
        console.log(string.concat(CYAN, toString(maxValue), RESET));

        uint256 range = maxValue - minValue;
        if (range == 0) {
            // Handle flat line case
            string memory line = "|";
            for (uint256 i = 0; i < dataPoints.length; i++) {
                line = string.concat(line, "-");
            }
            console.log(line);
            console.log(string.concat(CYAN, toString(minValue), RESET));
            return;
        }

        // Build and print chart rows
        for (uint256 row = 0; row < chartHeight; row++) {
            string memory line = "|";
            uint256 threshold = maxValue - (range * row / (chartHeight - 1));

            for (uint256 i = 0; i < dataPoints.length; i++) {
                if (dataPoints[i] >= threshold) {
                    line = string.concat(line, string.concat(GREEN, "#", RESET));
                } else {
                    line = string.concat(line, " ");
                }
            }
            console.log(line);
        }

        // Print x-axis
        string memory xAxis = "+";
        for (uint256 i = 0; i < dataPoints.length; i++) {
            xAxis = string.concat(xAxis, "-");
        }
        console.log(xAxis);

        // Print min value at bottom
        console.log(string.concat(CYAN, toString(minValue), RESET));
    }

    /**
     * @notice Convenience overload for plotAsciiChart with default height
     */
    function plotAsciiChart(uint256[] memory dataPoints) internal pure {
        plotAsciiChart(dataPoints, 10);
    }

    /**
     * @notice Converts a uint256 to its string representation
     */
    function toString(uint256 value) private pure returns (string memory) {
        if (value == 0) return "0";

        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }

        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }

        return string(buffer);
    }

    struct Transition {
        uint256 fromStateIndex;
        uint256 toStateIndex;
        string triggerEvent;
    }

    struct TokenFlow {
        string fromEntityName;
        string toEntityName;
        string tokenSymbol;
        uint256 amount;
    }

    /**
     * @notice Visualizes a state machine in ASCII format
     * @param states Array of state names
     * @param transitions Array of transitions between states
     */
    function visualizeStateMachine(
        string[] memory states,
        Transition[] memory transitions
    ) internal pure {
        logColored("State Machine Visualization:", CYAN);
        console.log("");

        logStyled("States:", WHITE, BOLD);
        for (uint256 i = 0; i < states.length; i++) {
            console.log(string.concat("  [", toString(i), "] ", states[i]));
        }
        console.log("");

        logStyled("Transitions:", WHITE, BOLD);
        for (uint256 i = 0; i < transitions.length; i++) {
            string memory fromState = states[transitions[i].fromStateIndex];
            string memory toState = states[transitions[i].toStateIndex];
            string memory trigger = transitions[i].triggerEvent;

            string memory fromStateDisplay = string.concat("(", fromState, ")");
            string memory toStateDisplay = string.concat("[", toState, "]");

            // Highlight initial state and active states
            if (i == 0) {
                fromStateDisplay = string.concat(GREEN, "[", fromState, "]", RESET);
            }
            if (transitions[i].toStateIndex == 1) {
                toStateDisplay = string.concat(CYAN, "[", toState, "]", RESET);
            }

            console.log(string.concat("  ", fromStateDisplay, " -- ", trigger, " --> ", toStateDisplay));
        }
        console.log("");

        logStyled("Legend:", WHITE, BOLD);
        console.log("  [State] -  Active/Current State");
        console.log("  (State) -  Inactive State");
        console.log("  -->     -  Transition Arrow");
    }

    /**
     * @notice Visualizes token flows between entities in ASCII format
     * @param flows Array of token flows between entities
     */
    function visualizeTokenFlow(TokenFlow[] memory flows) internal pure {
        logColored("Token Flow Visualization:", CYAN);
        console.log("");

        // Track unique entities
        string[] memory entities = new string[](flows.length * 2);
        uint256 entityCount;

        logStyled("Entities:", WHITE, BOLD);
        for (uint256 i = 0; i < flows.length; i++) {
            bool fromEntityExists;
            bool toEntityExists;

            for (uint256 j = 0; j < entityCount; j++) {
                if (keccak256(bytes(entities[j])) == keccak256(bytes(flows[i].fromEntityName))) {
                    fromEntityExists = true;
                }
                if (keccak256(bytes(entities[j])) == keccak256(bytes(flows[i].toEntityName))) {
                    toEntityExists = true;
                }
            }

            if (!fromEntityExists) {
                entities[entityCount++] = flows[i].fromEntityName;
                console.log(string.concat("  (", flows[i].fromEntityName, ")"));
            }
            if (!toEntityExists) {
                entities[entityCount++] = flows[i].toEntityName;
                console.log(string.concat("  [", flows[i].toEntityName, "]"));
            }
        }
        console.log("");

        logStyled("Flows:", WHITE, BOLD);
        for (uint256 i = 0; i < flows.length; i++) {
            string memory fromEntity = flows[i].fromEntityName;
            string memory toEntity = flows[i].toEntityName;
            string memory tokenSymbol = flows[i].tokenSymbol;
            uint256 amount = flows[i].amount;

            string memory fromEntityDisplay = string.concat(YELLOW, "(", fromEntity, ")", RESET);
            string memory toEntityDisplay = string.concat(CYAN, "[", toEntity, "]", RESET);

            console.log(
                string.concat(
                    "  ",
                    fromEntityDisplay,
                    " -- ",
                    toString(amount),
                    " ",
                    tokenSymbol,
                    " --> ",
                    toEntityDisplay
                )
            );
        }
        console.log("");

        logStyled("Legend:", WHITE, BOLD);
        console.log("  [Entity] - Contract");
        console.log("  (Entity) - External Account (EOA/User)");
        console.log("  -->      - Token Flow Arrow");
    }

    /**
     * @notice Visualizes a risk metric gauge in ASCII format
     * @param metricName Name of the risk metric (e.g., "Collateralization Ratio")
     * @param currentValue Current value of the metric
     * @param minValue Minimum acceptable value
     * @param maxValue Maximum acceptable value
     * @param isHigherBetter Whether higher values are better
     */
    function visualizeRiskGauge(
        string memory metricName,
        uint256 currentValue,
        uint256 minValue,
        uint256 maxValue,
        bool isHigherBetter
    ) internal pure {
        logColored(string.concat("Risk Metric Gauge: ", metricName), CYAN);
        console.log("");

        uint256 gaugeLength = 20;
        string memory gauge = "[";
        uint256 position;

        if (maxValue > minValue) {
            position = ((currentValue - minValue) * gaugeLength) / (maxValue - minValue);
            if (position > gaugeLength) position = gaugeLength;
        } else {
            position = gaugeLength / 2;
        }

        // Build the gauge with color coding
        string memory color = isHigherBetter ?
            (currentValue >= minValue ? GREEN : RED) :
            (currentValue <= maxValue ? GREEN : RED);

        for (uint256 i = 0; i < gaugeLength; i++) {
            if (i < position) {
                gauge = string.concat(gauge, color, "-", RESET);
            } else if (i == position) {
                gauge = string.concat(gauge, color, "|", RESET);
            } else {
                gauge = string.concat(gauge, "-");
            }
        }
        gauge = string.concat(gauge, "]");

        console.log(string.concat(gauge, "  ", toString(currentValue), "%"));
        console.log(string.concat("Min: ", toString(minValue), "%         Max: ", toString(maxValue), "%"));

        string memory status = isHigherBetter ?
            (currentValue >= minValue ? "Healthy" : "Risky") :
            (currentValue <= maxValue ? "Healthy" : "Risky");

        console.log(
            string.concat(
                "Status: ",
                keccak256(bytes(status)) == keccak256("Healthy") ? GREEN : RED,
                status,
                RESET,
                " (",
                isHigherBetter ? "Higher" : "Lower",
                " is Better)"
            )
        );
    }

    /**
     * @notice Visualizes a balance change in ASCII format
     * @param accountName Name of the account/entity whose balance changed
     * @param tokenSymbol Symbol of the token
     * @param changeAmount The amount by which the balance changed (positive or negative)
     */
    function visualizeBalanceChange(
        string memory accountName,
        string memory tokenSymbol,
        int256 changeAmount
    ) internal pure {
        string memory directionIndicator;
        string memory color;

        if (changeAmount > 0) {
            directionIndicator = ">>";
            color = GREEN;
        } else if (changeAmount < 0) {
            directionIndicator = "<<";
            color = RED;
            changeAmount = -changeAmount; // Make positive for display
        } else {
            directionIndicator = "==";
            color = YELLOW;
        }

        console.log(
            string.concat(
                "Balance Change: ",
                CYAN,
                accountName,
                RESET,
                " ",
                WHITE,
                tokenSymbol,
                RESET,
                " ",
                color,
                directionIndicator,
                " ",
                toString(uint256(changeAmount)),
                RESET
            )
        );
    }
}
