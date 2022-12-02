class ram_wd;

 ram_trans trans_h;
 
 //mailbox
  mailbox #(ram_trans) gen_wd;

 //interface
 virtual ram_if.WDR_MP vif;


 function new (mailbox #(ram_trans) gen_wd, 
               virtual ram_if.WDR_MP vif);
	this.gen_wd = gen_wd;
	this.vif = vif;
 endfunction
 
 
 task start();
   forever begin
     gen_wd.get(trans_h);
	 send_to_dut();
	 #10;
    end
 endtask
 
 task send_to_dut();
	vif.wdr_cb.wr_enb  <= trans_h.wr_enb;
	vif.wdr_cb.wr_addr <= trans_h.wr_addr;
	vif.wdr_cb.wr_data <= trans_h.wr_data;
	//$display("The Randomize Write Driver Address = %0d , wr_data = %0d",trans_h.wr_addr,trans_h.wr_data);
	//$display("interface = %0p",vif.wdr_cb.wr_addr);	//to check Interface Value
 endtask
endclass