class boundary_4KB;
  rand bit[31:0] awaddr;
  rand bit[2:0] awsize;
  rand bit[7:0] awlen;
  rand bit[13:0] no_bytes;
  rand bit[13:0] max_no_bytes;
  rand bit[31:0] reserved;
  
    constraint reserved_location{reserved inside {[12288:14335]};}
    constraint address_range{awaddr inside {[0:30719]};}
   constraint avoid_address{!(awaddr inside {[12288:14335]});}
  // The awaddr should not be equal to the reserved address
    constraint avoid_reserved_address{awaddr!=reserved;}
    constraint address_alignment{awaddr%(2^awsize)==0;}
    constraint total_num_of_bytes{ no_bytes==((2**awsize)*(awlen+1));}
    constraint maximum_bytes{max_no_bytes==(4096-(awaddr%4096));}
    constraint boundary_limit{no_bytes<=max_no_bytes;}
    constraint address_not_in_reserved_range{awaddr!=reserved;}
  
endclass

module top;
  boundary_4KB boundary;
  initial begin
    boundary=new();
    repeat(100)begin
    void'(boundary.randomize());
      $display("----------------------------");
      $display("awaddr:%0d",boundary.awaddr);
      $display("Reserved address:%0d",boundary.reserved);
      $display("awsize:%0d",boundary.awsize);
      $display("Obtained number of bytes:%0d",boundary.no_bytes);
      $display("maximum number of bytes possible:%0d",boundary.max_no_bytes);
      $display("------------------------------");
    end
  end
endmodule
