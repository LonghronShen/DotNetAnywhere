; label_ops.x86.asm
.code

public get_label
get_label proc var:dword label:dword
    mov edi, label
    mov var, edi
    ret
get_label endp

public go_next
go_next proc var:dword label:dword
    mov edi, pCurOp
    add edi, 4
    mov pCurOp, edi
    jmp DWORD PTR[edi - 4]
    ret
go_next endp

end
