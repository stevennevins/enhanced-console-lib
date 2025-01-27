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

    function testPlotPriceVolatility() public pure {
        // Simulate volatile price movements of a token
        uint256[] memory priceData = new uint256[](20);
        uint256 basePrice = 1000;
        for (uint256 i = 0; i < priceData.length; i++) {
            // Simulate price fluctuations around the base price
            int256 fluctuation = int256(uint256(keccak256(abi.encode(i)))) % 200; // Random fluctuation up to +/- 200
            priceData[i] = uint256(int256(basePrice) + fluctuation);
        }

        console.log("\n--- Price Volatility Simulation ---");
        EnhancedConsoleLib.plotAsciiChart(priceData);
        console.log("--- End Price Volatility Simulation ---");
    }

    function testPlotLiquidityChange() public pure {
        // Simulate liquidity changes in a DeFi pool
        uint256[] memory liquidityData = new uint256[](15);
        uint256 initialLiquidity = 5000;
        uint256 liquidityStep = 500;

        // First scenario: Gradual liquidity increase
        for (uint256 i = 0; i < liquidityData.length; i++) {
            liquidityData[i] = initialLiquidity + (i * liquidityStep);
        }

        console.log("\n--- Gradual Liquidity Increase ---");
        EnhancedConsoleLib.plotAsciiChart(liquidityData);
        console.log("--- End Gradual Liquidity Increase ---");

        // Second scenario: Liquidity spike and drop
        uint256[] memory liquidityDropData = new uint256[](15);
        initialLiquidity = 10_000;
        for (uint256 i = 0; i < liquidityDropData.length; i++) {
            liquidityDropData[i] =
                initialLiquidity + (i < 10 ? i * liquidityStep : (10 - (i - 10)) * liquidityStep);
        }

        console.log("\n--- Liquidity Spike and Drop ---");
        EnhancedConsoleLib.plotAsciiChart(liquidityDropData);
        console.log("--- End Liquidity Spike and Drop ---");
    }

    function testPlotGasUsageSpike() public pure {
        // Simulate gas usage patterns with a spike
        uint256[] memory gasUsageData = new uint256[](12);
        for (uint256 i = 0; i < gasUsageData.length; i++) {
            gasUsageData[i] = 50_000 + (i * 1000); // Gradually increasing base gas cost
            if (i == 5) {
                gasUsageData[i] = 250_000; // Simulate a gas spike at index 5
            }
        }

        console.log("\n--- Gas Usage Pattern with Spike ---");
        EnhancedConsoleLib.plotAsciiChart(gasUsageData, 15); // Taller chart for better detail
        console.log("--- End Gas Usage Pattern ---");
    }

    function testVisualizeStateMachine() public pure {
        // Test state machine visualization with a simple lending protocol state machine
        string[] memory states = new string[](4);
        states[0] = "Idle";
        states[1] = "Active";
        states[2] = "Paused";
        states[3] = "Liquidated";

        EnhancedConsoleLib.Transition[] memory transitions = new EnhancedConsoleLib.Transition[](4);

        // Idle -> Active (deposit)
        transitions[0] = EnhancedConsoleLib.Transition({
            fromStateIndex: 0,
            toStateIndex: 1,
            triggerEvent: "deposit()"
        });

        // Active -> Paused (emergency pause)
        transitions[1] = EnhancedConsoleLib.Transition({
            fromStateIndex: 1,
            toStateIndex: 2,
            triggerEvent: "pause()"
        });

        // Paused -> Active (resume)
        transitions[2] = EnhancedConsoleLib.Transition({
            fromStateIndex: 2,
            toStateIndex: 1,
            triggerEvent: "resume()"
        });

        // Active -> Liquidated (health check failed)
        transitions[3] = EnhancedConsoleLib.Transition({
            fromStateIndex: 1,
            toStateIndex: 3,
            triggerEvent: "liquidate()"
        });

        console.log("\n--- Lending Protocol State Machine ---");
        EnhancedConsoleLib.visualizeStateMachine(states, transitions);
        console.log("--- End State Machine ---");
    }

    function testVisualizeTokenFlow() public pure {
        // Test token flow visualization with a DEX swap scenario
        EnhancedConsoleLib.TokenFlow[] memory flows = new EnhancedConsoleLib.TokenFlow[](3);

        // User sends USDC to DEX
        flows[0] = EnhancedConsoleLib.TokenFlow({
            fromEntityName: "User",
            toEntityName: "DEX",
            tokenSymbol: "USDC",
            amount: 1000
        });

        // DEX sends DAI to User
        flows[1] = EnhancedConsoleLib.TokenFlow({
            fromEntityName: "DEX",
            toEntityName: "User",
            tokenSymbol: "DAI",
            amount: 980
        });

        // DEX sends fee to Treasury
        flows[2] = EnhancedConsoleLib.TokenFlow({
            fromEntityName: "DEX",
            toEntityName: "Treasury",
            tokenSymbol: "USDC",
            amount: 20
        });

        console.log("\n--- DEX Swap Token Flow ---");
        EnhancedConsoleLib.visualizeTokenFlow(flows);
        console.log("--- End Token Flow ---");
    }

    function testVisualizeRiskGauge() public pure {
        console.log("\n--- Collateral Health Check ---");

        // Test healthy collateral ratio
        EnhancedConsoleLib.visualizeRiskGauge(
            "Collateral Ratio",
            180, // Current value: 180%
            150, // Min required: 150%
            300, // Max healthy: 300%
            true // Higher is better
        );

        console.log("\n--- Utilization Rate Check ---");

        // Test concerning utilization rate
        EnhancedConsoleLib.visualizeRiskGauge(
            "Pool Utilization",
            85, // Current value: 85%
            0, // Min: 0%
            80, // Max healthy: 80%
            false // Lower is better
        );
    }

    function testVisualizeBalanceChange() public pure {
        console.log("\n--- Balance Change Visualization ---");

        // Test increase in balance
        EnhancedConsoleLib.visualizeBalanceChange("Alice", "ETH", 1 ether);

        // Test decrease in balance
        EnhancedConsoleLib.visualizeBalanceChange("Bob", "USDC", -500);

        // Test no change in balance
        EnhancedConsoleLib.visualizeBalanceChange("Treasury", "DAI", 0);

        // Test large number formatting
        EnhancedConsoleLib.visualizeBalanceChange("Whale", "USDT", 1_000_000);

        console.log("--- End Balance Change Visualization ---");
    }

    function testVisualizeValueProgression() public pure {
        console.log("\n--- Value Progression Examples ---");

        // Test staking progression scenario
        EnhancedConsoleLib.StepValue[] memory stakingSteps = new EnhancedConsoleLib.StepValue[](4);

        stakingSteps[0] = EnhancedConsoleLib.StepValue({label: "Initial Stake", value: 100 ether});

        stakingSteps[1] = EnhancedConsoleLib.StepValue({label: "After Rewards", value: 110 ether});

        stakingSteps[2] = EnhancedConsoleLib.StepValue({label: "Second Stake", value: 210 ether});

        stakingSteps[3] = EnhancedConsoleLib.StepValue({label: "Final Balance", value: 231 ether});

        EnhancedConsoleLib.visualizeValueProgression("Staking Progress", stakingSteps);

        // Test pool utilization scenario
        EnhancedConsoleLib.StepValue[] memory utilizationSteps =
            new EnhancedConsoleLib.StepValue[](5);

        utilizationSteps[0] = EnhancedConsoleLib.StepValue({label: "Start", value: 20});

        utilizationSteps[1] = EnhancedConsoleLib.StepValue({label: "After Deposit", value: 45});

        utilizationSteps[2] = EnhancedConsoleLib.StepValue({label: "Peak Usage", value: 85});

        utilizationSteps[3] = EnhancedConsoleLib.StepValue({label: "After Withdraw", value: 60});

        utilizationSteps[4] = EnhancedConsoleLib.StepValue({label: "End of Day", value: 35});

        EnhancedConsoleLib.visualizeValueProgression(
            "Pool Utilization %",
            utilizationSteps,
            30 // Shorter bars for percentage values
        );

        console.log("--- End Value Progression Examples ---");
    }

    function testVisualizeSlippage() public pure {
        console.log("\n--- Slippage Visualization Examples ---");

        // Test slippage within allowed limit
        console.log("Case 1: Slippage within allowed limit");
        EnhancedConsoleLib.visualizeSlippage(
            50, // 0.50% actual slippage
            100 // 1.00% allowed slippage
        );

        console.log("\nCase 2: Slippage at exactly allowed limit");
        EnhancedConsoleLib.visualizeSlippage(
            100, // 1.00% actual slippage
            100 // 1.00% allowed slippage
        );

        console.log("\nCase 3: Slippage exceeding allowed limit");
        EnhancedConsoleLib.visualizeSlippage(
            150, // 1.50% actual slippage
            100 // 1.00% allowed slippage
        );

        console.log("\nCase 4: High precision slippage");
        EnhancedConsoleLib.visualizeSlippage(
            123, // 1.23% actual slippage
            500 // 5.00% allowed slippage
        );

        console.log("\nCase 5: Zero allowed slippage");
        EnhancedConsoleLib.visualizeSlippage(
            10, // 0.10% actual slippage
            0 // 0.00% allowed slippage
        );

        console.log("--- End Slippage Visualization Examples ---");
    }

    function testPlotHorizontalBarChart() public pure {
        console.log("\n--- Portfolio Allocation Example ---");

        // Test token portfolio allocation
        string[] memory tokens = new string[](5);
        tokens[0] = "ETH";
        tokens[1] = "USDC";
        tokens[2] = "WBTC";
        tokens[3] = "DAI";
        tokens[4] = "UNI";

        uint256[] memory balances = new uint256[](5);
        balances[0] = 100 ether; // 100 ETH
        balances[1] = 50_000; // 50,000 USDC
        balances[2] = 5 ether; // 5 WBTC
        balances[3] = 75_000; // 75,000 DAI
        balances[4] = 2500; // 2,500 UNI

        EnhancedConsoleLib.plotHorizontalBarChart(tokens, balances);

        console.log("\n--- Gas Usage by Function Example ---");

        // Test gas usage comparison
        string[] memory functions = new string[](4);
        functions[0] = "deposit()";
        functions[1] = "withdraw()";
        functions[2] = "stake()";
        functions[3] = "claim()";

        uint256[] memory gasUsage = new uint256[](4);
        gasUsage[0] = 120_000; // 120k gas
        gasUsage[1] = 85_000; // 85k gas
        gasUsage[2] = 160_000; // 160k gas
        gasUsage[3] = 45_000; // 45k gas

        EnhancedConsoleLib.plotHorizontalBarChart(
            functions,
            gasUsage,
            30 // Shorter bars for gas usage
        );

        console.log("--- End Horizontal Bar Chart Examples ---");
    }
}
