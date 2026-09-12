module tb_signed_multiplier_8bit;

    reg  signed [7:0] a;
    reg  signed [7:0] b;

    wire [15:0] product;
    wire cout;

    integer i;
    integer j;
    integer expected;
    integer error_count;
    integer test_count;

    // Instantiate the multiplier
    
    signed_multiplier_8bit uut (
        .a(a),
        .b(b),
        .product(product),
        .cout(cout)
    );

    initial begin

        error_count = 0;
        test_count  = 0;

        $display("==============================================");
        $display("   EXHAUSTIVE TEST OF 8-BIT SIGNED MULTIPLIER");
        $display("==============================================");
        $display("Testing all 65536 combinations...");
        $display("");

        // a goes from -128 to +127
        for (i = -128; i <= 127; i = i + 1) begin

            // b goes from -128 to +127
            for (j = -128; j <= 127; j = j + 1) begin

                // Apply inputs
                a = i;
                b = j;

                // Wait for combinational circuit to settle
                #1;

                // Expected result
                expected = i * j;

                test_count = test_count + 1;

                // Compare DUT output with expected result
                if ($signed(product) != expected) begin

                    error_count = error_count + 1;

                    $display("ERROR:");
                    $display("a = %d, b = %d", i, j);
                    $display("Expected = %d", expected);
                    $display("Actual   = %d", $signed(product));
                    $display("----------------------------------------------");

                end

            end

            // Show progress after each value of a
            $display("Completed a = %d   Tests = %d   Errors = %d",
                     i, test_count, error_count);

        end

        // Final result
       
        $display("");
        $display("==============================================");
        $display("             TESTING COMPLETED");
        $display("==============================================");

        $display("Total tests  = %d", test_count);
        $display("Total errors = %d", error_count);

        if (error_count == 0) begin
            $display("      ALL 65536 TESTS PASSED!             ");
        
        end
        else begin
            $display("       TEST FAILED                         ");
        end

        $finish;

    end

endmodule
