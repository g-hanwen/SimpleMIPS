# Test File for 21 Instruction, include:
# ADD/SUB/ADDU/SUBU/AND/OR/ADDI/ORI/SLL/SRL/SRA/LUI/SLT/SLTI/LW/SW/BEQ/BNE/JAL/JR/J
################################################################
### Make sure following Settings :
# Settings -> Memory Configuration -> Compact, Data at address 0

 L0:      lui   $1,0x8000
          ori $1,$1,0x2211   #  $1=0x80002211
          lui   $2,0x2000
          ori $2,$2,0x4433    #  $2=0x20004433
          add $3, $2, $1   #  $3=0xa0006644
          sw $3, 0($0)      # 0($0)=0xa0006644
                  
          lui  $4,0xc000     
          ori $4,$4,0x5566   #  $4=0xc0005566
          sub  $5, $3, $4   #  $5=0xe00010de
          sw $5, 4($0)     # 4($0) =0xe00010de
          
         lw $6, 0($0)    #  $s6=0xa0006644
         slti $7,$6,0x7fff     # $7=1  $6<$5
         bne $7, $0, L2     # goto L2
L1:      j  L3
L2:      slt $8,$2,$3     #   $2=0x20004433  >   $3=0xa0006644    $8=0
         beq $8, $0, L1    # $8=0  goto L1
L3:      
          sll $9, $1, 4      #  $9 =0x00022110
          srl $10, $1, 4    #  $10 =0x08000221
          sra $11, $1, 4    #  $10 =0xf8000221
           
          ori $13, $0, 0x1234  # $13=0x1234
          ori  $14,$0,0xff    # $13=0xff
          and $15, $13, $14   # $15=0x34
          lui   $16,0xffff    # $17=0xffff0000
          or   $17, $13, $16   # $17=0xffff1234
          jal L4  
          j   L0

L4:  
         addu  $18, $2, $1   #  $18=20004433+80002211 = 0xa0006644
         subu  $19, $3, $4   #  $19=a0006644- c0005566= 0xe00010de 
         lw $20, 0($0)     # $20 =0xa0006644
         sw $20, 8($0)     # 8($0) =0xa0006644
         addi $21,$20, 0x8000      # $21 =0xa000e644 
         addi $22,$20, -0x1000   # $22 =0xa0005644 
         jr  $ra
