
  
class ram_rf;

  ram_trans trans_h1,trans_h2; 
  
  //mailbox
   mailbox #(ram_trans) wm_rf;
   mailbox #(ram_trans) rm_rf;
   mailbox #(ram_trans) rf_sb;
   
   function new (mailbox #(ram_trans) wm_rf,
                 mailbox #(ram_trans) rm_rf,
                 mailbox #(ram_trans) rf_sb);
	this.wm_rf = wm_rf;
	this.rm_rf = rm_rf;
	this.rf_sb = rf_sb;
  endfunction
  
  
  task start();
   forever begin
    wm_rf.get(trans_h1);
	rm_rf.get(trans_h2);
	//$display("The Ref.Model Write Address & Data is %p",trans_h1);
	//$display("The Ref.Model Read Address & Data is %p",trans_h2);
	ref_model();
	rf_sb.put(trans_h1);
   end
  endtask
    
  task ref_model();
	if (trans_h2.rd_enb) begin
		trans_h1.exp_data = trans_h2.rd_data;
	end
	//$display("The write address is %0d",trans_h1.wr_data);
	//$display("The Expected value = %0d",exp_data);
	
	endtask
 endclass
	