
module mux(out, in1, in2, sel);
    output out;
    input in1, in2, sel;
    wire l1, l2, l3, l4;
    
    decoder dec(l1, l2, sel);
    
    and A1(l3, in1, l1);
    and A2(l4, in2, l2);
        
    or  O(out, l3, l4);
    
endmodule
    