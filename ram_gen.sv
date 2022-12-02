
class ram_gen;

  ram_trans trans_h, trans_copy_h;
  
  //mailbox
  mailbox #(ram_trans) gen_wd;
  mailbox #(ram_trans) gen_rd;
  
 
  
  function new (mailbox #(ram_trans) gen_wd,
                mailbox #(ram_trans) gen_rd);
	this.gen_wd = gen_wd;
	this.gen_rd = gen_rd;
  endfunction
  
 task start();  
  repeat(no_of_iteration) begin
		trans_h = new();
		assert(trans_h.randomize());
	//	$display("%0p",trans_h);				//to check randomize or not4
		trans_copy_h = new trans_h;    
		gen_wd.put(trans_copy_h);
		gen_rd.put(trans_copy_h);
		#10;
	end
 endtask
	   
endclass

