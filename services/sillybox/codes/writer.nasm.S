BITS 32

; This is not actually guaranteed to work in NASM...
#include <asm/unistd_32.h>

%strlen contentlen CONTENT

start:

    call tg
tg: pop edi

    lea ebx, [edi + fname-tg]   ; p1 = &fname
    mov ecx, 0o301              ; p2 = O_WRONLY|O_CREAT|O_EXCL
    mov edx, 0o600              ; p3 = 0600
    mov eax, __NR_open
    call [gs:0x10]

    mov ebx, eax                ; p1 = fd
    lea ecx, [edi + content-tg] ; p2 = &content
    mov edx, contentlen         ; p3 = contentlen
    mov eax, __NR_write
    call [gs:0x10]

    mov eax, __NR_close
    call [gs:0x10]

    mov ebx, 0
    mov eax, __NR_exit_group
    call [gs:0x10]

fname: db FILENAME, 0
content: db CONTENT

