module decoder(out1, out2, in);
    output out1, out2;
    input in;
    
    not(out1, in);
    assign out2 = in;
    
endmodule