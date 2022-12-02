class ram_trans;

//write_signals
   rand bit wr_enb;
   randc bit [3:0] wr_addr;
   rand bit [7:0] wr_data;

//read_signals
   rand bit rd_enb;
   randc bit [3:0] rd_addr;
   bit [7:0] rd_data;
   
// ref. model
	reg [7:0] exp_data;
	reg [7:0] mem[15:0];
   

   constraint ENB {wr_enb==1'b1;rd_enb==1'b1;}
   
endclass


