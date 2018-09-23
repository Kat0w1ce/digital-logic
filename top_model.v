`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/21 08:03:42
// Design Name: 
// Module Name: top_model
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// // Target Devices: 

// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module top_model(
input wire clk,
input wire reset,
input wire signal,
input wire cancel_flag,
output reg work,
input wire one,ten,t1,t2,
output wire  [7:0]show,en,
output reg hold_in,
output reg [1:0] mode,
 output reg  [2:0] state,    //todo
 output wire [3:0] charge,
 output wire fin
    );
 parameter A=3'b000;
 parameter B=3'b001;
 parameter C=3'b010;
 parameter D=3'b011;
 parameter E=3'b100;
 
 reg  charge_flag;
 
 initial begin
 state<=A;
 work<=0;
 hold_in<=0;
 mode<=2'b00;
 charge_flag<=0;
 end

    seg(clk,work,hold_in,show,en);
    compute(clk,mode,one,t1,t2,cancel_flag,charge,fin);
 always@(posedge clk or posedge reset  or posedge one or posedge ten or posedge signal or posedge cancel_flag or posedge fin)begin
    if(!reset) 
     begin
        state<=A;
        work<=0;
        hold_in<=0;
        mode<=2'b00;
    end
     else begin
     case(state)
        A:
            if(reset) begin
                state<=B;
                work<=1; 
                
            end 
            else begin
               state<=A;
               work<=0;
            end
                
        B: 
            if(signal) begin
                hold_in<=1;           
                state<=C;
                mode<=2'b00;           
            end
            else begin 
               state<=B;
               hold_in<=0;
               mode<=2'b00;
            end
        C:  
            if(one)begin
                mode<=2'b01;
                state<=D;
            end 
            else if(ten)begin
                 mode<=2'b10;
                 state<=D;
            end
            else if(cancel_flag) begin
                state<=B;
                hold_in<=0;
                mode<=2'b00;
                end
            else begin
                state<=C;
                mode<=2'b00;
              end 
        D:
           if(fin)
            begin
//               charge_flag<=1;
               state<=E;
            end      
            else begin
                state<=D; 
            end    
        default;      
     
        endcase
    end
end
    
endmodule

module seg(
input wire clk,
//input wire [7:0] a,
input wire work,hold_in,
output reg [7:0] show,
output reg [7:0] b
);  
reg [15:0] times;
initial
    begin
    show<=8'b11111111;
    b<=8'b11111100;
    times<=16'b0;
    end
always@(posedge clk) begin
    times<=times+16'b1;
    if(times==50000)
        times<=16'b0;
end
always @(posedge clk)begin
    if(work&&!hold_in)
        if(times<10000)
        begin
            b<=8'b11111110;
            show<=8'b11000000;
        end
        else if(times<20000)
          begin
              b<=8'b11111101;
              show<=8'b11000111;
          end
         else if(times<30000)
           begin
               b<=8'b11111011;
               show<=8'b11000111;
           end
           else if(times<40000)
           begin    
               b<=8'b11110111;
               show<=8'b10000110;
           end
           else begin
               b<=8'b11101111;
               show<=8'b10001001;
           end
     else begin
        b<=8'b1111_1111;
        show<=8'b1111_1111;
     end

end
endmodule

module compute(
input clk,
input [1:0] mode,
input one,t1,t2,
input cancel_flag,
output reg [3:0] charge,
output reg fin
);
reg [4:0]cnt;
initial begin
    cnt<=1;
    fin<=0;
    charge<=4'b0;
end

//always@(posedge clk or posedge t1 or posedge t2 or posedge one )
/*always@(posedge clk or posedge one)
begin
    if(mode==2'b01&&one)
       begin
        cnt<=cnt+1;
        if(cnt>2)
        begin
            charge<=11;
            fin<=1;
        end
        else fin<=0 ;    
        end
    else;
end*/
always@(posedge clk or posedge cancel_flag or posedge t1 or posedge t2 )
begin
    case(mode)
    2'b01:   
        if(cancel_flag)
        begin
            charge<=cnt;
            fin<=1;
        end 
        else fin<=0; 
        
    2'b10:
            if(cancel_flag)
            begin
                charge<=10;
                fin<=1;
            end else
            if(t1)
            begin
                charge<=12;
                fin<=1;
            end else
            if(t2)
            begin
                charge<=5;
                fin<=1;
            end
            else fin<=0;
      default:
            fin<=0;
    endcase
end


endmodule