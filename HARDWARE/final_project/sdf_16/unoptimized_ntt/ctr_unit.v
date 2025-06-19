module control_unit(
	input clk , rst_n,
	input enable,
	output reg buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1,
	output reg buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2,
	output reg buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3,
	output reg buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4,
	output reg tw_factor_2nd_stage_mux_sel,
	output reg [1:0]tw_factor_3rd_stage_mux_sel,
	output reg [2:0]tw_factor_4th_stage_mux_sel,
	output reg done_tick
);

reg [4:0]counter ;

always @(posedge clk , negedge rst_n) begin
	if(!rst_n) begin
		counter<=0;	
	end
	else if(enable)begin
		counter<=counter+1;
	end
end

always @(*) begin
	done_tick=0;
	tw_factor_2nd_stage_mux_sel=1'b0;
	tw_factor_3rd_stage_mux_sel=2'd0;
	tw_factor_4th_stage_mux_sel=3'd0;
	case (counter)
		5'd0,5'd1,5'd2,5'd3,5'd4,5'd5,5'd6,5'd7:begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'bx1;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bxx;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'bxx;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'bxx;
		end
		5'd8: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b10;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bx1;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'bxx;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'bxx;

		end
		5'd9: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b10;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bx1;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'bxx;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'bxx;

		end
		5'd10: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b10;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bx1;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'bxx;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'bxx;

		end 
		5'd11: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b10;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bx1;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'bxx;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'bxx;
		end
		5'd12: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b10;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b10;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'bx1;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'bxx;
		end
		5'd13: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b10;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b10;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'bx1;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'bxx;
		end 
		5'd14: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b10;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b10;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b10;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'bx1;
		end	
		5'd15: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b10;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b10;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b10;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b10;
		end	
		5'd16: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b01;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b01;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b01;
		end	
		5'd17: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b01;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b01;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b10;
			tw_factor_4th_stage_mux_sel=3'd1;
		end	
		5'd18: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b01;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b10;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b01;
			tw_factor_3rd_stage_mux_sel=2'd1;
			tw_factor_4th_stage_mux_sel=3'd1;
		end	
		5'd19: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b01;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b10;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b10;
			tw_factor_3rd_stage_mux_sel=2'd1;
			tw_factor_4th_stage_mux_sel=3'd2;
		end	
		5'd20: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b10;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b01;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b01;
			tw_factor_2nd_stage_mux_sel=1'b1;
			tw_factor_3rd_stage_mux_sel=2'd1;
			tw_factor_4th_stage_mux_sel=3'd2;
		end	
		5'd21: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b10;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b01;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b10;
			tw_factor_2nd_stage_mux_sel=1'b1;
			tw_factor_3rd_stage_mux_sel=2'd1;
			tw_factor_4th_stage_mux_sel=3'd3;
		end	
		5'd22: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b10;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b10;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b01;
			tw_factor_2nd_stage_mux_sel=1'b1;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_4th_stage_mux_sel=3'd3;
		end	
		5'd23: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b10;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b10;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b10;
			tw_factor_2nd_stage_mux_sel=1'b1;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_4th_stage_mux_sel=3'd4;
		end	
		5'd24: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'bxx;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b0x;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b01;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b01;
			tw_factor_2nd_stage_mux_sel=1'b1;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_4th_stage_mux_sel=3'd4;
		end	
		5'd25: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'bxx;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b0x;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b01;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b10;
			tw_factor_2nd_stage_mux_sel=1'b1;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_4th_stage_mux_sel=3'd5;
		end	
		5'd26: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'bxx;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b0x;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b10;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b01;
			tw_factor_2nd_stage_mux_sel=1'b1;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_4th_stage_mux_sel=3'd5;
		end	
		5'd27: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'bxx;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b0x;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b10;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b10;
			tw_factor_2nd_stage_mux_sel=1'b1;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_4th_stage_mux_sel=3'd6;
		end	
		5'd28: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'bxx;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bxx;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b0x;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b01;
			tw_factor_2nd_stage_mux_sel=1'b1;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_4th_stage_mux_sel=3'd6;
		end	
		5'd29: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'bxx;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bxx;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b0x;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b10;
			tw_factor_2nd_stage_mux_sel=1'b1;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_4th_stage_mux_sel=3'd7;
		end	
		5'd30: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'bxx;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bxx;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'bxx;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b0x;
			tw_factor_2nd_stage_mux_sel=1'b1;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_4th_stage_mux_sel=3'd7;
			done_tick=1;
		end	
		5'd31: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'bxx;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bxx;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'bxx;
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'bxx;
			tw_factor_2nd_stage_mux_sel=1'b1;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_4th_stage_mux_sel=3'd7;
			done_tick=1;
		end	
	endcase
end

endmodule