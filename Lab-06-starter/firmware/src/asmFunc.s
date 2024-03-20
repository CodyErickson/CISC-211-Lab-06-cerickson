/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */

.global dividend,divisor,quotient,mod,we_have_a_problem
.type dividend,%gnu_unique_object
.type divisor,%gnu_unique_object
.type quotient,%gnu_unique_object
.type mod,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
dividend:          .word     0  
divisor:           .word     0  
quotient:          .word     0  
mod:               .word     0 
we_have_a_problem: .word     0

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: 
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    mov r0,r0
.endif
    
    /** note to profs: asmFunc.s solution is in Canvas at:
     *    Canvas Files->
     *        Lab Files and Coding Examples->
     *            Lab 5 Division
     * Use it to test the C test code */
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/  
    
    /* load all variables into their respective registers */
    LDR r8, =dividend
    LDR r3, [r8]
    
    LDR r9, =divisor
    LDR r4, [r9]   
    
    LDR r10, =quotient
    LDR r5, [r10]
    
    LDR r11, =mod
    LDR r6, [r11]
    
    LDR r12, =we_have_a_problem
    LDR r7, [r12]
    
    /* initialize all variables to 0 */
    LDR r3, =0
    LDR r4, =0
    LDR r5, =0
    LDR r6, =0
    LDR r7, =0
    
    MOVS r3, r0           /* copy input value to dividend */
    STR r3, [r8]          /* store dividend value in memory */
    MOVS r4, r1           /* copy input value to divisor */
    STR r4, [r9]          /* store divisor value in memory */
    BEQ error             /* if dividend or divisor = 0, that's an error */
    STR r5, [r10]         /* store 0 in quotient memory */
    STR r6, [r11]         /* store 0 in modulo memory */

do_again:
    CMP r3, r4            /* compare dividend to divisor */
    ADDGE r5, r5, 1      /* if dividend >= divisor, increment quotient by 1 */
    SUBGE r3, r3, r4     /* if dividend >= divisor, subtract divisor from dividend until you get r */
    BGE do_again          /* if divident >= divisor, loop process again; otherwise, move forward */
    
    LDR r0, =quotient     /* load address of quotient to input value */
    STR r5, [r10]         /* store result of division calculation into quotient */
    STR r3, [r11]         /* store result of modulo calculation into mod */
    LDR r7, =0            /* make sure that an error hasn't occurred */
    STR r7, [r12]
    B done                /* branch to done */
    
    
error:
    LDR r7, =1            /* if dividend/divisor are 0, set error */
    STR r7, [r12]         /* store error value to memory */
    LDR r0, =quotient     /* load address of quotient into r0 */
    B done                /* branch to done */
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 /* this is a do-nothing line to deal with IDE mem display bug */

screen_shot:    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




