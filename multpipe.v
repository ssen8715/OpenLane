module multpipe (clk, rst, mpcd, mplr, result);
	input clk, rst;
	input [3:0] mpcd, mplr; 
	output [7:0] result;

	reg [4:0] result_stg1; 
	reg [5:0] result_stg2; 
	reg [6:0] result_stg3; 
	reg [7:0] result_stg4;
	reg [3:0] mplr_stg0; 
	reg [4:0] mplr_stg1; 
	reg [5:0] mplr_stg2; 
	reg [6:0] mplr_stg3;
	reg [3:0] mpcd_stg0; 
	reg [4:0] mpcd_stg1; 
	reg [5:0] mpcd_stg2; 
	reg [6:0] mpcd_stg3;
	
	assign result = result_stg4;
	
	always @(posedge clk) begin 
		if (rst) begin 
			mpcd_stg0 <= 0;
			mplr_stg0 <= 0; 
			end 
			else begin 
			mpcd_stg0 <= mpcd; 
			mplr_stg0 <= mplr; 
			end 
		end
	always @ (posedge clk) begin
	if (rst) begin
		result_stg1 <= 0; 
		result_stg2 <= 0; 
		result_stg3 <= 0; 
		result_stg4 <= 0;
		mpcd_stg1 <= 0; 
		mpcd_stg2 <= 0; 
		mpcd_stg3 <= 0; 
		mplr_stg1 <= 0; 
		mplr_stg2 <= 0; 
		mplr_stg3 <= 0;
	end
	else begin
	result_stg1 <= mplr_stg0[0] ? mpcd_stg0: 4'b0;
	mpcd_stg1 <= {mpcd_stg0,1'b0}; 
	mplr_stg1 <= mplr_stg0;
	result_stg2 <= mplr_stg1[1] ? (result_stg1 + mpcd_stg1): result_stg1; 
	mpcd_stg2 <= {mpcd_stg1,1'b0}; 
	mplr_stg2 <= mplr_stg1;
	result_stg3 <= mplr_stg2[2] ? (result_stg2+ mpcd_stg2): result_stg2; 
	mpcd_stg3 <= {mpcd_stg2,1'b0};
	mplr_stg3 <= mplr_stg2;
	result_stg4 <= mplr_stg3[3] ? (result_stg3+ mpcd_stg3): result_stg3;
	end
end endmodule