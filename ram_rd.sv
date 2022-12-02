
class ram_rd;

 ram_trans trans_h;
 
 //mailbox
  mailbox #(ram_trans) gen_rd;

 //interface
 virtual ram_if.RDR_MP vif;


 function new (mailbox #(ram_trans) gen_rd, 
               virtual ram_if.RDR_MP vif);
	this.gen_rd = gen_rd;
	this.vif = vif;
 endfunction
 
 task start();
   forever begin
     gen_rd.get(trans_h);
	 send_to_dut();
	 #10;
    end
 endtask
 
 task send_to_dut();
	vif.rdr_cb.rd_enb <= trans_h.rd_enb;
	vif.rdr_cb.rd_addr <= trans_h.rd_addr;
	//vif.rdr_cb.rd_data <= trans_h.rd_data;
	//$display("The Randomize Read Driver Address = %0d , rd_data = %0d",trans_h.rd_addr,trans_h.rd_data);
	endtask
 
endclass