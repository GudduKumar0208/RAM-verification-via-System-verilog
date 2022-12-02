interface ram_if(input bit clk, logic rst);

  
  //write_signals
   logic wr_enb;
   logic [3:0] wr_addr;
   logic [7:0] wr_data;

//read_signals
   logic rd_enb;
   logic [3:0] rd_addr;
   logic [7:0] rd_data;
   
   clocking wdr_cb@(posedge clk);
    default input #1 output #1;
	output rst;
	output wr_enb, wr_addr, wr_data;
   endclocking
   
   clocking wmon_cb@(posedge clk);
    default input #1 output #1;
	input rst;
	input wr_enb, wr_addr, wr_data;
   endclocking
   
   clocking rdr_cb@(posedge clk);
    default input #1 output #1;
	output	 rst;
	output rd_enb, rd_addr;
   endclocking
   
   clocking rmon_cb@(posedge clk);
    default input #1 output #1;
	input rst;
	input rd_enb, rd_addr, rd_data;
   endclocking
   
   modport WDR_MP (clocking wdr_cb);
   
   modport WMON_MP (clocking wmon_cb);
   
   modport RDR_MP (clocking rdr_cb);
   
   modport RMON_MP (clocking rmon_cb);
 
	
sequence s1;//rst_c this is also the name of the sequence
rd_enb;
endsequence

sequence s2;//wr_enb this is also the name of the sequence
wr_enb;
endsequence

property p1;//rst_c_and_wr_enb this is the name of the property
@(posedge clk)
s2 or s1;
endproperty


assert property (p1)
$info("rst and wr_enb assertion passed");
else
$info("rst and wr_enb assertion faile");






















 endinterface
 