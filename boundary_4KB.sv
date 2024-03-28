class boundary_4KB;
  rand bit[31:0] awaddr;
  rand bit[2:0] awsize;
  rand bit[7:0] awlen;
  rand bit[13:0] no_bytes;
  rand bit[13:0] max_no_bytes;
  constraint address_range{awaddr inside {[0:16384]};}
  constraint address_alignment{awaddr%(2^awsize)==0;}
  constraint total_num_of_bytes{ no_bytes==((2**awsize)*(awlen+1));}
  constraint maximum_bytes{max_no_bytes==(4096-(awaddr%4096));}
  constraint boundary_limit{no_bytes<=max_no_bytes;}
endclass

module top;
  boundary_4KB boundary;
  initial begin
    boundary=new();
    repeat(10)begin
    void'(boundary.randomize());
      $display("----------------------------");
      $display("Slave number:%0d",(boundary.awaddr/4096));
      $display("awaddr:%0d",boundary.awaddr);
      $display("awsize:%0d",boundary.awsize);
      $display("Obtained number of bytes:%0d",boundary.no_bytes);
      $display("maximum number of bytes possible:%0d",boundary.max_no_bytes);
      $display("------------------------------");
    end
  end
endmodule
