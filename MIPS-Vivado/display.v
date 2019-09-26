`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 20:45:14
// Design Name: 
// Module Name: display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module display#(parameter times = 40000)(clk,mode,mem,leddata,totaltimes,JMP,CJMP,SEG,AN);
    input clk;
    input [1:0]mode; //mode为0,显示leddata,mode为1显示周期数,mode为3显示内存
    input [31:0]mem;
    input [31:0] leddata;
    input [15:0] totaltimes;
    input [15:0] JMP;
    input [15:0] CJMP;
    output reg [7:0] SEG;
    output reg [7:0] AN;
    reg [3:0]num_show;
    reg [2:0] pos;
    reg clk_down = 0;
    reg [31:0] cnt = 0;
    initial begin
        pos=0;
        clk_down=0;
    end
    always@(posedge clk) begin// 分频
        if(cnt >= times)
            begin
                clk_down <= ~clk_down;
                cnt <= 0;
            end
        else begin
            cnt <= cnt + 1;
        end
    end
    always@(posedge clk_down)begin
             pos=pos+1;
    end
    always @(pos )   //显示
    begin
    if(mode==0)begin    //显示LedData
        case(pos)
            0:  
                begin 
                    AN[7:0] = 8'b11111110;
                    num_show=leddata[3:0];
                end
            1:  
                begin
                    AN[7:0] = 8'b11111101;
                     num_show=leddata[7:4];
                end
            2:  
                begin
                    AN[7:0] = 8'b11111011;
                     num_show=leddata[11:8];
                end
            3:  
                begin
                    AN[7:0] = 8'b11110111;
                    num_show=leddata[15:12];
                end
            4:  
                begin
                    AN[7:0] = 8'b11101111;
                    num_show=leddata[19:16];
                end
            5:
                begin
                    AN[7:0] = 8'b11011111;
                    num_show=leddata[23:20];                  
                end
            6:
                begin
                    AN[7:0] = 8'b10111111;
                    num_show=leddata[27:24];                  
                end
            7:
                begin
                    AN[7:0] = 8'b01111111;
                    num_show=leddata[31:28];                 
                end                
        endcase
    end
     else if(mode==1)begin
        case(pos)
            0:  
                begin 
                    AN[7:0] = 8'b11111110;
                    num_show=totaltimes[3:0];
                end
            1:  
                begin
                    AN[7:0] = 8'b11111101;
                     num_show=totaltimes[7:4];
                end
            2:  
                begin
                    AN[7:0] = 8'b11111011;
                     num_show=totaltimes[11:8];
                end
            3:  
                begin
                    AN[7:0] = 8'b11110111;
                    num_show=totaltimes[15:12];

                end
            default:begin
                     AN[7:0] = 8'b11111111;
                    end
        endcase
    end
    else if(mode==2)begin
        case(pos)
            0:  
                begin 
                    AN[7:0] = 8'b11111110;
                    num_show=JMP[3:0];
                end
            1:  
                begin
                    AN[7:0] = 8'b11111101;
                     num_show=JMP[7:4];
                end
            2:  
                begin
                    AN[7:0] = 8'b11111011;
                     num_show=JMP[11:8];
                end
            3:  
                begin
                    AN[7:0] = 8'b11110111;
                    num_show=JMP[15:12];
                end
            4:  
                begin
                    AN[7:0] = 8'b11101111;
                    num_show=CJMP[3:0];
                end
            5:
                begin
                    AN[7:0] = 8'b11011111;
                    num_show=CJMP[7:4];                  
                end
            6:
                begin
                    AN[7:0] = 8'b10111111;
                    num_show=CJMP[11:8];                  
                end
            7:
                begin
                    AN[7:0] = 8'b01111111;
                    num_show=CJMP[15:12];                 
                end                
        endcase
    end
    else begin
         case(pos)
            0:  
                begin 
                    AN[7:0] = 8'b11111110;
                    num_show=mem[3:0];
                end
            1:  
                begin
                    AN[7:0] = 8'b11111101;
                     num_show=mem[7:4];
                end
            2:  
                begin
                    AN[7:0] = 8'b11111011;
                     num_show=mem[11:8];
                end
            3:  
                begin
                    AN[7:0] = 8'b11110111;
                    num_show=mem[15:12];
                end
            4:  
                begin
                    AN[7:0] = 8'b11101111;
                    num_show=mem[19:16];
                end
            5:
                begin
                    AN[7:0] = 8'b11011111;
                    num_show=mem[23:20];                  
                end
            6:
                begin
                    AN[7:0] = 8'b10111111;
                    num_show=mem[27:24];                  
                end
            7:
                begin
                    AN[7:0] = 8'b01111111;
                    num_show=mem[31:28];                 
                end                
            endcase
    end
    end
    always@(num_show[3:0])//译码
    begin
      case(num_show[3:0])
        4'b0000 :  SEG[7:0]=8'b11000000;
        4'b0001 :  SEG[7:0]=8'b11111001;
        4'b0010 :  SEG[7:0]=8'b10100100;
        4'b0011 :  SEG[7:0]=8'b10110000;
        4'b0100 :  SEG[7:0]=8'b10011001;
        4'b0101 :  SEG[7:0]=8'b10010010;
        4'b0110 :  SEG[7:0]=8'b10000010;
        4'b0111 :  SEG[7:0]=8'b11111000;
        4'b1000 :  SEG[7:0]=8'b10000000;
        4'b1001 :  SEG[7:0]=8'b10011000;
        4'b1010 :  SEG[7:0]=8'b10001000;//a
        4'b1011:   SEG[7:0]=8'b10000011;//b
        4'b1100:   SEG[7:0]=8'b11000110;//c
        4'b1101:   SEG[7:0]=8'b10100001;//d
        4'b1110:   SEG[7:0]=8'b10000110;//e
        4'b1111:   SEG[7:0]=8'b10001110;//f
      endcase
    end
endmodule