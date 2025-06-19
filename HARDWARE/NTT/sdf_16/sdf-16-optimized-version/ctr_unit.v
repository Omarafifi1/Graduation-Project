module control_unit(
	input clk , rst_n,
	input start,
	output reg buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1,
	output reg buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2,
	output reg buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3,
	output reg buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4,
	output reg tw_factor_2nd_stage_mux_sel,
	output reg [1:0]tw_factor_3rd_stage_mux_sel,
	output reg [2:0]tw_factor_4th_stage_mux_sel,
	output reg buffer_enable,
	output done_tick
);

reg [5:0]counter ;

always @(posedge clk , negedge rst_n) begin
	if(!rst_n) begin
		counter<=0;	
	end
	else if(start)begin
		counter<=counter+1;
	end
end

always @(*) begin
	case (counter)
		6'd0, 6'd1, 6'd2, 6'd3,6'd4,6'd5,6'd6,6'd7:begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'bx1;
		end
		6'd8 ,6'd9, 6'd10, 6'd11,6'd20, 6'd21, 6'd22, 6'd23,6'd32, 6'd33, 6'd34, 6'd35, 6'd36, 6'd37, 6'd38, 6'd39, 6'd40, 
		6'd41, 6'd42, 6'd43, 6'd44, 6'd45, 6'd46, 6'd47, 6'd48, 6'd49, 6'd50:begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'bxx;
		end
		6'd12,6'd13,6'd14,6'd15,6'd16 ,6'd17 ,6'd18 ,6'd19:begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b10;
		end
		6'd24,6'd25 ,6'd26 ,6'd27 ,6'd28 ,6'd29 ,6'd30 ,6'd31:begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
		end
		default:begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'bxx;
		end
	endcase


	case (counter)
		6'd12,6'd13,6'd14 ,6'd15 :begin
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bx1;
		end
		6'd0,6'd1,6'd2,6'd3,6'd4,6'd5,6'd6,6'd7,6'd8,6'd9,6'd10 ,6'd11, 
		6'd16 , 6'd17,6'd18 ,6'd19,
		6'd28, 6'd29, 6'd30, 6'd31,
		6'd40,6'd41, 6'd42, 6'd43, 6'd44, 6'd45, 6'd46, 6'd47, 6'd48, 6'd49, 6'd50:begin
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bxx;
		end

		6'd20 ,6'd21 ,6'd22 ,6'd23,
		6'd32, 6'd33, 6'd34, 6'd35:begin
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b10;
		end
		6'd36, 6'd37, 6'd38, 6'd39:begin
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b0x;
		end
		6'd24,6'd25 ,6'd26 ,6'd27:begin
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b01;
		end
		default:begin
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bxx;
		end
	endcase

	case (counter)
		6'd20 ,6'd21,
		6'd24 ,6'd25 ,
		6'd36, 6'd37:begin
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'bx1;
		end
		6'd0,6'd1,6'd2,6'd3,6'd4,6'd5,6'd6,6'd7,6'd8,6'd9,6'd10 ,6'd11 ,6'd12,6'd13 ,6'd15 ,6'd17 ,6'd18 ,6'd19,
		6'd22 ,6'd23,
		6'd34 ,6'd35,
		6'd46 ,6'd47, 6'd48, 6'd49 ,6'd50:begin
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'bxx;
		end
		6'd26 ,6'd27,
		6'd30 ,6'd31,
		6'd38 ,6'd39,
		6'd42 ,6'd43:begin
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b10;
		end
		6'd28 ,6'd29,
		6'd40 ,6'd41,
		6'd44 ,6'd45:begin
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b0x;
		end
		6'd32 ,6'd33:begin
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b01;
		end
		default:begin
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'bxx;
		end
	endcase


	case (counter)
		6'd26 ,6'd28 ,6'd30 ,6'd40 ,6'd42:begin
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'bx1;
		end
		6'd0, 6'd1, 6'd2, 6'd3, 6'd4, 6'd5, 6'd6, 6'd7, 6'd8, 
		6'd9, 6'd10, 6'd11, 6'd12, 6'd13, 6'd14, 6'd15, 6'd16, 
		6'd17, 6'd18, 6'd19, 6'd20, 6'd21, 6'd22, 6'd23, 6'd24, 6'd25,
		6'd27 , 6'd29  , 6'd39 , 6'd41:begin
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'bxx;
		end
		6'd31 ,6'd33 ,6'd35 ,6'd37 ,6'd43 ,6'd45 ,6'd47 ,6'd49:begin
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b10;
		end
		6'd34  ,6'd36 ,6'd46 ,6'd48 ,6'd50:begin
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b0x;
		end
		6'd32 ,6'd38 ,6'd44:begin
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b01;
		end
		default:begin
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'bxx;
		end
	endcase



	case (counter)
		6'd28, 6'd29, 6'd30, 6'd31, 6'd32, 6'd33, 6'd34, 6'd35, 6'd36, 
		6'd37, 6'd38, 6'd39, 6'd40, 6'd41, 6'd42, 6'd43, 6'd44, 6'd45, 
		6'd46, 6'd47, 6'd48, 6'd49, 6'd50:begin
			tw_factor_2nd_stage_mux_sel=1'd1;
		end 
		default: tw_factor_2nd_stage_mux_sel=1'd0;
	endcase

	case (counter)
		6'd26 ,6'd27 ,6'd28 ,6'd29 ,6'd30 ,6'd31 ,6'd32 ,6'd33 : tw_factor_3rd_stage_mux_sel=2'd1;
		6'd34 ,6'd35 ,6'd36 ,6'd37: tw_factor_3rd_stage_mux_sel=2'd2;
		6'd38, 6'd39, 6'd40, 6'd41, 6'd42, 6'd43, 6'd44, 6'd45, 
		6'd46, 6'd47, 6'd48, 6'd49, 6'd50: tw_factor_3rd_stage_mux_sel=2'd3;
		default: tw_factor_3rd_stage_mux_sel=2'd0;
	endcase


	case (counter)
		6'd29 ,6'd30:tw_factor_4th_stage_mux_sel=3'd1;
		6'd31 ,6'd32:tw_factor_4th_stage_mux_sel=3'd2;
		6'd33 ,6'd34 ,6'd35 ,6'd36 ,6'd37 ,6'd38:tw_factor_4th_stage_mux_sel=3'd3;
		6'd39 ,6'd40:tw_factor_4th_stage_mux_sel=3'd4;
		6'd41 ,6'd42:tw_factor_4th_stage_mux_sel=3'd5;
		6'd43 ,6'd44:tw_factor_4th_stage_mux_sel=3'd6;
		6'd45 ,6'd46, 6'd47, 6'd48, 6'd49, 6'd50:tw_factor_4th_stage_mux_sel=3'd7;
		default: tw_factor_4th_stage_mux_sel=3'd0;
	endcase

	case (counter)
		6'd20, 6'd21, 6'd22, 6'd23:begin
			buffer_enable=1'b0;
		end
		default:begin
			buffer_enable=1'b1;
		end		
	endcase
end
assign done_tick=(counter==6'd50);
endmodule