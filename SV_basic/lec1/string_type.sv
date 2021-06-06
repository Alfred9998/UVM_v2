
module string_type;

bit b_string_format = 1;
bit b_string_builtin_function = 1;

// TODO-1 understand how to formulate a new string
initial begin: string_format
  string s1, s2, s3, s4;
  wait(b_string_format == 1);$display("string_format process block started");
  s1 = "Welcome";
  s2 = "www.rockeric.com";

  s3 = {s1, " to ", s2}; // concatenation operator '{...}'
  $display("s3 content: %s", s3);

  s4 = $sformatf("%s to %s", s1, s2); // system format function
  $display("s4 content: %s", s4);
end

// TODO-2  understand how s3 is composed with s1 and s2
initial begin: string_builtin_function
  string s1, s2, s3;
  int i1;
  wait(b_string_builtin_function == 1); $display("string_builtin_function process block started");
  s1 = "RockerIC is established in ";
  i1 = 2015;
  s2.itoa(i1); // integer converted to string
  s3 = {s1.len()+s2.len(){" "}}; // try to comment this line and check the result
  for(int i=0; i<s1.len()+s2.len(); i++) begin
    s3[i] = i < s1.len() ? s1[i] : s2[i-s1.len()]; 
  end
  $display("s3 content: %s", s3);
end

endmodule
