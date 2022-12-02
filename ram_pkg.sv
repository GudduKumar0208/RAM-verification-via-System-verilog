
package ram_pkg;

  int no_of_iteration = 50;
 
 `include "ram_trans.sv"
  `include "ram_gen.sv"
  `include "ram_wd.sv"
  `include "ram_wm.sv"
  `include "ram_rf.sv"
  `include "ram_sb.sv"
  `include "ram_rd.sv"
  `include "ram_rm.sv"
  `include "ram_env.sv" 
  
  //testcases
  `include "ram_lrange_data_test.sv"
  `include "ram_hrange_data_test.sv"
  
  
  `include "ram_test.sv"
  
endpackage : ram_pkg
