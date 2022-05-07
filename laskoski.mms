% Author: Kenneth Laskoski <kennethlaskoski@po...>
% program 5.2-C  
% 2003-02-09 15:55
%
% MMixMasters,
%
% Here goes an MMIXAL implementation of the comparision counting program from
% section 5.2 of The Art of Computer Programming. This program is an almost
% automatic translation of the MIXAL version, the only difference is the
% addition of a LOAD instruction (at 3H) because MIX compares a register and a
% memory cell, while MMIX compares two registers.
% 	This is my first MMIX program, and I would appreciate any feedback.
% 
% Kenneth Laskoski

%	This implements program 5.2-C from TAOCP
%	Comparision counting

i	IS	$0			8*i
j	IS	$1			8*j
a	IS	$2			K[i]
b	IS	$3			K[j]
c	IS	$4			count[i]
cmp	IS	$5
tmp	IS	$6

n	GREG	16
input	GREG	Data_Segment-1
count	GREG	Pool_Segment-1
	LOC	#100

Main	SL	i,n,3			C1. Clear counts.
	STCO	0,count,i		count[i] = 0.
	SUB	i,i,8
	PBP	i,@-4*2			n >= i > 0.
	SL	i,n,3			C2. Loop on i.
	JMP	1F
2H	LDO	c,count,i
	LDO	a,input,i
3H	LDO	b,input,j		C4. Compare K[i] : K[j].
	CMP	cmp,a,b
	PBNN	cmp,4F			jump if K[i] >= K[j].
	LDO	tmp,count,j			   count[j]
	ADD	tmp,tmp,1				    + 1.
	STO	tmp,count,j		count[j] =
	JMP	5F
4H	ADD	c,c,1			count[i] += 1.
5H	SUB	j,j,8			C3. Loop on j.
	PBP	j,3B
	STO	c,count,i
	SUB	i,i,8
1H	SUB	j,i,8			n >= i > j > 0.
	PBP	j,2B

	TRAP	0,Halt,0

	LOC	Data_Segment
	OCTA	503
	OCTA	087
	OCTA	512
	OCTA	061
	OCTA	908
	OCTA	170
	OCTA	897
	OCTA	275
	OCTA	653
	OCTA	426
	OCTA	154
	OCTA	509
	OCTA	612
	OCTA	677
	OCTA	765
	OCTA	703



