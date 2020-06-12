# check-relitive-primerity

Harry wants to check the relative primerity of 2 numbers. For this purpose, he checks the GCD (Greatest
Common Divisor) of the numbers. If GCD comes out 1 then numbers are relative prime to each other.
Harry’s requirements are as follows:

Subroutine DEC_IN should load two registers (BX and DX) with two numbers. Numbers should be a 2 - digit decimal ranging from (01 - 99).
Subroutine GCD_AB apply the logic for GCD of two numbers. GCD of two numbers is performed as
follows:

1) Given two numbers, one in bx and other in dx
2) If bx=dx, GCD is bx, move to step 5
3) In case bx&amp;lt;dx, swap both so that bx has greater value and dx has smaller one.
4) Repeat until dx is not zero:
a) bx = bx mod dx
b) swap values of bx and dx
5) If bx=1, then GCD is 1 and the numbers provided in DEC_IN are relatively prime.

Subroutine DEC_OUT should display the GCD and print whether the numbers were relatively prime
or not.
