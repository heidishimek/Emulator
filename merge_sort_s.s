.global merge_sort_s
.global merge_s

@ r0 = a
@ r1 = aux
@ r2 = start
@ r3 = end

@ r6 = mid

merge_sort_s:
    sub sp, sp, #16             @ allocate space
    str lr, [sp]                @ preserve lr
    str r2, [sp, #4]            @ preserve r2
    str r3, [sp, #8]            @ preserve r3
    str r4, [sp, #12]           @ preserve r4

    cmp r3, r2                  @ end <= start
    ble done

    add r6, r2, r3              @ mid = start + end
    lsr r6, r6, #1              @ mid / 2

    mov r3, r6                  @ end = mid 
    bl merge_sort_s
    
    add r2, r6, #1              @ start = mid + 1
    ldr r3, [sp, #8]            @ load
    bl merge_sort_s

    ldr r3, [sp, #8]            @ restore
    ldr r2, [sp, #12]           @ restore
    bl merge_s

done:
    ldr lr, [sp]                @ restore lr
    ldr r4, [sp, #12]           @ restore r4
    ldr r3, [sp, #8]            @ restore r3
    ldr r2, [sp, #4]            @ restore r2
    add sp, sp, #16             @ deallocate

    bx lr
  