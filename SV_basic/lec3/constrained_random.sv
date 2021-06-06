
module constrained_random;

bit b_system_random_func = 1;
bit b_class_randomization = 1;

// TODO-1 understand how to use system random function, and its advanced
// method such as to generate unique values
initial begin: system_random_func
  int unsigned rval;
  int unsigned gen_vals[$];
  wait(b_system_random_func == 1); $display("b_system_random_func process block started");
  // randomize 10 times, and each rand value doesnot care previous generated
  // value
  repeat(10) begin
    rval = $urandom_range(0, 9);
    $display("$urandom_range(0, 9) generated rand value is %0d", rval);
  end

  // Do you have other ways to generate unique number each time which should
  // not be duplicated with previously generate ones?
  repeat(10) begin
    $display("gen_vals queue content is %p", gen_vals);
    std::randomize(rval) with {foreach(gen_vals[i]) rval != gen_vals[i]; rval inside {[0:9]};};
    gen_vals.push_back(rval);
    $display("std::randomize with inline constrait generated rand value %0d", rval);
  end
end
  class chnl_trans;
    rand bit[31:0] data[];
    rand int ch_id;
    rand int pkt_id;
    rand int data_nidles;
    rand int pkt_nidles;
    bit rsp;
    constraint cstr{
      data.size inside {[4:8]};
      foreach(data[i]) data[i] == 'hC000_0000 + (this.ch_id<<24) + (this.pkt_id<<8) + i;
      ch_id == 1;
      pkt_id == 1;
      data_nidles inside {[0:2]};
      pkt_nidles inside {[1:10]};
    };
  endclass

// TODO-2 learn basic constraint format, class randomization method, soft
// constraint, and how to avolid constraint conflict?
initial begin: class_randomization
  chnl_trans ct1, ct2;
  wait(b_class_randomization == 1); $display("b_class_randomization process block started");
  ct1 = new();
  // is ct1 already randomized?
  $display("ct1.data.size = %0d, ct1.ch_id = %0d, ct1.pkt_id = %0d", ct1.data.size(), ct1.ch_id, ct1.pkt_id);
  ct2 = new();
  // is ct2 already randomized?
  $display("ct2.data.size = %0d, ct2.ch_id = %0d, ct2.pkt_id = %0d", ct2.data.size(), ct2.ch_id, ct2.pkt_id);
  // why ct2.ch_id and ct2.pkt_id kept the same number even though it has been
  // randomized several times?
  repeat(5) begin
    void'(ct2.randomize());
    $display("ct2.data.size = %0d, ct2.ch_id = %0d, ct2.pkt_id = %0d", ct2.data.size(), ct2.ch_id, ct2.pkt_id);
  end
  // the randomization with inline constraint would meets randomization
  // failure, how to modify?
  // if(!ct1.randomize() with {ch_id == 2;})
  //   $error("ct1 randomization failure!");
  // else
  //   $display("ct1.data.size = %0d, ct1.ch_id = %0d, ct1.pkt_id = %0d", ct1.data.size(), ct1.ch_id, ct1.pkt_id);
end

endmodule
