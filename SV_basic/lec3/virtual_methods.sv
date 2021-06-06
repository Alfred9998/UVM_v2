
// This example is referred to the lec2/class_inheritance 
// The purpose is to learn the convenience of virtual method
module virtual_methods;

  class trans;
    bit[31:0] data[];
    int pkt_id;
    int data_nidles;
    int pkt_nidles;
    bit rsp;

    virtual function trans clone(trans t = null);
      if(t == null) t = new();
      t.data = data;
      t.pkt_id = pkt_id;
      t.data_nidles = data_nidles;
      t.pkt_nidles = pkt_nidles;
      t.rsp = rsp;
      return t;
    endfunction
  endclass

  class chnl_trans extends trans;
    int ch_id; // new member in child class

    virtual function trans clone(trans t = null);
      chnl_trans ct;
      if(t == null) 
        ct = new();
      else
        void'($cast(ct, t));
      void'(super.clone(ct));
      ct.ch_id = ch_id; // new member
      return ct;
    endfunction
  endclass

  initial begin
    trans t1, t2;
    chnl_trans ct1, ct2;

    ct1 = new();
    ct1.pkt_id = 200;
    ct1.ch_id = 2;
    // t1 pointed to ct1's trans class data base
    t1 = ct1;
    $display("before cloning ct1 object");
    $display("ct1.pkt_id = %0d, ct1.ch_id = %0d", ct1.pkt_id, ct1.ch_id);

    // TODO-1 compare with lec2/class_inheritance TODO-2
    // why it is legal to call t1.clone() here?
    // TODO-2 via this example, please summarize the virtual method
    // convenience
    t2 = t1.clone(); 
    void'($cast(ct2, t2));

    // TODO-3 to access ct2.ch_id, could we directly use t2.ch_id?
    // is it possible to add modified virtual before chnl_trans::ch_id, and
    // then access it by 't2.ch_id'? and why?
    $display("after cloning ct1 object");
    $display("ct1.pkt_id = %0d, ct1.ch_id = %0d", ct1.pkt_id, ct1.ch_id);
    $display("ct2.pkt_id = %0d, ct2.ch_id = %0d", ct2.pkt_id, ct2.ch_id);
  end

endmodule
