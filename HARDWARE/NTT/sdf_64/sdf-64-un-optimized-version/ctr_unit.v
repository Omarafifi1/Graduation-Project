module control_unit(
	input clk , rst_n,
	input enable,

	output reg buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1,
	output reg buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2,
	output reg buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3,
	output reg buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4,
	output reg buffer_out_mux_selector_stage5 , buffer_in_mux_selector_stage5,
	output reg buffer_out_mux_selector_stage6 , buffer_in_mux_selector_stage6,

	output reg tw_factor_2nd_stage_mux_sel,
	output reg [1:0]tw_factor_3rd_stage_mux_sel,
	output reg [2:0]tw_factor_4th_stage_mux_sel,
	output reg [3:0]tw_factor_5th_stage_mux_sel,
	output reg [4:0]tw_factor_6th_stage_mux_sel,

	output reg done_tick
);

reg [6:0]counter ;

always @(posedge clk , negedge rst_n) begin
	if(!rst_n) begin
		counter<=0;	
	end
	else if(enable)begin
		counter<=counter+1;
	end
end

always @(*) begin

	case (counter)
		7'd0, 7'd1, 7'd2, 7'd3, 7'd4, 7'd5, 7'd6, 7'd7,  
		7'd8, 7'd9, 7'd10, 7'd11, 7'd12, 7'd13, 7'd14, 7'd15,  
		7'd16, 7'd17, 7'd18, 7'd19, 7'd20, 7'd21, 7'd22, 7'd23,  
		7'd24, 7'd25, 7'd26, 7'd27, 7'd28, 7'd29, 7'd30, 7'd31,  
		7'd32, 7'd33, 7'd34, 7'd35, 7'd36, 7'd37, 7'd38, 7'd39,  
		7'd40, 7'd41, 7'd42, 7'd43, 7'd44, 7'd45, 7'd46, 7'd47,  
		7'd48, 7'd49, 7'd50, 7'd51, 7'd52, 7'd53, 7'd54, 7'd55,  
		7'd56, 7'd57, 7'd58, 7'd59, 7'd60, 7'd61: begin
			{buffer_out_mux_selector_stage6 , buffer_in_mux_selector_stage6}=2'bxx;
		end 
		7'd62: begin
			{buffer_out_mux_selector_stage6 , buffer_in_mux_selector_stage6}=2'bx1;
		end
		7'd63, 7'd65, 7'd67, 7'd69, 7'd71, 7'd73, 7'd75, 7'd77, 7'd79, 
		7'd81, 7'd83, 7'd85, 7'd87, 7'd89, 7'd91, 7'd93, 7'd95, 7'd97,
		7'd99, 7'd101, 7'd103, 7'd105, 7'd107, 7'd109, 7'd111, 7'd113,
		7'd115, 7'd117, 7'd119, 7'd121, 7'd123, 7'd125: begin
			{buffer_out_mux_selector_stage6 , buffer_in_mux_selector_stage6}=2'b10;
		end
		7'd64, 7'd66, 7'd68, 7'd70, 7'd72, 7'd74, 7'd76, 7'd78, 7'd80, 
		7'd82, 7'd84, 7'd86, 7'd88, 7'd90, 7'd92, 7'd94, 7'd96, 7'd98,
		7'd100, 7'd102, 7'd104, 7'd106, 7'd108, 7'd110, 7'd112, 7'd114,
		7'd116, 7'd118, 7'd120, 7'd122, 7'd124:begin
			{buffer_out_mux_selector_stage6 , buffer_in_mux_selector_stage6}=2'b01;
		end

		7'd126:begin
			{buffer_out_mux_selector_stage6 , buffer_in_mux_selector_stage6}=2'b0x;
		end
		7'd127: begin
			{buffer_out_mux_selector_stage6 , buffer_in_mux_selector_stage6}=2'bxx;
		end
	endcase


	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	case (counter)
		7'd0, 7'd1, 7'd2, 7'd3, 7'd4, 7'd5, 7'd6, 7'd7,  
		7'd8, 7'd9, 7'd10, 7'd11, 7'd12, 7'd13, 7'd14, 7'd15,  
		7'd16, 7'd17, 7'd18, 7'd19, 7'd20, 7'd21, 7'd22, 7'd23,  
		7'd24, 7'd25, 7'd26, 7'd27, 7'd28, 7'd29, 7'd30, 7'd31,  
		7'd32, 7'd33, 7'd34, 7'd35, 7'd36, 7'd37, 7'd38, 7'd39,  
		7'd40, 7'd41, 7'd42, 7'd43, 7'd44, 7'd45, 7'd46, 7'd47,  
		7'd48, 7'd49, 7'd50, 7'd51, 7'd52, 7'd53, 7'd54, 7'd55,  
		7'd56, 7'd57, 7'd58, 7'd59: begin
			{buffer_out_mux_selector_stage5 , buffer_in_mux_selector_stage5}=2'bxx;
		end 
		7'd60 , 7'd61: begin
			{buffer_out_mux_selector_stage5 , buffer_in_mux_selector_stage5}=2'bx1;
		end
		7'd62, 7'd63, 7'd66, 7'd67, 7'd70, 7'd71, 7'd74, 7'd75, 7'd78, 7'd79,
		7'd82, 7'd83, 7'd86, 7'd87, 7'd90, 7'd91, 7'd94, 7'd95, 7'd98, 7'd99,
		7'd102, 7'd103, 7'd106, 7'd107, 7'd110, 7'd111, 7'd114, 7'd115,
		7'd118, 7'd119, 7'd122, 7'd123 : begin
			{buffer_out_mux_selector_stage5 , buffer_in_mux_selector_stage5}=2'b10;
		end
		7'd64, 7'd65, 7'd68, 7'd69, 7'd72, 7'd73, 7'd76, 7'd77, 7'd80, 7'd81, 
		7'd84, 7'd85, 7'd88, 7'd89, 7'd92, 7'd93, 7'd96, 7'd97, 7'd100, 7'd101, 
		7'd104, 7'd105, 7'd108, 7'd109, 7'd112, 7'd113, 7'd116, 7'd117, 
		7'd120, 7'd121:begin
			{buffer_out_mux_selector_stage5 , buffer_in_mux_selector_stage5}=2'b01;
		end

		7'd124,7'd125:begin
			{buffer_out_mux_selector_stage5 , buffer_in_mux_selector_stage5}=2'b0x;
		end
		7'd126,7'd127: begin
			{buffer_out_mux_selector_stage5 , buffer_in_mux_selector_stage5}=2'bxx;
		end
	endcase

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	case (counter)
		7'd0, 7'd1, 7'd2, 7'd3, 7'd4, 7'd5, 7'd6, 7'd7,  
		7'd8, 7'd9, 7'd10, 7'd11, 7'd12, 7'd13, 7'd14, 
		7'd15, 7'd16, 7'd17, 7'd18, 7'd19, 7'd20, 7'd21, 
		7'd22, 7'd23, 7'd24, 7'd25, 7'd26, 7'd27, 7'd28, 
		7'd29, 7'd30, 7'd31,7'd32,7'd33, 7'd34, 7'd35, 
		7'd36, 7'd37, 7'd38, 7'd39, 7'd40, 7'd41, 7'd42, 
		7'd43, 7'd44, 7'd45, 7'd46, 7'd47,7'd48, 7'd49, 7'd50, 7'd51, 7'd52, 7'd53, 7'd54, 7'd55: begin
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'bxx;
		end 
		7'd56,7'd57,7'd58,7'd59: begin
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'bx1;
		end
		7'd60, 7'd61, 7'd62, 7'd63, 7'd68, 7'd69, 7'd70, 7'd71, 7'd76, 7'd77,
		7'd78, 7'd79, 7'd84, 7'd85, 7'd86, 7'd87, 7'd92, 7'd93, 7'd94, 7'd95,
		7'd100, 7'd101, 7'd102, 7'd103, 7'd108, 7'd109, 7'd110, 7'd111, 
		7'd116, 7'd117, 7'd118, 7'd119: begin
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b10;
		end
		7'd64, 7'd65, 7'd66, 7'd67, 7'd72, 7'd73, 7'd74, 7'd75, 7'd80, 7'd81,
		7'd82, 7'd83, 7'd88, 7'd89, 7'd90, 7'd91, 7'd96, 7'd97, 7'd98, 7'd99,
		7'd104, 7'd105, 7'd106, 7'd107, 7'd112, 7'd113, 7'd114, 7'd115:begin
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b01;
		end

		7'd120,7'd121,7'd122,7'd123:begin
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'b0x;
		end
		7'd124,7'd125,7'd126,7'd127: begin
			{buffer_out_mux_selector_stage4 , buffer_in_mux_selector_stage4}=2'bxx;
		end
	endcase
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	case (counter)
		7'd0, 7'd1, 7'd2, 7'd3, 7'd4, 7'd5, 7'd6, 7'd7,  
		7'd8, 7'd9, 7'd10, 7'd11, 7'd12, 7'd13, 7'd14, 7'd15,  
		7'd16, 7'd17, 7'd18, 7'd19, 7'd20, 7'd21, 7'd22, 7'd23,  
		7'd24, 7'd25, 7'd26, 7'd27, 7'd28, 7'd29, 7'd30, 7'd31,7'd32,
		7'd33, 7'd34, 7'd35, 7'd36, 7'd37, 7'd38, 7'd39,  
		7'd40, 7'd41, 7'd42, 7'd43, 7'd44, 7'd45, 7'd46, 7'd47: begin
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'bxx;
		end 
		7'd48, 7'd49, 7'd50, 7'd51, 7'd52, 7'd53, 7'd54, 7'd55: begin
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'bx1;
		end
		7'd56, 7'd57, 7'd58, 7'd59, 7'd60, 7'd61, 7'd62, 7'd63, 7'd72, 7'd73, 
		7'd74, 7'd75, 7'd76, 7'd77, 7'd78, 7'd79, 7'd88, 7'd89, 7'd90, 7'd91, 
		7'd92, 7'd93, 7'd94, 7'd95, 7'd104, 7'd105, 7'd106, 7'd107, 7'd108, 
		7'd109, 7'd110, 7'd111: begin
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b10;
		end
		7'd64, 7'd65, 7'd66, 7'd67, 7'd68, 7'd69, 7'd70, 7'd71, 7'd80, 7'd81, 
		7'd82, 7'd83, 7'd84, 7'd85, 7'd86, 7'd87, 7'd96, 7'd97, 7'd98, 7'd99,
		7'd100, 7'd101, 7'd102, 7'd103:begin
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b01;
		end

		7'd112,7'd113,7'd114,7'd115,7'd116,7'd117,7'd118,7'd119:begin
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'b0x;
		end
		7'd120,7'd121,7'd122,7'd123,7'd124,7'd125,7'd126,7'd127: begin
			{buffer_out_mux_selector_stage3 , buffer_in_mux_selector_stage3}=2'bxx;
		end
	endcase

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	case (counter)
		7'd0, 7'd1, 7'd2, 7'd3, 7'd4, 7'd5, 7'd6, 7'd7,  
		7'd8, 7'd9, 7'd10, 7'd11, 7'd12, 7'd13, 7'd14, 7'd15,  
		7'd16, 7'd17, 7'd18, 7'd19, 7'd20, 7'd21, 7'd22, 7'd23,  
		7'd24, 7'd25, 7'd26, 7'd27, 7'd28, 7'd29, 7'd30, 7'd31: begin
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bxx;
		end 
		7'd32, 7'd33, 7'd34, 7'd35, 7'd36, 7'd37, 7'd38, 7'd39,
		7'd40, 7'd41, 7'd42, 7'd43, 7'd44, 7'd45, 7'd46, 7'd47: begin
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bx1;
		end
		7'd48, 7'd49, 7'd50, 7'd51, 7'd52, 7'd53, 7'd54, 7'd55, 7'd56, 7'd57, 
		7'd58, 7'd59, 7'd60, 7'd61, 7'd62, 7'd63, 7'd80, 7'd81, 7'd82, 7'd83, 
		7'd84, 7'd85, 7'd86, 7'd87, 7'd88, 7'd89, 7'd90, 7'd91, 7'd92, 7'd93, 
		7'd94, 7'd95: begin
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b10;
		end
		7'd64, 7'd65, 7'd66, 7'd67, 7'd68, 7'd69, 7'd70, 7'd71, 7'd72, 7'd73, 
		7'd74, 7'd75, 7'd76, 7'd77, 7'd78, 7'd79:begin
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b01;
		end

		7'd96, 7'd97, 7'd98, 7'd99, 7'd100, 7'd101, 7'd102, 7'd103,  
		7'd104, 7'd105, 7'd106, 7'd107, 7'd108, 7'd109, 7'd110, 7'd111:begin
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'b0x;
		end
		7'd112, 7'd113, 7'd114, 7'd115, 7'd116, 7'd117, 7'd118, 7'd119,  
		7'd120, 7'd121, 7'd122, 7'd123, 7'd124, 7'd125, 7'd126, 7'd127: begin
			{buffer_out_mux_selector_stage2 , buffer_in_mux_selector_stage2}=2'bxx;
		end
	endcase


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	case (counter)
		7'd0, 7'd1, 7'd2, 7'd3, 7'd4, 7'd5, 7'd6, 7'd7,  
		7'd8, 7'd9, 7'd10, 7'd11, 7'd12, 7'd13, 7'd14, 7'd15,  
		7'd16, 7'd17, 7'd18, 7'd19, 7'd20, 7'd21, 7'd22, 7'd23,  
		7'd24, 7'd25, 7'd26, 7'd27, 7'd28, 7'd29, 7'd30, 7'd31: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'bx1;
		end 

		7'd32, 7'd33, 7'd34, 7'd35, 7'd36, 7'd37, 7'd38, 7'd39,  
		7'd40, 7'd41, 7'd42, 7'd43, 7'd44, 7'd45, 7'd46, 7'd47,  
		7'd48, 7'd49, 7'd50, 7'd51, 7'd52, 7'd53, 7'd54, 7'd55,  
		7'd56, 7'd57, 7'd58, 7'd59, 7'd60, 7'd61, 7'd62, 7'd63: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b10;
		end


		7'd64, 7'd65, 7'd66, 7'd67, 7'd68, 7'd69, 7'd70, 7'd71,  
		7'd72, 7'd73, 7'd74, 7'd75, 7'd76, 7'd77, 7'd78, 7'd79,  
		7'd80, 7'd81, 7'd82, 7'd83, 7'd84, 7'd85, 7'd86, 7'd87,  
		7'd88, 7'd89, 7'd90, 7'd91, 7'd92, 7'd93, 7'd94, 7'd95:begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'b0x;
		end
		7'd96, 7'd97, 7'd98, 7'd99, 7'd100, 7'd101, 7'd102, 7'd103,  
		7'd104, 7'd105, 7'd106, 7'd107, 7'd108, 7'd109, 7'd110, 7'd111,  
		7'd112, 7'd113, 7'd114, 7'd115, 7'd116, 7'd117, 7'd118, 7'd119,  
		7'd120, 7'd121, 7'd122, 7'd123, 7'd124, 7'd125, 7'd126, 7'd127: begin
			{buffer_out_mux_selector_stage1 , buffer_in_mux_selector_stage1}=2'bxx;
		end
	endcase


end
		
always @(*) begin
	tw_factor_2nd_stage_mux_sel=1'd0;
	tw_factor_3rd_stage_mux_sel=2'd0;
	tw_factor_4th_stage_mux_sel=3'd0;
	tw_factor_5th_stage_mux_sel=4'd0;
	tw_factor_6th_stage_mux_sel=5'd0;
	done_tick=1'b0;
    case (counter)
        7'd65: begin 
			tw_factor_6th_stage_mux_sel=5'd1;
		 end
        7'd66: begin 
			tw_factor_6th_stage_mux_sel=5'd1;
			tw_factor_5th_stage_mux_sel=4'd1;
		 end
        7'd67: begin
			tw_factor_6th_stage_mux_sel=5'd2;
			tw_factor_5th_stage_mux_sel=4'd1;
		  end
        7'd68: begin 
			tw_factor_6th_stage_mux_sel=5'd2;
			tw_factor_5th_stage_mux_sel=4'd1;
			tw_factor_4th_stage_mux_sel=3'd1;
		 end
        7'd69: begin 
			tw_factor_6th_stage_mux_sel=5'd3;
			tw_factor_5th_stage_mux_sel=4'd1;
			tw_factor_4th_stage_mux_sel=3'd1;
		 end
        7'd70: begin 
			tw_factor_6th_stage_mux_sel=5'd3;
			tw_factor_5th_stage_mux_sel=4'd2;
			tw_factor_4th_stage_mux_sel=3'd1;
		 end
        7'd71: begin  
			tw_factor_6th_stage_mux_sel=5'd4;
			tw_factor_5th_stage_mux_sel=4'd2;
			tw_factor_4th_stage_mux_sel=3'd1;
		end
        7'd72: begin 
			tw_factor_6th_stage_mux_sel=5'd4;
			tw_factor_5th_stage_mux_sel=4'd2;
			tw_factor_4th_stage_mux_sel=3'd1;
			tw_factor_3rd_stage_mux_sel=2'd1;
		 end
        7'd73: begin 
			tw_factor_6th_stage_mux_sel=5'd5;
			tw_factor_5th_stage_mux_sel=4'd2;
			tw_factor_4th_stage_mux_sel=3'd1;
			tw_factor_3rd_stage_mux_sel=2'd1;
		 end
        7'd74: begin 
			tw_factor_6th_stage_mux_sel=5'd5;
			tw_factor_5th_stage_mux_sel=4'd3;
			tw_factor_4th_stage_mux_sel=3'd1;
			tw_factor_3rd_stage_mux_sel=2'd1;
		 end
        7'd75: begin 
			tw_factor_6th_stage_mux_sel=5'd6;
			tw_factor_5th_stage_mux_sel=4'd3;
			tw_factor_4th_stage_mux_sel=3'd1;
			tw_factor_3rd_stage_mux_sel=2'd1;
		 end
        7'd76: begin 
			tw_factor_6th_stage_mux_sel=5'd6;
			tw_factor_5th_stage_mux_sel=4'd3;
			tw_factor_4th_stage_mux_sel=3'd2;
			tw_factor_3rd_stage_mux_sel=2'd1;
		 end
        7'd77: begin 
			tw_factor_6th_stage_mux_sel=5'd7;
			tw_factor_5th_stage_mux_sel=4'd3;
			tw_factor_4th_stage_mux_sel=3'd2;
			tw_factor_3rd_stage_mux_sel=2'd1;
		 end
        7'd78: begin 
			tw_factor_6th_stage_mux_sel=5'd7;
			tw_factor_5th_stage_mux_sel=4'd4;
			tw_factor_4th_stage_mux_sel=3'd2;
			tw_factor_3rd_stage_mux_sel=2'd1;
		 end
        7'd79: begin  
			tw_factor_6th_stage_mux_sel=5'd8;
			tw_factor_5th_stage_mux_sel=4'd4;
			tw_factor_4th_stage_mux_sel=3'd2;
			tw_factor_3rd_stage_mux_sel=2'd1;
		end
        7'd80: begin
			tw_factor_6th_stage_mux_sel=5'd8;
			tw_factor_5th_stage_mux_sel=4'd4;
			tw_factor_4th_stage_mux_sel=3'd2;
			tw_factor_3rd_stage_mux_sel=2'd1;
			tw_factor_2nd_stage_mux_sel=1'd1;
		  end
        7'd81: begin 
			tw_factor_6th_stage_mux_sel=5'd9;
			tw_factor_5th_stage_mux_sel=4'd4;
			tw_factor_4th_stage_mux_sel=3'd2;
			tw_factor_3rd_stage_mux_sel=2'd1;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd82: begin 
			tw_factor_6th_stage_mux_sel=5'd9;
			tw_factor_5th_stage_mux_sel=4'd5;
			tw_factor_4th_stage_mux_sel=3'd2;
			tw_factor_3rd_stage_mux_sel=2'd1;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd83: begin 
			tw_factor_6th_stage_mux_sel=5'd10;
			tw_factor_5th_stage_mux_sel=4'd5;
			tw_factor_4th_stage_mux_sel=3'd2;
			tw_factor_3rd_stage_mux_sel=2'd1;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd84: begin 
			tw_factor_6th_stage_mux_sel=5'd10;
			tw_factor_5th_stage_mux_sel=4'd5;
			tw_factor_4th_stage_mux_sel=3'd3;
			tw_factor_3rd_stage_mux_sel=2'd1;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd85: begin 
			tw_factor_6th_stage_mux_sel=5'd11;
			tw_factor_5th_stage_mux_sel=4'd5;
			tw_factor_4th_stage_mux_sel=3'd3;
			tw_factor_3rd_stage_mux_sel=2'd1;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd86: begin 
			tw_factor_6th_stage_mux_sel=5'd11;
			tw_factor_5th_stage_mux_sel=4'd6;
			tw_factor_4th_stage_mux_sel=3'd3;
			tw_factor_3rd_stage_mux_sel=2'd1;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd87: begin 
			tw_factor_6th_stage_mux_sel=5'd12;
			tw_factor_5th_stage_mux_sel=4'd6;
			tw_factor_4th_stage_mux_sel=3'd3;
			tw_factor_3rd_stage_mux_sel=2'd1;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd88: begin 
			tw_factor_6th_stage_mux_sel=5'd12;
			tw_factor_5th_stage_mux_sel=4'd6;
			tw_factor_4th_stage_mux_sel=3'd3;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd89: begin 
			tw_factor_6th_stage_mux_sel=5'd13;
			tw_factor_5th_stage_mux_sel=4'd6;
			tw_factor_4th_stage_mux_sel=3'd3;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd90: begin 
			tw_factor_6th_stage_mux_sel=5'd13;
			tw_factor_5th_stage_mux_sel=4'd7;
			tw_factor_4th_stage_mux_sel=3'd3;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd91: begin 
			tw_factor_6th_stage_mux_sel=5'd14;
			tw_factor_5th_stage_mux_sel=4'd7;
			tw_factor_4th_stage_mux_sel=3'd3;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd92: begin 
			tw_factor_6th_stage_mux_sel=5'd14;
			tw_factor_5th_stage_mux_sel=4'd7;
			tw_factor_4th_stage_mux_sel=3'd4;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd93: begin 
			tw_factor_6th_stage_mux_sel=5'd15;
			tw_factor_5th_stage_mux_sel=4'd7;
			tw_factor_4th_stage_mux_sel=3'd4;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd94: begin 
			tw_factor_6th_stage_mux_sel=5'd15;
			tw_factor_5th_stage_mux_sel=4'd8;
			tw_factor_4th_stage_mux_sel=3'd4;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd95: begin 
			tw_factor_6th_stage_mux_sel=5'd16;
			tw_factor_5th_stage_mux_sel=4'd8;
			tw_factor_4th_stage_mux_sel=3'd4;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd96: begin 
			tw_factor_6th_stage_mux_sel=5'd16;
			tw_factor_5th_stage_mux_sel=4'd8;
			tw_factor_4th_stage_mux_sel=3'd4;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd97: begin 
			tw_factor_6th_stage_mux_sel=5'd17;
			tw_factor_5th_stage_mux_sel=4'd8;
			tw_factor_4th_stage_mux_sel=3'd4;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd98: begin 
			tw_factor_6th_stage_mux_sel=5'd17;
			tw_factor_5th_stage_mux_sel=4'd9;
			tw_factor_4th_stage_mux_sel=3'd4;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd99: begin 
			tw_factor_6th_stage_mux_sel=5'd18;
			tw_factor_5th_stage_mux_sel=4'd9;
			tw_factor_4th_stage_mux_sel=3'd4;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd100: begin
			tw_factor_6th_stage_mux_sel=5'd18;
			tw_factor_5th_stage_mux_sel=4'd9;
			tw_factor_4th_stage_mux_sel=3'd5;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_2nd_stage_mux_sel=1'd1;
		  end
        7'd101: begin 
			tw_factor_6th_stage_mux_sel=5'd19;
			tw_factor_5th_stage_mux_sel=4'd9;
			tw_factor_4th_stage_mux_sel=3'd5;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_2nd_stage_mux_sel=1'd1;
		end
        7'd102: begin 
			tw_factor_6th_stage_mux_sel=5'd19;
			tw_factor_5th_stage_mux_sel=4'd10;
			tw_factor_4th_stage_mux_sel=3'd5;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_2nd_stage_mux_sel=1'd1;
		end
        7'd103: begin
			tw_factor_6th_stage_mux_sel=5'd20;
			tw_factor_5th_stage_mux_sel=4'd10;
			tw_factor_4th_stage_mux_sel=3'd5;
			tw_factor_3rd_stage_mux_sel=2'd2;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd104: begin
			tw_factor_6th_stage_mux_sel=5'd20;
			tw_factor_5th_stage_mux_sel=4'd10;
			tw_factor_4th_stage_mux_sel=3'd5;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd105: begin
			tw_factor_6th_stage_mux_sel=5'd21;
			tw_factor_5th_stage_mux_sel=4'd10;
			tw_factor_4th_stage_mux_sel=3'd5;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd106: begin
			tw_factor_6th_stage_mux_sel=5'd21;
			tw_factor_5th_stage_mux_sel=4'd11;
			tw_factor_4th_stage_mux_sel=3'd5;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd107: begin 
			tw_factor_6th_stage_mux_sel=5'd22;
			tw_factor_5th_stage_mux_sel=4'd11;
			tw_factor_4th_stage_mux_sel=3'd5;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		end
        7'd108: begin
			tw_factor_6th_stage_mux_sel=5'd22;
			tw_factor_5th_stage_mux_sel=4'd11;
			tw_factor_4th_stage_mux_sel=3'd6;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd109: begin
			tw_factor_6th_stage_mux_sel=5'd23;
			tw_factor_5th_stage_mux_sel=4'd11;
			tw_factor_4th_stage_mux_sel=3'd6;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd110: begin
			tw_factor_6th_stage_mux_sel=5'd23;
			tw_factor_5th_stage_mux_sel=4'd12;
			tw_factor_4th_stage_mux_sel=3'd6;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd111: begin
			tw_factor_6th_stage_mux_sel=5'd24;
			tw_factor_5th_stage_mux_sel=4'd12;
			tw_factor_4th_stage_mux_sel=3'd6;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd112: begin
			tw_factor_6th_stage_mux_sel=5'd24;
			tw_factor_5th_stage_mux_sel=4'd12;
			tw_factor_4th_stage_mux_sel=3'd6;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd113: begin
			tw_factor_6th_stage_mux_sel=5'd25;
			tw_factor_5th_stage_mux_sel=4'd12;
			tw_factor_4th_stage_mux_sel=3'd6;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd114: begin
			tw_factor_6th_stage_mux_sel=5'd25;
			tw_factor_5th_stage_mux_sel=4'd13;
			tw_factor_4th_stage_mux_sel=3'd6;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd115: begin 
			tw_factor_6th_stage_mux_sel=5'd26;
			tw_factor_5th_stage_mux_sel=4'd13;
			tw_factor_4th_stage_mux_sel=3'd6;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		end
        7'd116: begin
			tw_factor_6th_stage_mux_sel=5'd26;
			tw_factor_5th_stage_mux_sel=4'd13;
			tw_factor_4th_stage_mux_sel=3'd7;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd117: begin
			tw_factor_6th_stage_mux_sel=5'd27;
			tw_factor_5th_stage_mux_sel=4'd13;
			tw_factor_4th_stage_mux_sel=3'd7;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd118: begin
			tw_factor_6th_stage_mux_sel=5'd27;
			tw_factor_5th_stage_mux_sel=4'd14;
			tw_factor_4th_stage_mux_sel=3'd7;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd119: begin
			tw_factor_6th_stage_mux_sel=5'd28;
			tw_factor_5th_stage_mux_sel=4'd14;
			tw_factor_4th_stage_mux_sel=3'd7;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd120: begin
			tw_factor_6th_stage_mux_sel=5'd28;
			tw_factor_5th_stage_mux_sel=4'd14;
			tw_factor_4th_stage_mux_sel=3'd7;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd121: begin
			tw_factor_6th_stage_mux_sel=5'd29;
			tw_factor_5th_stage_mux_sel=4'd14;
			tw_factor_4th_stage_mux_sel=3'd7;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd122: begin
			tw_factor_6th_stage_mux_sel=5'd29;
			tw_factor_5th_stage_mux_sel=4'd15;
			tw_factor_4th_stage_mux_sel=3'd7;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd123: begin
			tw_factor_6th_stage_mux_sel=5'd30;
			tw_factor_5th_stage_mux_sel=4'd15;
			tw_factor_4th_stage_mux_sel=3'd7;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd124: begin
			tw_factor_6th_stage_mux_sel=5'd30;
			tw_factor_5th_stage_mux_sel=4'd15;
			tw_factor_4th_stage_mux_sel=3'd7;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd125: begin
			tw_factor_6th_stage_mux_sel=5'd31;
			tw_factor_5th_stage_mux_sel=4'd15;
			tw_factor_4th_stage_mux_sel=3'd7;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
		 end
        7'd126: begin 
			tw_factor_6th_stage_mux_sel=5'd31;
			tw_factor_5th_stage_mux_sel=4'd15;
			tw_factor_4th_stage_mux_sel=3'd7;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
			done_tick=1'b1;
		end
        7'd127: begin 
			tw_factor_6th_stage_mux_sel=5'd31;
			tw_factor_5th_stage_mux_sel=4'd15;
			tw_factor_4th_stage_mux_sel=3'd7;
			tw_factor_3rd_stage_mux_sel=2'd3;
			tw_factor_2nd_stage_mux_sel=1'd1;
			done_tick=1'b1;
		end
    endcase
end

endmodule

