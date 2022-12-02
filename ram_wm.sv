
class ram_wm;

  ram_trans trans_h;
  
  mailbox #(ram_trans) wm_rf;
  
  virtual ram_if.WMON_MP vif;
  
 covergroup cvg();
	L1 : coverpoint trans_h.wr_enb {
						bins wr_enb = (0=>1);}

	L2 : coverpoint trans_h.wr_addr {
						bins wr_addr_1 = {0,2,4,6,8,10,12,14};
						ignore_bins wr_addr_2 = {7,9};}
						
    L3 : coverpoint trans_h.wr_data {
						bins wr_data_1 = {[0:255]};
						illegal_bins wr_data_2 = {50,100,150,200};}
	endgroup
	
 
  function new (mailbox #(ram_trans) wm_rf, 
               virtual ram_if.WMON_MP vif);
	this.wm_rf = wm_rf;
	this.vif = vif;
	cvg = new();
 endfunction
 
 task start();
  forever begin
   monitor();
   cvg.sample();
   wm_rf.put(trans_h);
  end
 endtask
 
 
 task monitor();
  trans_h = new();	
  #10; 
   trans_h.wr_enb = vif.wmon_cb.wr_enb;
   trans_h.wr_addr = vif.wmon_cb.wr_addr;
   trans_h.wr_data = vif.wmon_cb.wr_data;
  // $display("The wr_addr_monitor is %0d and wr_data_monitor is %0d", vif.wmon_cb.wr_addr,vif.wmon_cb.wr_data);
 endtask
 
endclass