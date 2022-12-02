
 class ram_sb;
 
  ram_trans trans_h1, trans_h2;

  //mailbox
   mailbox #(ram_trans) rf_sb;
   mailbox #(ram_trans) rm_sb;
   
covergroup cvg();
	L1 : coverpoint trans_h1.wr_enb {
						bins wr_enb = (0=>1);}

	L2 : coverpoint trans_h1.wr_addr {
						bins wr_addr_1 = {0,2,4,6,8,10,12,14};
						ignore_bins wr_addr_2 = {7,9};}
						
    L3 : coverpoint trans_h1.wr_data {
						bins wr_data_1 = {[0:255]};
						illegal_bins wr_data_2 = {50,100,150,200};}
						
	L4 : coverpoint trans_h2.rd_enb {
						bins rd_enb = (0=>1);}
//						bins rd_enb_1 = (1=>0);}

	L5 : coverpoint trans_h2.rd_addr {
						bins rd_addr_1 = {1,3,5,7,9,11,13,15};
						ignore_bins rd_addr_2 = {10,12};}
 
	L6 : coverpoint trans_h2.rd_data {
						bins rd_data = {[0:255]};
						ignore_bins ig = {[65:70]};}
	L7 : cross L3,L5;
	
endgroup

  function new (mailbox #(ram_trans) rf_sb,
                 mailbox #(ram_trans) rm_sb);
	this.rf_sb = rf_sb;
	this.rm_sb = rm_sb;
	cvg = new();
   endfunction
   
   
   
   task start();
    forever begin
	  rf_sb.get(trans_h1);
	  rm_sb.get(trans_h2);
	  cvg.sample();
	  check_data();
	end
   endtask
   
   task check_data();
		/*if (trans_h2.rd_data !== 0) begin
		if (trans_h1.exp_data == trans_h2.rd_data)
		$display(" SUCCESS, ACTUL DATA = %0d, exp_data = %0d",trans_h2.rd_data, trans_h1.exp_data);
	  else
	     $display(" FAIL, ACTUL DATA = %0d, exp_data = %0d",trans_h2.rd_data, trans_h1.exp_data);
	end*/
	endtask
   
  endclass
	  