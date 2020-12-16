# Trabalho Final Arquitetura de Computadores
# Alunos: Pablo de Pádua e Rogélio Filho
# Professor: Luís Fabrício Wanderley Goés
# Alguns comentários preferi deixar em inglês pois foi a fonte onde solucionei a maioria das dúvidas que tinha.

# Registradores:
# $f4 = peso1
# $f5 = peso2
# $f6 = taxaErro
# $f7 = dados
# $f8 = taxaAprendizado
# $f9 = result
# $f10 = output
# $t3 = int i (usado em um dos FOR LOOPS)
# $t4 = int i (usado em um dos FOR LOOPS)

.data # Dados a serem utilizados
espaco: .asciiz  " "
treino: .asciiz  "Treino: "
breakline: .asciiz  "\n"
stg_peso1: .asciiz  "peso1 = "
stg_peso2: .asciiz  "peso2 = "
stg_output: .asciiz  "output: "
stg_add: .asciiz  " + "
stg_equals: .asciiz " = "
taxaAprendizado: .float   0.05
taxaErro: .float   1.1
peso1: .float   0.0
peso2: .float   0.9
floatErroMinimo: .float   0.05

.text
main1:
        # Load or store from a memory location. Just load the 32 bits into the register.
        lwc1    $f4,peso1
        lwc1    $f5,peso2
        lwc1    $f6,taxaErro
        lwc1    $f8,taxaAprendizado

# FOR LOOP
inicio_for_loop:
        li      $t3,1                        # integer i = 1
        j       true_for_loop                         

add_for_loop:                           
        move    $v0,$t3                       # add i++
        addiu   $v0,$v0,1
        move    $t3,$v0

true_for_loop:
        move    $v0,$t3                       # for i < 200
        slt     $v0,$v0,200
        beq     $v0,$zero,fim_for_loop

bodystructure_for_loop:
        move    $v0,$t3                       # data = i;
        mtc1    $v0,$f0  
        cvt.s.w $f0,$f0
        mov.s   $f7,$f0

        mov.s   $f0,$f7             
        add.s   $f0,$f0,$f0                         
        mov.s   $f10,$f0

        mov.s   $f2,$f10                    # taxa de erro calculado por = output - (peso1 + peso2) * data;
        mov.s   $f6,$f4
        mov.s   $f0,$f5
        add.s   $f0,$f6,$f0
        mov.s   $f6,$f7
        mul.s   $f0,$f0,$f6
        sub.s   $f0,$f2,$f0
        mov.s   $f6,$f0

if_condition_inicio_for_loop:
        mov.s   $f2,$f6                     # if (taxaErro < 0.05f) 
        lwc1    $f0,floatErroMinimo
        c.lt.s  $f2,$f0
        bc1t    fim_for_loop                   

fim_for_loop:

systemOutPrintln1:
                                            # sout = SystemOutPrintln;
        li      $v0, 4                      # sout espaco;
        la      $a0, espaco
        syscall

        li      $v0, 4                      # sout treino;
        la      $a0, treino
        syscall

        li      $v0, 4                       # sout taxaErro;
        la      $a0, taxaErro
        syscall

        li      $v0, 2                       # sout taxaErro;
        mov.s   $f12, $f6
        syscall

        li      $v0, 4                       # sout breakline;
        la      $a0, breakline
        syscall

inicio_for_loop2:
        move    $v0,$t3                       # se for par check = if (i % 2 == 0)
        andi    $v0,$v0,0x1
        bne     $v0,$zero,else_condicao_for_loop2

if_condicao_for_loop2:
        mov.s   $f2,$f6                     # peso1 = peso1 + (taxaErro * taxaAprendizado * dados);
        mov.s   $f0,$f8
        mul.s   $f0,$f2,$f0
        mov.s   $f2,$f7
        mul.s   $f0,$f0,$f2
        mov.s   $f2,$f4
        add.s   $f0,$f0,$f2
        mov.s   $f4,$f0
        j       fim_for_loop2

else_condicao_for_loop2:
        mov.s   $f2,$f6                     # peso2 = peso2 + (taxaErro * taxaAprendizado * dados);
        mov.s   $f0,$f8
        mul.s   $f0,$f2,$f0
        mov.s   $f2,$f7
        mul.s   $f0,$f0,$f2
        mov.s   $f2,$f5
        add.s   $f0,$f0,$f2
        mov.s   $f5,$f0
        j       fim_for_loop2

fim_for_loop2:
        j       add_for_loop    

systemOutPrintln2:
        li      $v0, 4                      # sout stg_peso1;
        la      $a0, stg_peso1
        syscall

        li      $v0, 2                      # sout peso1;
        mov.s   $f12, $f4
        syscall

        li      $v0, 4                      # sout breakline;
        la      $a0, breakline
        syscall

        li      $v0, 4                      # sout stg_peso2;
        la      $a0, stg_peso2
        syscall

        li      $v0, 2                      # sout peso2;
        mov.s   $f12, $f5
        syscall

        li      $v0, 4                      # sout breakline;
        la      $a0, breakline
        syscall

fim_2ndfor_loop2:

systemOutPrintln3:
        li      $v0, 4                      # sout breakline;
        la      $a0, breakline          
        syscall

# 2nd FOR LOOP STRUCTURE
inicio_2nd_for_loop:
        li      $t4,1                       # integer i = 1
        j       true_2nd_for_loop

add_2nd_for_loop:
        move    $v0,$t4                      # add i++
        addiu   $v0,$v0,1
        move    $t4,$v0

true_2nd_for_loop:
        move    $v0,$t4                      # for i < 11
        slt     $v0,$v0,11
        beq     $v0,$zero,fim_2nd_for_loop

bodystructure_2nd_for_loop:
        move    $v0,$t4                       # data = i
        mtc1    $v0,$f0
        cvt.s.w $f0,$f0
        mov.s   $f7,$f0

        mov.s   $f2,$f7                     # resultado calculado por = dados * peso1 + dados * peso2;
        mov.s   $f0,$f4
        mul.s   $f2,$f2,$f0
        mov.s   $f0,$f5
        mul.s   $f0,$f7,$f0
        add.s   $f0,$f2,$f0
        mov.s   $f9,$f0

systemOutPrintln4:
        li      $v0, 4                      # sout stg_output;
        la      $a0, stg_output
        syscall

        li      $v0, 2                      # sout dados;
        mov.s   $f12, $f7
        syscall

        li      $v0, 4                      # sout stg_add;
        la      $a0, stg_add
        syscall

        li      $v0, 2                      # sout dados;
        mov.s   $f12, $f7
        syscall

        li      $v0, 4                      # sout stg_equals;
        la      $a0, stg_equals              
        syscall

        li      $v0, 2                      # sout resultado;
        mov.s   $f12, $f9
        syscall

        li      $v0, 4                      # sout breakline;
        la      $a0, breakline          
        syscall

        j       add_2nd_for_loop

fim_2nd_for_loop:       
       	jr      $ra
# FIM!!!
