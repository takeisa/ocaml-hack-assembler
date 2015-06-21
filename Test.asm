// sum from 1 to 100
	@i // comment	
	M=1	// i=1
	@sum
	M=0	// sum=0
	
(LOOP) // comment(space)
	@i
	D=M	// D=i
	@100
	D=D-A	// D=i-100
	@END
	D;JGT	// if (i-100) > 0 then jump END
	@i
	D=M	// D=i
	@sum
	M=D+M	// sum=sum+i
	@i
	M=M+1	// i=i+1
	@LOOP
	0;JMP
(END)	    // comment(TAB+space)
	@END
	0;JMP

	

