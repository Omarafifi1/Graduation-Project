module control_unit #(parameter address_width = 4)(
	input clk , rst_n,

	input start,
	input ntt_logic_enable,intt_logic_enable,

	output reg buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1,
	output reg buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2,
	output reg buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3,
	output reg buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4,
	
    output  reg a_mod_add_out_mux_sel,
    output  reg b_reg4_mux_sel,
    output  reg mod_add_out_reg4_mux_sel,
    output  reg b_mod_sub_out_mux_sel,
    output  reg a_mod_mul_out_mux_sel,
    output  reg mod_sub_out_mod_mul_out_mux_sel,

	output reg ntt_tw_factor_2nd_stage_mux_sel,
	output reg [1:0]ntt_tw_factor_3rd_stage_mux_sel,
	output reg [2:0]ntt_tw_factor_4th_stage_mux_sel,

	output reg [2:0]intt_tw_factor_1st_stage_mux_sel,
	output reg [1:0]intt_tw_factor_2nd_stage_mux_sel,
	output reg intt_tw_factor_3rd_stage_mux_sel,

	output reg buffer_enable, 
	output reg [address_width-1:0]out_address, in_address,
	output done_tick , data_valid , busy
);

reg [5:0]counter ;

always @(*) begin
	case ({ntt_logic_enable , intt_logic_enable})
		2'b01: begin
			a_mod_add_out_mux_sel=1'b1;
			b_reg4_mux_sel=1'b1;
			mod_add_out_reg4_mux_sel=1'b1;
			b_mod_sub_out_mux_sel=1'b1;
			a_mod_mul_out_mux_sel=1'b1;
			mod_sub_out_mod_mul_out_mux_sel=1'b1;
		end
		2'b10: begin
			a_mod_add_out_mux_sel=1'b0;
			b_reg4_mux_sel=1'b0;
			mod_add_out_reg4_mux_sel=1'b0;
			b_mod_sub_out_mux_sel=1'b0;
			a_mod_mul_out_mux_sel=1'b0;
			mod_sub_out_mod_mul_out_mux_sel=1'b0;
		end 
		default: begin
			a_mod_add_out_mux_sel=1'bx;
			b_reg4_mux_sel=1'bx;
			mod_add_out_reg4_mux_sel=1'bx;
			b_mod_sub_out_mux_sel=1'bx;
			a_mod_mul_out_mux_sel=1'bx;
			mod_sub_out_mod_mul_out_mux_sel=1'bx;
		end
	endcase
end

always @(posedge clk , negedge rst_n) begin
	if(!rst_n) begin
		counter<=6'd0;	
	end

	else if(done_tick)begin
		counter<=6'd0;
	end
	else if((start && !busy) ||busy) begin
		counter<=counter+1;
	end
	else if (!start) begin
		counter<=6'd0;
	end

end

always @(*) begin
case (counter)
    6'd0: in_address = counter;
    6'd1: in_address = counter;
    6'd2: in_address = counter;
    6'd3: in_address = counter;
    6'd4: in_address = counter;
    6'd5: in_address = counter;
    6'd6: in_address = counter;
    6'd7: in_address = counter;
    6'd8: in_address = counter;
    6'd9: in_address = counter;
    6'd10: in_address = counter;
    6'd11: in_address = counter;
    6'd12: in_address = counter;
    6'd13: in_address = counter;
    6'd14: in_address = counter;
    6'd15: in_address = counter;
    default: in_address = 4'd0;
endcase
end
always @(*) begin
    case (counter)
        6'd36: out_address = 4'd0;
        6'd37: out_address = 4'd8;
        6'd38: out_address = 4'd4;
        6'd39: out_address = 4'd12;
        6'd40: out_address = 4'd2;
        6'd41: out_address = 4'd10;
        6'd42: out_address = 4'd6;
        6'd43: out_address = 4'd14;
        6'd48: out_address = 4'd1;
        6'd49: out_address = 4'd9;
        6'd50: out_address = 4'd5;
        6'd51: out_address = 4'd13;
        6'd52: out_address = 4'd3;
        6'd53: out_address = 4'd11;
        6'd54: out_address = 4'd7;
        6'd55: out_address = 4'd15;
        default: out_address = 4'd0;
    endcase
end


always @(*) begin
    case (counter)
        6'd2, 6'd3, 6'd4, 6'd5, 6'd6, 6'd7, 6'd8, 6'd9: begin
            {buffer_out_mux_selector_stage1, buffer_in_mux_selector_stage1} = 2'bx1;
        end
        6'd10, 6'd11, 6'd12, 6'd13, 6'd22, 6'd23, 6'd24, 6'd25, 
        6'd34, 6'd35, 6'd36, 6'd37, 6'd38, 6'd39, 6'd40, 6'd41,
        6'd42, 6'd43, 6'd44, 6'd45, 6'd46, 6'd47, 6'd48, 6'd49,
        6'd50, 6'd51, 6'd52: begin
            {buffer_out_mux_selector_stage1, buffer_in_mux_selector_stage1} = 2'bxx;
        end
        6'd14, 6'd15, 6'd16, 6'd17, 6'd18, 6'd19, 6'd20, 6'd21: begin
            {buffer_out_mux_selector_stage1, buffer_in_mux_selector_stage1} = 2'b10;
        end
        6'd26, 6'd27, 6'd28, 6'd29, 6'd30, 6'd31, 6'd32, 6'd33: begin
            {buffer_out_mux_selector_stage1, buffer_in_mux_selector_stage1} = 2'b0x;
        end
        default: begin
            {buffer_out_mux_selector_stage1, buffer_in_mux_selector_stage1} = 2'bxx;
        end
    endcase

case (counter)
	6'd15, 6'd16, 6'd17, 6'd18 : begin
		{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2} = 2'bx1;
	end
	6'd3, 6'd4, 6'd5, 6'd6, 6'd7, 6'd8, 6'd9, 6'd10, 6'd11, 6'd12, 6'd13, 6'd14, 
	6'd19, 6'd20, 6'd21, 6'd22,
	6'd31, 6'd32, 6'd33, 6'd34,
	6'd43, 6'd44, 6'd45, 6'd46, 6'd47, 6'd48, 6'd49, 6'd50, 6'd51, 6'd52, 6'd53: begin
		{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2} = 2'bxx;
	end

	6'd23, 6'd24, 6'd25, 6'd26,
	6'd35, 6'd36, 6'd37, 6'd38: begin
		{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2} = 2'b10;
	end
	6'd39, 6'd40, 6'd41, 6'd42: begin
		{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2} = 2'b0x;
	end
	6'd27, 6'd28, 6'd29, 6'd30: begin
		{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2} = 2'b01;
	end
	default: begin
		{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2} = 2'bxx;
	end
endcase

case (counter)
	6'd24, 6'd25,
	6'd28, 6'd29,
	6'd40, 6'd41: begin
		{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3} = 2'bx1;
	end
	6'd4, 6'd5, 6'd6, 6'd7, 6'd8, 6'd9, 6'd10, 6'd11, 6'd12, 6'd13, 6'd14, 6'd15, 6'd16, 6'd17, 6'd19, 6'd21, 6'd22, 6'd23,
	6'd26, 6'd27,
	6'd38, 6'd39,
	6'd50, 6'd51, 6'd52, 6'd53, 6'd54: begin
		{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3} = 2'bxx;
	end
	6'd30, 6'd31,
	6'd34, 6'd35,
	6'd42, 6'd43,
	6'd46, 6'd47: begin
		{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3} = 2'b10;
	end
	6'd32, 6'd33,
	6'd44, 6'd45,
	6'd48, 6'd49: begin
		{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3} = 2'b0x;
	end
	6'd36, 6'd37: begin
		{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3} = 2'b01;
	end
	default: begin
		{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3} = 2'bxx;
	end
endcase

case (counter)
	6'd31, 6'd33, 6'd35, 6'd45, 6'd47: begin
		{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4} = 2'bx1;
	end
	6'd5, 6'd6, 6'd7, 6'd8, 6'd9, 6'd10, 6'd11, 6'd12, 6'd13, 
	6'd14, 6'd15, 6'd16, 6'd17, 6'd18, 6'd19, 6'd20, 6'd21, 
	6'd22, 6'd23, 6'd24, 6'd25, 6'd26, 6'd27, 6'd28, 6'd29, 6'd30,
	6'd32, 6'd34, 6'd44, 6'd46: begin
		{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4} = 2'bxx;
	end
	6'd36, 6'd38, 6'd40, 6'd42, 6'd48, 6'd50, 6'd52, 6'd54: begin
		{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4} = 2'b10;
	end
	6'd39, 6'd41, 6'd51, 6'd53, 6'd55: begin
		{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4} = 2'b0x;
	end
	6'd37, 6'd43, 6'd49: begin
		{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4} = 2'b01;
	end
	default: begin
		{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4} = 2'bxx;
	end
endcase

case (counter)
	6'd31, 6'd32, 6'd33, 6'd34, 6'd35, 6'd36, 6'd37, 6'd38, 6'd39, 
	6'd40, 6'd41, 6'd42, 6'd43, 6'd44, 6'd45, 6'd46, 6'd47, 6'd48, 
	6'd49, 6'd50, 6'd51, 6'd52, 6'd53: begin
		ntt_tw_factor_2nd_stage_mux_sel = 1'd1;
	end 
	default: ntt_tw_factor_2nd_stage_mux_sel = 1'd0;
endcase

case (counter)
	6'd30 ,6'd31 ,6'd32 ,6'd33 ,6'd34 ,6'd35 ,6'd36 ,6'd37 : ntt_tw_factor_3rd_stage_mux_sel = 2'd1;
	6'd38 ,6'd39 ,6'd40 ,6'd41: ntt_tw_factor_3rd_stage_mux_sel = 2'd2;
	6'd42, 6'd43, 6'd44, 6'd45, 6'd46, 6'd47, 6'd48, 6'd49, 
	6'd50, 6'd51, 6'd52, 6'd53, 6'd54: ntt_tw_factor_3rd_stage_mux_sel = 2'd3;
	default: ntt_tw_factor_3rd_stage_mux_sel = 2'd0;
endcase

case (counter)
	6'd34 ,6'd35: ntt_tw_factor_4th_stage_mux_sel = 3'd1;
	6'd36 ,6'd37: ntt_tw_factor_4th_stage_mux_sel = 3'd2;
	6'd38 ,6'd39 ,6'd40 ,6'd41 ,6'd42 ,6'd43: ntt_tw_factor_4th_stage_mux_sel = 3'd3;
	6'd44 ,6'd45: ntt_tw_factor_4th_stage_mux_sel = 3'd4;
	6'd46 ,6'd47: ntt_tw_factor_4th_stage_mux_sel = 3'd5;
	6'd48 ,6'd49: ntt_tw_factor_4th_stage_mux_sel = 3'd6;
	6'd50 ,6'd51, 6'd52, 6'd53, 6'd54, 6'd55: ntt_tw_factor_4th_stage_mux_sel = 3'd7;
	default: ntt_tw_factor_4th_stage_mux_sel = 3'd0;
endcase

case (counter)
	6'd27, 6'd31, 6'd39, 6'd43: intt_tw_factor_3rd_stage_mux_sel = 1'd1; 
	default: intt_tw_factor_3rd_stage_mux_sel = 1'd0;
endcase

case (counter)
	6'd20, 6'd32 : intt_tw_factor_2nd_stage_mux_sel = 2'd1;
	6'd21, 6'd33 : intt_tw_factor_2nd_stage_mux_sel = 2'd2;
	6'd22, 6'd34 : intt_tw_factor_2nd_stage_mux_sel = 2'd3;
	default      : intt_tw_factor_2nd_stage_mux_sel = 2'd0;
endcase

case (counter)
	6'd11   : intt_tw_factor_1st_stage_mux_sel = 3'd1;
	6'd12   : intt_tw_factor_1st_stage_mux_sel = 3'd2;
	6'd13   : intt_tw_factor_1st_stage_mux_sel = 3'd3;
	6'd14   : intt_tw_factor_1st_stage_mux_sel = 3'd4;
	6'd15   : intt_tw_factor_1st_stage_mux_sel = 3'd5;
	6'd16   : intt_tw_factor_1st_stage_mux_sel = 3'd6;
	6'd17   : intt_tw_factor_1st_stage_mux_sel = 3'd7;
	default : intt_tw_factor_1st_stage_mux_sel = 3'd0;
endcase

case (counter)
	6'd22, 6'd23, 6'd24, 6'd25: begin
		buffer_enable = 1'b0;
	end
	default: begin
		buffer_enable = 1'b1;
	end		
endcase

end





assign data_valid=( (counter>=6'd36 && counter <=6'd43) || (counter>=6'd48 && counter <=6'd55) ) ;
assign done_tick=(counter ==6'd55) ;
assign busy = (counter!=6'd0);

endmodule