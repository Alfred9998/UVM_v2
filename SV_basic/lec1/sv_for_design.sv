
module sv_for_design;

bit b_always_compare = 1;
bit b_compare_operator = 1;
bit b_inside_operator = 1;
bit b_case_statement = 1;

// TODO-1 why l2 != l3 at time 0 ?
logic l1 = 0, l2, l3;
always @(l1) l2 <= l1;
always_comb l3 = l1;
initial begin: always_compare
  wait(b_always_compare == 1); $display("always_compare process block started");
  #0;
  $display("@%0t, l2 = %b", $time, l2);
  $display("@%0t, l3 = %b", $time, l3);

  #10;
  l1 <= 1;
  #1;
  $display("@%0t, l2 = %b", $time, l2);
  $display("@%0t, l3 = %b", $time, l3);
end

// TODO-2 learn the compare operators' difference
initial begin: compare_operator
  logic [3:0] v1, v2;

  wait(b_compare_operator == 1); $display("compare_operator process block started");
  v1 = 'b111x;
  v2 = 'b1110;
  if(v1 != v2) // binary logical equality operator
    $display("v1 %b != v2 %b", v1, v2);
  else
    $display("v1 %b == v2 %b", v1, v2);
  $display("the operator result (v1 != v2) is %b", (v1 != v2));


  if(v1 !== v2) // binary case equality operator
    $display("v1 %b !== v2 %b", v1, v2);
  else
    $display("v1 %b === v2 %b", v1, v2);
  $display("the operator result (v1 !== v2) is %b", (v1 !== v2));

end

// TODO-3 learn the inside operator
initial begin: inside_operator
  bit [2:0] v1;
  wait(b_inside_operator == 1); $display("inside_operator process block started");
  v1 = 'b100;
  if(v1 == 'b100 || v1 == 'b010 || v1 == 'b001)
    $display("v1: %0b meets onehot vector requirement!", v1);
  else
    $display("v1: %0b does not meet onehot vector requirement!", v1);

  if(v1 inside {'b100, 'b010, 'b001})
    $display("v1: %0b meets onehot vector requirement!", v1);
  else
    $display("v1: %0b does not meet onehot vector requirement!", v1);

  if($onehot(v1) == 1)
    $display("v1: %0b meets onehot vector requirement!", v1);
  else
    $display("v1: %0b does not meet onehot vector requirement!", v1);
end

// TODO-4 learn {unique, priority} case{ ,x, z} statement
initial begin: case_statement
  parameter width_p = 4;
  bit [width_p-1:0] v_arr[3];
  wait(b_case_statement == 1); $display("case_statement process block started");
  v_arr = '{'b1000, 'b1111, 'b0110};
  foreach(v_arr[i]) begin
    unique case(v_arr[i])
      'b0001, 'b0010, 'b0100, 'b1000: $display("v1: %0b meets onehot vector requirement!", v_arr[i]);
      0: $display("v1: %0b is ZERO", v_arr[i]);
      'b1111: $display("v1: %0b is ALL ONES", v_arr[i]);
      default: $display("v1: %0b has [2~%0d] ones", v_arr[i], width_p-1);
    endcase
  end
end

endmodule
