module maj_3(out,a,b,c);
  input a,b,c;
  output out;
  assign out=(a&b)|(a&c)|(b&c);
endmodule

module maj_5(out,a,b,c,d,e);
  input a,b,c,d,e;
  output out;
  assign out = (a&b&c)|(a&b&d)|(a&b&e)|(a&c&d)|(a&c&e)|(a&d&e)|(b&c&d)|(b&c&e)|(b&d&e)|(c&d&e);
endmodule

module maj_fa(sum,cout,a,b,c);
  input a,b,c;
  output sum,cout;
  wire x,y,z;
  maj_3 m3(cout,a,b,c);
  assign x=~cout;
  assign y=~cout;
  maj_5 m5(sum,a,b,c,x,y);
endmodule

module maj_fa_TB();
  reg A,B,C;
  wire SUM,COUT;
  
  maj_fa maj1(.sum(SUM),.cout(COUT),.a(A),.b(B),.c(C));
  initial
    begin
        A=1'b0;B=1'b0;C=1'b0;
        #1000;
        A=1'b0;B=1'b0;C=1'b1;
        #1000;
        A=1'b0;B=1'b1;C=1'b0;
        #1000;
        A=1'b0;B=1'b1;C=1'b1;
        #1000;
        A=1'b1;B=1'b0;C=1'b0;
        #1000;
        A=1'b1;B=1'b0;C=1'b1;
        #1000;
        A=1'b1;B=1'b1;C=1'b0;
        #1000;
        A=1'b1;B=1'b1;C=1'b1;
        #1000;
      end
endmodule
        
        