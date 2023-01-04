`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.08.2022 19:42:28
// Design Name: 
// Module Name: SPI
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


module SPI(sclk, reset, ss0, ss1, ss2, datain, MISO, MOSI_S1, MOSI_S2, MOSI_S3, load);
  
  input sclk, reset,load, ss0, ss1, ss2;
  input [7:0] datain;
  output reg [7:0] MISO, MOSI_S1, MOSI_S2, MOSI_S3;
  
  always@(posedge sclk)
    begin
      if(reset)  // Active high reset
        begin
          MISO = 8'b00000000;
          MOSI_S1 = 8'b00000000;
          MOSI_S2 = 8'b00000000;
          MOSI_S3 = 8'b00000000;
        end
      else if (load) begin
        MISO = datain;
        end
      else
        begin
          if(!ss0 && ss1 && ss2)    //Active low slave select inputs
            begin
              MISO <= {MOSI_S1[0], MISO[7:1]};
              MOSI_S1 <= {MISO[0], MOSI_S1[7:1]};
            end
          else if(ss0 && !ss1 && ss2)
            begin
              MISO <= {MOSI_S2[0], MISO[7:1]};
              MOSI_S2 <= {MISO[0], MOSI_S2[7:1]};
            end
          else if(ss0 && ss1 && !ss2)
            begin
              MISO <= {MOSI_S3[0], MISO[7:1]};
              MOSI_S3 <= {MISO[0], MOSI_S3[7:1]};
            end
        end
    end
endmodule
