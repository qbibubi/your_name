section .rodata
  welcome_message db  "Welcome! What is your name?", 0Ah, 0h
  welcome_name  db  "Welcome ", 0h
  
section .bss
  name: resb 32

section .text
  global _start
  global strlen
  global print

_start:
  push welcome_message
  call print

  call input

  push welcome_name
  call print

  push name
  call print

  mov rax, 60 ; sys_exit
  mov rdi, 1
  syscall

strlen:  
  push rcx
  mov rcx, 0  
.strlen_loop:
  movzx rax, byte [rsi + rcx]
  test rax, rax
  jz .strlen_loop_end
  inc rcx
  jmp .strlen_loop
.strlen_loop_end:
  mov rax, rcx
  pop rcx
  ret

print:
  push rbp
  mov rbp, rsp

  mov rsi, qword [rbp+16]
  call strlen

  mov rdx, rax
  mov rdi, 1
  mov rax, 1
  syscall

  pop rbp
  ret 

input:
  push rbp
  mov rbp, rsp

  mov rax, 0
  mov rdi, 0
  mov rsi, name
  mov rdx, 32
  syscall

  pop rbp
  ret