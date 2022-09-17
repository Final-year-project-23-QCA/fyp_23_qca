//the BCD adder is based on 3 input majority gate. It also follows the conventional BCD adder design wherein 2 RCadders,
//and a correction logic is used
module majadd_3(out,a,b,c);
  input a,b,c;
  output out;
  assign out = (a&b)|(a&c)|(b&c);
endmodule

module BCD_QCA(dcout,dS,dA,dB,cin);
  input [3:0] dA,dB;
  input cin;
  output [3:0] dS;
  output dcout;
  wire [3:0] bS;
  wire bcout;
  wire [2:0] cl;
  wire [10:1] c;
  wire [3:0] x;
  wire [10:1] a;
  
  majadd_3 m1(c[1],dA[0],dB[0],cin);
  majadd_3 m0(c[5],dA[1],dB[1],dB[0]);
  majadd_3 m01(c[6],dA[1],dB[1],dA[0]);
  majadd_3 m2(c[2],c[6],c[5],cin);
  majadd_3 m_03(c[9],dA[2],dB[2],dA[1]);
  majadd_3 m_13(c[10],dB[1],dB[2],dA[2]);
  majadd_3 m3(c[3],c[1],c[9],c[10]);
  majadd_3 m02(c[7],dA[3],dB[3],dB[2]); 
  majadd_3 m03(c[8],dA[3],dB[3],dA[2]);
  majadd_3 m4(c[4],c[2],c[7],c[8]);
  
  majadd_3 mc0(x[0],dA[0],dB[0],~c[1]);
  majadd_3 mc1(x[1],dA[1],dB[1],~c[2]);
  majadd_3 mc2(x[2],dA[2],dB[2],~c[3]);
  majadd_3 mc3(x[3],dA[3],dB[3],~c[4]);
  
  majadd_3 ms0(bS[0],x[0],cin,~c[1]);
  majadd_3 ms1(bS[1],c[1],x[1],~c[2]);
  majadd_3 ms2(bS[2],c[2],x[2],~c[3]);
  majadd_3 ms3(bS[3],c[3],x[3],~c[4]);
  
  assign bcout = c[4];      //debugger : there are no mistakes till here,the ADD1 circuit works well (line 1-42)
  
  majadd_3 clc0(cl[0],bS[1],bS[2],bS[3]);   //correction logic circuit(detects if there is a carry or not) lines 44-46
  majadd_3 clc1(cl[1],bS[3],1'b1,bcout);    //mistake 1'b0 <==> 1'b1
  majadd_3 clc2(dcout,bcout,cl[0],cl[1]); //dcout computation
  
  assign dS[0]=bS[0];                    //dS0
  
  majadd_3 add1(a[1],1'b1,bS[1],dcout);
  majadd_3 add2(a[2],1'b0,bS[1],dcout);
  majadd_3 add3(dS[1],1'b0,a[1],~a[2]); //dS1
  
  majadd_3 add4(a[3],a[2],bS[2],dcout);
  majadd_3 add5(a[4],~a[3],bS[2],dcout);
  majadd_3 add6(dS[2],a[4],~a[3],a[2]); //dS2
  
  majadd_3 add7(a[5],1'b0,~bS[3],dcout);
  majadd_3 add8(a[6],~dcout,dS[3],1'b0);
  majadd_3 add9(a[7],1'b0,a[5],bS[1]);
  majadd_3 add10(dS[3],a[7],1'b1,a[6]); //dS3
endmodule
  
  
  
  
  
  
    
  
   
  
  

