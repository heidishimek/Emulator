.global merge_s

@ r0 = a
@ r1 = aux
@ r2 = start
@ r3 = end
@ r4 = mid
@ r5 = left
@ r6 = right
@ r7 = i

@ r8 = aux[j]
@ r10 = a[left]
@ r11 = a[right]
@ r12 = j
@ r13 = aux[i]

merge_s:
    sub sp, sp, #16                     @ allocate space
    str lr, [sp]                        @ preserve lr
    str r10, [sp, #4]                   @ preserve r10
    str r11, [sp, #8]                   @ preserve r11
    str r13, [sp, #12]                  @ preserve r13

    add r4, r2, r3                      @ mid = start + end 
    asr r4, r4, #1                      @ mid / 2
    mov r5, r2                          @ left = start
    add r6, r4, #1                      @ right = mid + 1

    mov r7, r5                          @ i = start (left)
    mov r12, r2                         @ j = start

loop:
    cmp r7, r3                          @ i <= end
    bgt copy

    add r4, r4, #1                      @ mid + 1
    cmp r5, r4                          @ left == mid
    beq left                  

    add r3, r3, #1                      @ end + 1
    cmp r6, r3                          @ right == end
    beq right

    ldr r10, [r0, r5, LSL #2]           @ a[left]
    ldr r11, [r0, r6, LSL #2]           @ a[right]   
    cmp r10, r11                        @ a[left] < a[right]
    blt right                           

    b else

left:
    ldr r13, [r1, r7, LSL #2]           @ aux[i]
    mov r11, r13                        @ a[right] = aux[i]

    add r6, r6, #1                      @ right ++
    add r7, r7, #1                      @ i ++
    b loop

right:
    mov r10, r13                        @ aux[i] = a[left]

    add r5, r5, #1                      @ left ++
    add r7, r7, #1                      @ i ++
    b loop

else:
    mov r10, r13                        @ aux[i] = a[right]

    add r6, r6, #1                      @ right ++
    add r7, r7, #1                      @ i ++

copy:
    cmp r12, r3                         @ j <= end
    bgt done

    ldr r8, [r1, r12, LSL #2]          @ aux[j]
    str r8, [r0, r12, LSL #2]          @ aux[j] = a[j]

    add r12, r12, #1                   @ j++
    b copy

done:
    ldr lr, [sp]                       @ restore lr
    ldr r10, [sp, #4]                  @ restore r10
    ldr r11, [sp, #8]                  @ restore r11
    ldr r13, [sp, #12]                 @ restotr r13
    add sp, sp, #16                    @ deallocate space

    bx lr
   