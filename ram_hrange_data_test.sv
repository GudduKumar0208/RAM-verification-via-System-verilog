class ram_high_range_data_xtn extends ram_trans;
   
   constraint WDATA_HIGH {wr_data > 150;}
endclass
