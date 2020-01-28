; inline assembly, line 2
[bits 16]
[org 0x7c00]
; [ function: start() ]
start:
    push ebp
    mov ebp, esp
    sub esp, 1    ; allocate space for local variables
    ; ch = [ebp - 1], byte
; line: 16, func_call: clear_screen
    call clear_screen
; for loop, line 18
; line 18
    mov al, 65
    mov byte[ebp - 1], al
.for_loop1:
; condition checking, line 18
    cmp byte[ebp - 1], 90
    jg .exit_for_loop1
; line 19
    mov al, byte[ebp - 1]  ; assignment ch
    mov byte[pchar], al
; line: 20, func_call: print_char
    call print_char
; line 18
    inc byte[ebp - 1]    ; ++
    jmp .for_loop1    ; jmp to for loop
.exit_for_loop1:
; line: 23, func_call: goto_newline
    call goto_newline
; line 25
    mov al, 84
    mov byte[vbuffer], al
; line 26
    mov al, 121
    mov byte[vbuffer + 1], al
; line 27
    mov al, 112
    mov byte[vbuffer + 2], al
; line 28
    mov al, 101
    mov byte[vbuffer + 3], al
; line 29
    mov al, 58
    mov byte[vbuffer + 4], al
; line 30
    mov eax, 0
    mov byte[vbuffer + 5], al
; line: 32, func_call: print_array
    call print_array
; line: 33, func_call: goto_newline
    call goto_newline
; line: 33, func_call: goto_newline
    call goto_newline
; line: 35, func_call: input_test
    call input_test
._exit_start:
    mov esp, ebp
    pop ebp
    ret 
; [ function: print_array() ]
print_array:
    push ebp
    mov ebp, esp
    sub esp, 1    ; allocate space for local variables
    ; i = [ebp - 1], byte
; for loop, line 40
; line 40
    mov eax, 0
    mov byte[ebp - 1], al
.for_loop1:
; condition checking, line 40
    cmp byte[ebp - 1], 32
    jge .exit_for_loop1
; line 41
    xor ecx, ecx
    mov cl, byte[ebp - 1]
    mov al, byte[vbuffer + ecx * 1]
    mov byte[pchar], al    ; line: 41
; condition checking, line 42
    cmp byte[pchar], 0
    je .if_label1
    jmp .else_label1
.if_label1:
    jmp .exit_for_loop1    ; break loop, line 43
    jmp .exit_if1
.else_label1:
; line: 45, func_call: print_char
    call print_char
.exit_if1:
; line 40
    inc byte[ebp - 1]    ; ++
    jmp .for_loop1    ; jmp to for loop
.exit_for_loop1:
._exit_print_array:
    mov esp, ebp
    pop ebp
    ret 
; [ function: input_test() ]
input_test:
    push ebp
    mov ebp, esp
    sub esp, 3    ; allocate space for local variables
    ; key_code = [ebp - 3], byte
    ; key = [ebp - 2], word
; while loop, line 56
.while_loop1:
; condition checking, line 56
; line: 57, func_call: read_key
    call read_key
    mov dword[ebp - 2], eax    ; line: 57, assign
; cast expression, line 58
    mov al, byte[ebp - 2]
    mov byte[pchar], al    ; line: 58
; line 59
    xor eax, eax
    xor edx, edx
    mov eax, dword[ebp - 2]  ; key
    mov ebx, 240
    and eax, ebx
    mov word[ebp - 2], ax
; line 60
    mov ax, word[ebp - 2]  ; assignment key
    mov byte[ebp - 3], al
; condition checking, line 61
    mov al, byte[enter_key]
    cmp byte[ebp - 3], al
    je .if_label1
    jmp .else_label1
.if_label1:
; line: 62, func_call: goto_newline
    call goto_newline
    jmp .exit_if1
.else_label1:
; line: 64, func_call: print_char
    call print_char
.exit_if1:
    jmp .while_loop1    ; jmp to while loop
.exit_while_loop1:
._exit_input_test:
    mov esp, ebp
    pop ebp
    ret 
; [ function: goto_newline() ]
goto_newline:
    push ebp
    mov ebp, esp
; line 70
    inc byte[y_pos]    ; ++
; line 71
    mov eax, 0
    mov byte[x_pos], al
; line: 72, func_call: gotoxy
    call gotoxy
._exit_goto_newline:
    mov esp, ebp
    pop ebp
    ret 
; [ function: read_key() ]
read_key:
    push ebp
    mov ebp, esp
; inline assembly, line 79
    mov ax,0x00
    int 0x16
._exit_read_key:
    mov esp, ebp
    pop ebp
    ret 
; [ function: gotoxy() ]
gotoxy:
    push ebp
    mov ebp, esp
; inline assembly, line 86
    mov ah, 0x02
    mov bh, 0x00
    mov dl, byte[x_pos]
    mov dh, byte[y_pos]
    int 0x10
._exit_gotoxy:
    mov esp, ebp
    pop ebp
    ret 
; [ function: print_char() ]
print_char:
    push ebp
    mov ebp, esp
; inline assembly, line 97
    xor bx, bx
    mov bl, 10
    mov al, byte[pchar]
    mov ah, 0x0E
    int 0x10
._exit_print_char:
    mov esp, ebp
    pop ebp
    ret 
; [ function: clear_screen() ]
clear_screen:
    push ebp
    mov ebp, esp
; inline assembly, line 107
    mov al, 2
    mov ah, 0
    int 0x10
._exit_clear_screen:
    mov esp, ebp
    pop ebp
    ret 
; inline assembly, line 114
times (510 - ($ - $$)) db 0x00
dw 0xAA55

section .data
    pchar db 0
    enter_key db 0x1c


section .bss
    vbuffer resb 32
    x_pos resb 1
    y_pos resb 1

