
module data_type;

bit b_signed_vs_unsigned = 1;
bit b_bit_vs_logic = 1;
bit b_enum_type = 1;
bit b_struct_type = 1;


// TODO-1: distinguish signed and unsigned type
initial begin: signed_vs_unsigned
  byte b0;
  bit[7:0] b1;
  wait(b_signed_vs_unsigned == 1); $display("signed_vs_unsigned process block started");
  b0 = 'b1000_0000;
  $display("byte variable b0 = %d", b0);
  b1 = b0;
  $display("bit vector variable b1 = %d", b1);
end


// TODO-2: distinguish bit and logic
initial begin: bit_vs_logic
  bit v1;
  logic v2;
  wait(b_bit_vs_logic == 1); $display("bit_vs_logic process block started");

  v2 = 'b1;
  $display("logic variable v2 = %d", v2);
  v1 = v2;
  $display("bit variable v1 = %d", v1);

  v2 = 'b0;
  $display("logic variable v2 = %d", v2);
  v1 = v2;
  $display("bit variable v1 = %d", v1);

  v2 = 'bx;
  $display("logic variable v2 = %d", v2);
  v1 = v2;
  $display("bit variable v1 = %d", v1);

  v2 = 'bz;
  $display("logic variable v2 = %d", v2);
  v1 = v2;
  $display("bit variable v1 = %d", v1);
end

// TODO-3: enum type
initial begin: enum_type
  typedef enum {IDLE, START, PROC, END} state_t;
  state_t st1, st2;
  wait(b_enum_type == 1); $display("enum_type process block started");
  st1 = IDLE;
  $display("st1 value = %0d (int)", st1);
  $display("st1 value = %s (string)", st1); // implicit conversion
  $display("st1 value = %s (string)", st1.name());

  st2 = state_t'(1);
  $display("st1 value = %0d (int)", st2);
  $display("st1 value = %s (string)", st2.name());
end

// TODO-4: struct type
initial begin: struct_type
  typedef struct {
    bit[7:0] addr;
    bit[31:0] data;
    bit is_write;
    int id;
  } trans_t;
  trans_t t1, t2, t3;
  wait(b_struct_type == 1); $display("struct_type process block started");
  t1 = '{'h10, 'h1122_3344, 'b1, 'h1000};
  $display("t1 data content is %p", t1);


  t2.addr = 'h20;
  t2.data = 'h5566_7788;
  t2.is_write = 'b0;
  t2.id = 'h2000;
  $display("t2 data content is %p", t2);

  t3 = t2;
  t3.data = 'h99AA_BBCC;
  t3.id = 'h3000;
  $display("t3 data content is %p", t3);
  $display("t2 data content is %p", t2);
end

endmodule
