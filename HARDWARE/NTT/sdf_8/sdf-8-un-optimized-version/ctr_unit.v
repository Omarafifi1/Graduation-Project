module control_unit(
	input clk , rst_n,
	input enable,
	output reg buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1,
	output reg buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2,
	output reg buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3,
	output reg tw_factor_2nd_stage_mux_sel,
	output reg [1:0]tw_factor_3rd_stage_mux_sel,
	output reg done_tick
);

reg [3:0]counter ;

always @(posedge clk , negedge rst_n) begin
	if(!rst_n) begin
		counter<=0;	
	end
	else if(enable)begin
		counter<=counter+1;
	end
end

always @(*) begin
	{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'bx1;
	{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bxx;
	{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b0x;
	tw_factor_2nd_stage_mux_sel=1'b0;
	tw_factor_3rd_stage_mux_sel=2'd0;
	done_tick=0;
	case (counter)
		4'd4: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b10;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bx1;
		end
		4'd5: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b10;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bx1;			
		end
		4'd6: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b10;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b10;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'bx1;
		end
		4'd7: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b10;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b10;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b10;
		end 
		4'd8: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b01;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b01;
		end
		4'd9: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b01;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b10;
			tw_factor_3rd_stage_mux_sel=2'd1;
		end
		4'd10: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b10;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b01;	
			tw_factor_2nd_stage_mux_sel=1'b1;	
			tw_factor_3rd_stage_mux_sel=2'd1;	
		end 
		4'd11: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b10;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b10;		
			tw_factor_2nd_stage_mux_sel=1'b1;	
			tw_factor_3rd_stage_mux_sel=2'd2;
		end
		4'd12: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b0x;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b01;	
			tw_factor_2nd_stage_mux_sel=1'b1;
			tw_factor_3rd_stage_mux_sel=2'd2;		
		end
		4'd13: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b0x;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b10;	
			tw_factor_2nd_stage_mux_sel=1'b1;
			tw_factor_3rd_stage_mux_sel=2'd3;		
		end 
		4'd14: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b0x;
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b0x;	
			tw_factor_2nd_stage_mux_sel=1'b1;
			tw_factor_3rd_stage_mux_sel=2'd3;
			done_tick=1;			
		end	
	endcase
end

endmodule