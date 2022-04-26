.global find_max_index_s

@ r0 = arr
@ r1 = len
@ r2 = idx

find_max_index_s:
    sub sp, sp, #16             @ allocate space
    str lr, [sp]                @ preserve lr
    str r4, [sp, #4]            @ preserve r4
    str r5, [sp, #8]            @ preserve r5

    mov ip, #0                  @ i = 0
    mov r2, #0                  @ idx = 0

loop:
    cmp r1, ip                  @ end
    ble done

    ldr r4, [r0, ip, lsl #2]    @ arr[i]
    ldr r5, [r0, r2, lsl #2]    @ arr[idx]
    cmp r4, r5                  @ if arr[i] > arr[idx]
    blt next
    mov r2, ip                  @ idx = i

next:
    add ip, ip, #1              @ iterate
    b loop

done:
    mov r0, r2                  @ ret val
    ldr lr, [sp]                @ restore lr
    ldr r5, [sp, #8]            @ restore r5
    ldr r4, [sp, #4]            @ restore r4
    add sp, sp, #16             @ deallocate
    bx lr
