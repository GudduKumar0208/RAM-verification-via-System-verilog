class ram_low_range_data_xtn extends ram_trans;
   
   constraint WDATA {wr_data < 50;}

endclass
