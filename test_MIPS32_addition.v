module test_MIPS32;

	// Inputs
	reg clk1;
	reg clk2;
	integer k;

	

	// Instantiate the Unit Under Test (UUT)
	pipe_MIPS32 mips (
		.clk1(clk1), 
		.clk2(clk2)
	);

	initial 
	begin
		// Initialize Inputs
		clk1 = 0;
		clk2 = 0;

		repeat(20) // Generating TWO-PHASE CLOCK
		begin
		#5 clk1=1 ; #5 clk1=0;
		#5 clk2=1 ; #5 clk2=0;  

	   end
	end

	initial 
	begin 
      for (k=0 ; k<31 ; k++)
	  mips.Reg[k]=k;


    mips.Mem[0] = 32'h2801000a; // ADDI R1,R0,10
	 mips.Mem[1] = 32'h28020014; // ADDI R2,R0,20
	 mips.Mem[2] = 32'h28030019; // ADDI R3,R0,25
	 mips.Mem[3] = 32'h0ce7780; // OR R7,R7,R7   --------> DUMMY INST
	 mips.Mem[4] = 32'h0ce7780; // OR R7,R7,R7   --------> DUMMY INST
	 mips.Mem[5] = 32'h00222000; // ADD R4,R1,R2
	 mips.Mem[6] = 32'h0ce7780; // OR R7,R7,R7   --------> DUMMY INST
	 mips.Mem[7] = 32'h00832800; // ADD R5,R4,R3
	 mips.Mem[8] = 32'hfc00000; // HLT

	 mips.HALTED=0;
	 mips.PC=0;
	 mips.TAKEN_BRANCH=0;

     
	  #280
      for(k=0; k<6; k++)
	  $display ("R%1d -%2d" ,k,mips.Reg[k]);
	  end 

	  initial 
	    begin 
		  $dumpfile ("mips_add.vcd");
          $dumpvars (0,test_MIPS32);
		  #300 $finish;
		 end



      
endmodule

