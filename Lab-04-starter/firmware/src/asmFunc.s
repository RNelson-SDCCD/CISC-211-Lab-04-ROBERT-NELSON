/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */
/* create a string */
.global nameStr
.type nameStr,%gnu_unique_object
    
/*** STUDENTS: Change the next line to your name!  **/
nameStr: .asciz "Robert Nelson"  

.align   /* realign so that next mem allocations are on word boundaries */
 
/* initialize a global variable that C can access to print the nameStr */
.global nameStrPtr
.type nameStrPtr,%gnu_unique_object
nameStrPtr: .word nameStr   /* Assign the mem loc of nameStr to nameStrPtr */

.global balance,transaction,eat_out,stay_in,eat_ice_cream,we_have_a_problem
.type balance,%gnu_unique_object
.type transaction,%gnu_unique_object
.type eat_out,%gnu_unique_object
.type stay_in,%gnu_unique_object
.type eat_ice_cream,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
balance:           .word     0  /* input/output value */
transaction:       .word     0  /* output value */
eat_out:           .word     0  /* output value */
stay_in:           .word     0  /* output value */
eat_ice_cream:     .word     0  /* output value */
we_have_a_problem: .word     0  /* output value */

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align


    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: the integer value returned to the C function
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    
    /* START set all output variables to ZERO */
    
    ldr r1, =eat_out
    ldr r2, =0
    str r2, [r1]
    
    ldr r1, =eat_ice_cream
    ldr r2, =0
    str r2, [r1]
    
    ldr r1, =stay_in
    ldr r2, =0
    str r2, [r1]
    
    ldr r1, =we_have_a_problem
    ldr r2, =0
    str r2, [r1]
    
    /* END Set all output variables to ZERO */
    
    
    /* Copy value passed into r0 to transaction */
    ldr r1, =transaction
    str r0, [r1]
    
    /* Compare value of transaction, should be >= -1000 and <= 1000 */
    ldr r2, =-1001
    cmp r0, r2
    blt problem
    
    ldr r2, =1001
    cmp r0, r2
    bgt problem
    
    /* Load the value of balance */
    ldr r2, =balance
    ldr r1, [r2]
    
    /* Add balance and transaction = temp_bal, update flags, store temp_bal
	as new bal */
    adds r3, r0, r1
    str r3, [r2]
    bvs problem	    /* Check for signed overflow */
    
    /* Check if bal > 0 or bal < 0 */
    mov r1, r3
    ldr r3, =0
    cmp r1, r3
    bne check_sign	/* If bal != 0 check its sign */
    
    /* If bal = 0 eat ice cream, setting its value to 1 */
    ldr r2, =eat_ice_cream
    ldr r3, [r2]
    ldr r3, =1
    str r3, [r2]
    b set_bal	    /* Set balance, storing bal in r0 */
    
    /* Check the sign of bal by comparing against 0 */
    check_sign:
    cmp r1, #0
    blt negative
    
    /* If bal > 0, eat out. Set eat_out to 1 */
    ldr r2, =eat_out
    ldr r3, [r2]
    ldr r3, =1
    str r3, [r2]
    
    b set_bal	    /* Goto set_bal to store bal in r0 */
    
    /* If bal < 0, stay in. Set stay_in to 1 */
    negative:
    ldr r2, =stay_in
    ldr r3, [r2]
    ldr r3, =1
    str r3, [r2]
    
    b set_bal	    /* Goto set_bal to store bal in r0 */
    
    /* If there is a problem, goto here */
    problem:
    /* There was no transaction made. Set transaction to 0 */
    ldr r1, =transaction
    ldr r1, [r1]
    ldr r1, =0
    str r1, [r1]
    
    /* We have a problem. Set we_have_a_problem to 1 */
    ldr r1, =we_have_a_problem
    ldr r1, [r1]
    ldr r1, =1
    str r1, [r1]
    
    /* Balance is now 0. Set balance to 0 */
    ldr r0, =balance
    ldr r0, [r0]
    ldr r0, =0
    str r0, [r0]
    
    /* Branch to done */
    b done
    
    /* Store the value of balance in r0 */
    set_bal:
    ldr r0, =balance
    ldr r0, [r0]
    str r0, [r0]
    
    /* Branch to done */
    b done
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




