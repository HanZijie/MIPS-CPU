`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 17:13:46
// Design Name: 
// Module Name: Register
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


module Register
#(parameter DATA_WIDTH=32)(
    input wire clk,
    input wire rst,
    input wire en,
    input wire[(DATA_WIDTH-1):0] indata,
    output reg[(DATA_WIDTH-1):0] outdata
);
    initial begin
       outdata<=0;
    end
    
    always @ ( posedge clk) begin
        if(rst==0) begin
            if(en==1) begin //ʹ�ܶˣ��ߵ�ƽ��Ч����enΪ0ʱ������ʱ������
                outdata = indata;
            end
        end
        else begin  //��λ���ߵ�ƽ���Ĵ�����0
            outdata = 0;
        end
    end

endmodule
