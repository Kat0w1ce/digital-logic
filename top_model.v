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
input wire one,ten,high,low,
output wire  [7:0]show,
output wire  [7:0] en,
output reg hold_in,
 output reg [1:0] mode,
output reg  [2:0] state,    //todo
output wire [3:0] charge,
output wire fin,
output wire overflow
    );
 wire [3:0] cnt;
 parameter A=3'b000;
 parameter B=3'b001;
 parameter C=3'b010;
 parameter D=3'b011;
 parameter E=3'b100;
 
 //reg  charge_flag;
 
 initial begin
 state<=A;
 work<=0;
 hold_in<=0;
 mode<=2'b00;
// charge_flag<=0;
 end

    seg seg7(clk,work,hold_in,fin,mode,charge,cnt,show,en);
//    compute com(clk,mode,one,t1,t2,cancel_flag,charge,fin);
    compute p(reset,clk,mode,one,high,low,cancel_flag,charge,fin,overflow,cnt);
 always@(posedge clk )//or posedge reset  or posedge one or posedge ten or posedge signal or posedge cancel_flag or posedge fin)begin
    begin
    if(!reset) 
     begin
        state<=A;
        work<=0;
        hold_in<=0;
        mode[1:0]<=2'b0;
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
                mode[1:0]<=2'b00;           
            end
            else begin 
               state<=B;
               hold_in<=0;
              mode[1:0]<=2'b00;
            end
        C:  
            if(one)begin
                mode[1:0]<=2'b01;
                state<=D;
            end 
            else if(ten)begin
                 mode=2'b11;
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



module compute(
input wire reset,
input  wire clk,
input wire [1:0] mode,
input wire one,high,low,
input wire cancel_flag,
output reg [3:0] charge,
output reg fin,
output reg overflow,
output reg [3:0] cnt
);

reg three;

initial begin
    cnt<=4'b1;
    fin<=0;
    charge<=4'b0000;
    three<=0;
    overflow<=0;
end

//always@(posedge clk or posedge t1 or posedge t2 or posedge one )
always@(posedge one or negedge reset)
    begin
        if(!reset)
        begin
            cnt=4'b1;
            three=0;
            overflow=0;
        end 
        else 
            if(mode==2'b01&&one)
            begin
                if(!overflow)
                begin
                    cnt=cnt+4'b1;
                    if(cnt>2&&cnt<5)
                        three=1;
                    else if(cnt==5)
                        overflow=1;
                    else
                        ;
                end
            else ;
            end    
      end     

always@(posedge clk )//or posedge cancel_flag or posedge high or posedge low )
begin
    if(reset)
    begin
        case(mode)
        2'b01:   
            if(cancel_flag&&!fin)
            begin
                charge<=cnt;
                fin<=1;
            end else
            if(three)
            begin
                if(low&&!fin)
                begin
                fin<=1;
                case(cnt)
                    3:
                       charge<=6;
                    4: 
                       charge<=7;
                    5: 
                       charge<=8;
                    default:
                        charge<=4'b0;
                endcase
                end
                else ;       
            end
        2'b11:
            begin
               if(high&&!fin)
                begin
                    charge<=5;
                    fin<=1;
                end else
                if(low&&!fin)
                begin
                    charge<=9;
                    fin<=1;
                end
               else  if(cancel_flag&&!fin)
                   begin
                        fin<=1;
                        charge<=10;
                             
                  end
                else ;
             end   
          default:;
         endcase
    end 
    else begin
         fin<=0;
         charge<=0;
         end
    end
endmodule
module seg(
input wire clk,
input wire work,hold_in,fin,
input wire [1:0] mode,
input wire [3:0] charge,
input wire [3:0] cnt,
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
    if(work&&!hold_in&&!fin)
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
        else if(work&&hold_in&&fin)
            begin
                case(charge)
                    1:
                       if(times<25000)
                       begin
                            b<=8'b11111110;
                            show<=8'b11000000;
                       end 
                       else begin
                            b<=8'b11111101; 
                            show<=8'b01111001;
                       end
                     2:    
                        if(times<25000)
                        begin
                            b<=8'b11111110;
                            show<=8'b11000000;
                        end 
                        else begin
                            b<=8'b11111101; 
                            show<=8'b00100100;
                        end
                    3:    
                        if(times<25000)
                        begin
                            b<=8'b11111110;
                            show<=8'b11000000;
                        end 
                        else begin
                            b<=8'b11111101; 
                            show<=8'b00110000;
                        end  
                     4:    
                        if(times<25000)
                        begin
                            b<=8'b11111110;
                            show<=8'b11000000;
                        end 
                        else begin
                            b<=8'b11111101; 
                            show<=8'b00011001;
                        end     
                     5:    //5.0
                        if(times<25000)
                        begin
                            b<=8'b11111110;
                            show<=8'b11000000;
                        end 
                        else begin
                            b<=8'b11111101; 
                            show<=8'b00010010;
                        end 
                     6: //0.5   
                        if(times<25000)
                        begin
                            b<=8'b11111110;
                            show<=8'b10010010;
                        end 
                        else begin
                            b<=8'b11111101; 
                            show<=8'b01000000;
                        end                 
                    7: //1.5   
                        if(times<25000)
                        begin
                            b<=8'b11111110;
                            show<=8'b10010010;
                        end 
                        else begin
                            b<=8'b11111101; 
                            show<=8'b01111001;
                        end    
                    8: //2.5   
                        if(times<25000)
                        begin
                            b<=8'b11111110;
                            show<=8'b10010010;
                        end 
                        else begin
                            b<=8'b11111101; 
                            show<=8'b00100100;          
                        end      
                    9: //7.5   
                        if(times<25000)
                        begin
                            b<=8'b11111110;
                            show<=8'b10010010;
                        end 
                        else begin
                            b<=8'b11111101; 
                            show<=8'b01111000;          
                        end                     
                    10: //10.0   
                        if(times<16000)
                        begin
                            b<=8'b11111110;
                            show<=8'b11000000;
                        end 
                        else if(times<33000) 
                        begin
                            b<=8'b11111101; 
                            show<=8'b01000000;          
                        end      
                        else  begin
                            b<=8'b11111011; 
                            show<=8'b11111001;          
                        end                   
                      default:
                      begin
                            b<=8'b11111111;
                            show<=8'b11111111;
                            
                      end 
                endcase
            end
     else begin
        b<=8'b1111_1111;
        show<=8'b1111_1111;
     end
end

endmodule