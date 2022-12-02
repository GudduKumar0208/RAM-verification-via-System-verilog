class ram_rm;

  ram_trans trans_h;
  
  mailbox #(ram_trans) rm_rf;
  mailbox #(ram_trans) rm_sb;
  
  virtual ram_if.RMON_MP vif;
  
  covergroup cvg();
	L1 : coverpoint trans_h.rd_enb {
						bins wr_enb = (0=>1);}

	L2 : coverpoint trans_h.rd_addr {
						bins rd_addr_1 = {0,2,4,6,8,10,12,14};
						ignore_bins rd_addr_2 = {7,9};}
						
    L3 : coverpoint trans_h.rd_data {
						bins rd_data_1 = {[0:255]};
						illegal_bins rd_data_2 = {50,100,150,200};}
	endgroup
  
   function new (mailbox #(ram_trans) rm_rf, 
                 mailbox #(ram_trans) rm_sb, 
                 virtual ram_if.RMON_MP vif);
	this.rm_rf = rm_rf;
	this.rm_sb = rm_sb;
	this.vif = vif;
	cvg = new();
 endfunction

 
 task start();
  forever begin
   //$display("The Value of rm_rf is %p", rm_rf);
   //$display("The Value of rm_sb is %p", rm_sb);
   monitor();
   cvg.sample();
   rm_rf.put(trans_h);
   rm_sb.put(trans_h);
  end
 endtask
 
 
 task monitor();
	trans_h = new();
   //@(vif.rmon_cb);
   #10;
   trans_h.rd_enb = vif.rmon_cb.rd_enb;
   trans_h.rd_addr = vif.rmon_cb.rd_addr;
   trans_h.rd_data = vif.rmon_cb.rd_data;
//$display("The rd_addr_monitor is %0d and rd_data_monitor is %0d", vif.rmon_cb.rd_addr,vif.rmon_cb.rd_data);

 endtask
 
endclass