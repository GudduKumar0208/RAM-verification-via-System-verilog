//import ram_pkg::*;
 class ram_test;
 
  ram_env env_h;
  
  //testcases
  ram_low_range_data_xtn lxtn;
  ram_high_range_data_xtn hxtn;
  
    //interface
  virtual ram_if.WDR_MP  wd_if;
  virtual ram_if.RDR_MP  rd_if;
  virtual ram_if.WMON_MP wm_if;
  virtual ram_if.RMON_MP rm_if;
   
   
  function new (virtual ram_if.WDR_MP  wd_if,
                virtual ram_if.RDR_MP  rd_if,
                virtual ram_if.WMON_MP wm_if,
                virtual ram_if.RMON_MP rm_if);
	this.wd_if = wd_if;
	this.rd_if = rd_if;
	this.wm_if = wm_if;
	this.rm_if = rm_if;
  endfunction
  
  
  task build_and_start();
    env_h = new(wd_if,rd_if,wm_if,rm_if);
	env_h.build();
	if ($test$plusargs("LRANGE_DATA_TEST")) begin
	   lxtn = new();
	   no_of_iteration = 50;
	   env_h.gen_h.trans_h = lxtn;
	end
	if ($test$plusargs("HRANGE_DATA_TEST")) begin
	   hxtn = new();
	   no_of_iteration = 70;
	   env_h.gen_h.trans_h = hxtn;
	end
	env_h.start();
  endtask
  
endclass