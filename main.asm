section .data
    star db '*', 0
    space db ' ', 0
    newline db 10, 0
    rows db 5

section .bss
    current_row resb 1
    current_col resb 1
    spaces_count resb 1

section .text
    global _start

_start:
    mov byte [current_row], 1

row_loop:
    mov al, [rows]
    sub al, [current_row]
    mov [spaces_count], al
    mov byte [current_col], 0

print_spaces:
    mov al, [spaces_count]
    cmp [current_col], al
    jge print_stars_start
    
    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80
    
    inc byte [current_col]
    jmp print_spaces

print_stars_start:
    mov byte [current_col], 0

print_stars:
    mov al, [current_row]
    add al, [current_row]
    dec al
    cmp [current_col], al
    jge print_newline
    
    mov eax, 4
    mov ebx, 1
    mov ecx, star
    mov edx, 1
    int 0x80
    
    inc byte [current_col]
    jmp print_stars

print_newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    
    inc byte [current_row]
    mov al, [rows]
    cmp [current_row], al
    jle row_loop

exit:
    mov eax, 1
    mov ebx, 0
    int 0x80