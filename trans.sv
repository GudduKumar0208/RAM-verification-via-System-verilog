class trans;


//write operation 
rand logic [7:0] wr_data;

randc logic[3:0] wr_addr;

rand bit wr_en =1;


 
//read operation 

 randc bit  [3:0]rd_addr;
 rand bit [7:0]rd_data;

rand bit rd_en = 1;

constraint write {wr_en == 1; rd_en ==1;}

constraint read {wr_addr == rd_addr;}


endclass


module main();

trans h1;

initial begin 

h1 = new();

repeat(10)
begin
h1.randomize();

$display ("%p",h1);

end
end 
endmodule




