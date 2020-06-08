.model small
.DATA
 
c dw 0  
e dw 0
y dw 0 
w dw 0 
a dw 0   
      
    
      
input  db 032h,088h,031h,0e0h
       db 043h,05ah,31h,037h
       db 0f6h,030h,98h,007h
       db 0a8h,08dh,0a2h,034h 
      
           
        
t1  db 0h,0h,0h,0h,0h,0h,0h,0h
      db 0h,0h,0h,0h,0h,0h,0h,0h
      db 0h,0h,0h,0h,0h,0h,0h,0h
      db 0h,0h,0h,0h,0h,0h,0h,0h          
      
      
           
array db 0h,0h,0h,0h
      db 0h,0h,0h,0h
      db 0h,0h,0h,0h
      db 0h,0h,0h,0h            
           
           
      
mctemp db 0,0,0,0       
      
      
sbx db 63h,7ch,77h,07bh,0f2h,06bh,06fh,0c5h,30h,01h,67h,02bh,0feh,0d7h,0abh,076h                                                                                
    db 0cah,82h,0c9h,07dh,0fah,059h,47h,0f0h,0adh,0d4h,0a2h,0afh,09ch,0a4h,72h,0c0h
    db 0b7h,0fdh,93h,26h,36h,03fh,0f7h,0cch,34h,0a5h,0e5h,0f1h,71h,0d8h,31h,15h
    db 04h,0c7h,23h,0c3h,18h,96h,05h,09ah,07h,12h,80h,0e2h,0ebh,27h,0b2h,75h
    db 09h,83h,02ch,01ah,01bh,06eh,05ah,0a0h,52h,03bh,0d6h,0b3h,29h,0e3h,02fh,84h
    db 53h,0d1h,00h,0edh,020h,0fch,0b1h,05bh,06ah,0cbh,0beh,39h,04ah,04ch,58h,0cfh
    db 0d0h,0efh,0aah,0fbh,43h,04dh,33h,85h,45h,0f9h,02h,07fh,50h,03ch,09fh,0a8h
    db 51h,0a3h,40h,08fh,92h,09dh,38h,0f5h,0bch,0b6h,0dah,21h,10h,0ffh,0f3h,0d2h
    db 0cdh,00ch,013h,0ech,05fh,097h,044h,017h,0c4h,0a7h,07eh,03dh,64h,05dh,19h,73h
    db 60h,81h,04fh,0dch,22h,02ah,90h,88h,46h,0eeh,0b8h,14h,0deh,05eh,00bh,0dbh
    db 0e0h,32h,03ah,00ah,49h,06h,24h,05ch,0c2h,0d3h,0ach,62h,91h,95h,0e4h,79h
    db 0e7h,0c8h,037h,06dh,08dh,0d5h,04eh,0a9h,06ch,056h,0f4h,0eah,065h,07ah,0aeh,08h
    db 0bah,78h,25h,02eh,01ch,0a6h,0b4h,0c6h,0e8h,0ddh,074h,01fh,04bh,0bdh,08bh,08ah
    db 70h,03eh,0b5h,66h,48h,03h,0f6h,00eh,61h,35h,57h,0b9h,86h,0c1h,01dh,09eh
    db 0e1h,0f8h,98h,11h,69h,0d9h,08eh,94h,09bh,01eh,87h,0e9h,0ceh,55h,28h,0dfh
    db 08ch,0a1h,089h,00dh,0bfh,0e6h,42h,68h,41h,99h,02dh,00fh,0b0h,54h,0bbh,16h 
    
   
 Mc  db 02h,03h,01h,01h
     db 01h,02h,03h,01h
     db 01h,01h,02h,03h
     db 03h,01h,01h,02h
         
 key db 02bh,28h,0abh,09h
     db 07eh,0aeh,0f7h,0cfh
     db 015h,0d2h,015h,04fh
     db 016h,0a6h,088h,03ch  
    
 key1 db 0h,0h,0h,0h
     db 0h,0h,0h,0h
     db 0h,0h,0h,0h
     db 0h,0h,0h,0h    
    
 Rcon db 01h,02h,04h,08h,10h,20h,40h,80h,01Bh,36h
      db 00,00,00,00,00,00,00,00,00,00
      db 00,00,00,00,00,00,00,00,00,00
      db 00,00,00,00,00,00,00,00,00,00
        
 temp db 0,0,0,0 
 
 n_line DB 0AH,0DH,"$" 
 
 
 
      
.CODE
    xor ax,ax ; accumulator
    xor cx,cx ; counter
    xor si,si ; index
    xor di,di
    xor bp,bp    
        
    mov ax,@DATA ; to get correct address of array
    mov ds,ax    ; to get correct data segment address
                ;xor ax,ax
   


I: 
mov si,0
MOV AX,@DATA        ;for moving data to data segment
MOV DS,AX
      
XOR BX,BX        ;initially BX value is equal to 0
MOV CL,4 

lw:MOV AH,1

INT 21H 
 
CMP AL,0DH   ;compare whether the pressed key is 'ENTER' or not
JE Lw     ;If it is equal to 'Enter' then stop taking first value
         
      
CMP AL,39h   ;compare the input whether it is letter or digit.39h is the ascii value of 9
jG LETTER1
          
AND AL,0FH   ;if it is digit then convert it's ascii value to real value by masking
JMP SHIFT1
          
LETTER1:          ;if it is letter then subtract 37h from it to find it's real value
SUB AL,37H

SHIFT1:
shl AL,4
SHL BX,CL    ;shift bx 4 digit left for taking next value
OR  BL,AL    ;making 'or' will add the current value with previous value


mov t1[si],al
inc si
cmp si,32
jnz lw
MOV AH,4CH


mov si,0
mov di,0
l0:mov cx,0

mov dx,0
mov cl,t1[si]
inc si
mov dl,t1[si]

shr dx,4

add cl,dl

mov input[di],cl 
inc si
inc di
cmp di,16
jnz l0 
jmp AddRoundkey



1stRound:
     
 AddRoundkey:
        xor si,si 
        xor di,di
        xor ax,ax
        xor dx,dx
        xor bx,bx
       
 AK:    mov al,input[si]
        mov bl,key[si]
        xor al,bl
        mov input[si],al
        inc si
        cmp si,16
        jz  Rounds9
        jmp AK  
        
      
Rounds9:
        cmp y,9
        je FinalRound
        inc y
        jmp Subbytes


           
SubBytes:
        xor si,si
        
SB: cmp si , 16        ; compare index with length of array
    jz ShiftRows               ; if index == length then terminate proc
   
    mov bl,input[si]    ; put array[0] in bl
    mov al,sbx[bx]      ;  put sbx [ value of array[0] ] in al
    mov input[si],al     ;  overwrite sbx value in array[0]
   
    inc si
    jmp SB
                              


;                  
              
ShiftRows: 
    xor si,si
  
    shiftrow1:  
        ;cmp si,4 
        inc si
        cmp si,4
        jnz jmp shiftrow1
        mov al, input[si]
        push ax
        mov al,input[5]
       
        mov input[4],al
        
        mov al,input[6]
        mov input[5],al
        mov al,input[7]
        mov input[6],al
        pop dx
        mov input[7],dl
        
        
       
 shiftrow2:      
       
      
        inc si
        
        cmp si,8
        jnz jmp shiftrow2
       
        mov al,input[si]
        push ax    
            mov al,input[9]
         mov input[8],al
        mov al,input[10]
        mov input[9],al
        mov al,input[11]
        mov input[10],al
       
        pop dx
        mov input[11] ,dl
        cmp si,8   
       
        mov al,input[si]
        push ax    
            mov al,input[9]
         mov input[8],al
        mov al,input[10]
        mov input[9],al
        mov al,input[11]
        mov input[10],al
       
        pop dx
        mov input[11] ,dl
        jmp shiftrow3

 shiftrow3:   
        cmp si,15
        jz MixColumns
        cmp si,12
          inc si
        
        cmp si,12
        jnz jmp shiftrow3
        mov al,input[si]
      
        push ax    
            mov al,input[13]
         mov input[12],al
        mov al,input[14]
        mov input[13],al
        mov al,input[15]
        mov input[14],al
       
        pop dx
        mov input[15] ,dl
       
         cmp si,12
     
        mov al,input[si]
       push ax    
            mov al,input[13]
         mov input[12],al
        mov al,input[14]
        mov input[13],al
        mov al,input[15]
        mov input[14],al
       
        pop dx
        mov input[15] ,dl
         cmp si,12
        mov al,input[si]
         push ax    
         mov al,input[13]
        mov input[12],al
        mov al,input[14]
        mov input[13],al
         mov al,input[15]
         mov input[14],al
       
        pop dx
        mov input[15] ,dl
        inc si
        jmp shiftrow3
              
           
       
                
              
MixColumns: 
       xor si,si
       xor di,di
       xor bp,bp
       xor ax,ax
       xor bx,bx
       xor cx,cx 
       mov e,0
       mov c,0       
                     
loop1: cmp e,41h
       je Input0 
       cmp c,4
       je Xoring
       cmp di,16
       je plus
       jmp continue
 
plus:  
       xor di,di
       mov bx,1
       mov al,input[1]
       mov input[0],al
       mov al,input[2]
       mov input[1],al
       mov al,input[3]
       mov input[2],al
       mov al,input[4]
       mov input[3],al
       mov al,input[5]
       mov input[4],al
       mov al,input[6]
       mov input[5],al
       mov al,input[7]
       mov input[6],al
       mov al,input[8]
       mov input[7],al
       mov al,input[9]
       mov input[8],al
       mov al,input[10]
       mov input[9],al
       mov al,input[11]
       mov input[10],al
       mov al,input[12]
       mov input[11],al
       mov al,input[13]
       mov input[12],al
       mov al,input[14]
       mov input[13],al
       mov al,input[15]
       mov input[14],al
          cmp e,20h
          je ad
          cmp e,30h
          je ad1



continue:
       inc c             
       mov dl,Mc[di]       
       inc e
       cmp dl,01
       je one       
              
       cmp dl,02
       je two
                                  
       jmp three
      

      
one:
       mov cl,input[si]
       mov mctemp[bp],cl
     
       add si,4
       inc di 
       inc bp
       jmp loop1
two:
     mov cl,input[si]                     
     
     cmp cl,80h
     js B1
     shl cl,1
     

mo:  mov mctemp[bp],cl
     add si,4
     inc di 
     inc bp
     jmp loop1
   
B1:     shl cl,1

     xor cl,1Bh    
     jmp mo
three:
     mov cl,input[si]
     
     cmp cl,80h
     js B2
     shl cl,1
     xor cl,input[si]

mo2: 

     mov mctemp[bp],cl
     add si,4
     inc di
     inc bp
     jmp loop1
     
B2:   
     shl cl,1

     xor cl,1Bh    
     xor cl,input[si]
     jmp mo2
     
     
Xoring:
    
     mov c,0
     xor si,si
     xor bp,bp
     
             
D:  mov al,mctemp[0]
     
    xor al,mctemp[1]
     
    xor al,mctemp[2]
     
    xor al,mctemp[3]
 
      
     mov array[bx],al
     add bx,4
    
     jmp loop1 
      
ad:
add bx,1
jmp continue 
ad1: 
add bx,2
jmp continue     
      
      
Input0:
      xor si,si  
      xor di,di
      xor bp,bp
      xor ax,ax
      xor bx,bx
      
BA:      
    mov al,array[si]  
    mov input[di],al  
    inc si  
    inc di  
    cmp si,16
    jz KeyScheduling
    jmp BA
    
    
    
      
              
                    
KeyScheduling: 
          xor si,si
          xor di,di 
          xor ax,ax
                  
;Move Last Column in temp
     mov di,3 
  L1:mov al,key[di]      
     mov temp[si],al
     inc si
     cmp si,4
     je L2
     add di,4
     jmp L1
    
;Rotate                
 L2: xor si,si       
     mov al, temp[0]
     push ax
     mov al,temp[1]
     mov temp[0],al
     mov al,temp[2]
     mov temp[1],al
     mov al,temp[3]
     mov temp[2],al
     pop dx
     mov temp[3],dl
    
     jmp L3
     
;Change to Subbytes    
L3:   
    cmp si,4                  ; compare index with length of array
    jz L4              ; if index == length then terminate proc
   
    mov bl, temp[si]    ; put array[0] in bl
    mov al ,sbx[bx]     ;  put sbx [ value of array[0] ] in al
    mov temp[si],al     ;  overwrite sbx value in array[0]
   
    inc si
    jmp L3
   
;Xor with Rcon and 1st Column in key 0          
L4:  xor di,di
     xor si,si
     xor bx,bx
     add bx,a
            
L5:  mov al,Rcon[bx]     
     mov cl,temp[di]
     xor cl,al
     xor cl,key[si]
    
     mov key1[si],cl
         
     add si,4
     add bx,10
     inc di
      
     cmp di,4
     jz L6
     jmp L5
         

;xor 1st coloumn in key 1 with the coloumn before it by four (2nd coloumn in key 0)
                                                                            
L6: add a,1
    xor al,al
    xor bx,bx   ; counter 4 loops
    xor cl,cl
    xor si,si   ; index si for key1 = 0
    mov di,1    ; index di for clipher key = 1
   
L7: mov al,key1[si]   ; a0
    mov cl,key[di]    ; 28
   
    xor cl,al         ; = 88
   
    mov key1[di],cl
   
    add si,4          ; si = 4
    add di,4          ; di = 5                                                         
    inc bx            ; bx = 1
   
    cmp bx,4
    jz L8
    jmp L7
   
   
L8:  
    xor al,al
    xor bx,bx   ; counter 4 loops
    xor cl,cl
    mov si,1   ; index si for key1 = 1
    mov di,2    ; index di for clipher key = 2
   
L9: mov al,key1[si] 
    mov cl,key[di]   
   
    xor cl,al         
   
    mov key1[di],cl   


    add si,4         
    add di,4                                                                   
    inc bx           
   
    cmp bx,4
    jz L10
    jmp L9
   
L10:
    xor al,al             
    xor bx,bx
    xor cl,cl
    mov si,2  
    mov di,3
   
L11:mov al,key1[si] 
    mov cl,key[di]   
   
    xor cl,al        
   
    mov key1[di],cl
   
    add si,4         
    add di,4                                                                  
    inc bx           
   
    cmp bx,4
    jz Original
    jmp L11 
    
    
Original:
        xor si,si       
        xor di,di
        xor ax,ax 
        
    O1: mov al,key1[si]
        mov key[di],al
        inc si
        inc di
        cmp di,16
        jz AddRoundKey0
        jmp O1
        
        
AddRoundKey0: 
   
        xor si,si
        xor di,di
        xor ax,ax
        xor bx,bx
        
 As:    mov al,input[si]
        mov bl,key1[si]
        xor al,bl
        mov input[si],al
        inc si  
        cmp si,16
        jz  Rounds9
        jmp As  
 

 



  
 
FinalRound:
     xor si,si
     xor di,di
     xor ax,ax
     xor bx,bx     
           
    SubBytes1: 
    cmp si , 16      ; compare index with length of array
    jz ShiftRows1               ; if index == length then terminate proc
   
    mov bl, input[si]    ; put array[0] in bl
    mov al ,sbx[bx]      ;  put sbx [ value of array[0] ] in al
    mov input[si],al     ;  overwrite sbx value in array[0]
   
    inc si
    jmp SubBytes1
                              
                    
              
ShiftRows1: 
        xor si,si
  
    sshiftrow1:  
        inc si
        cmp si,4
        jnz jmp sshiftrow1
        mov al, input[si]
        push ax
        mov al,input[5]
       
        mov input[4],al
        
        mov al,input[6]
        mov input[5],al
        mov al,input[7]
        mov input[6],al
        pop dx
        mov input[7],dl
        
        
       
 sshiftrow2:      
       
      
        inc si
         
        cmp si,8
        jnz jmp sshiftrow2
       
        mov al,input[si]
        push ax    
        mov al,input[9]
        mov input[8],al
        mov al,input[10]
        mov input[9],al
        mov al,input[11]
        mov input[10],al
       
        pop dx
        mov input[11] ,dl
        cmp si,8   
       
       
        mov al,input[si]
        push ax    
        mov al,input[9]
        mov input[8],al
        mov al,input[10]
        mov input[9],al
        mov al,input[11]
        mov input[10],al
       
        pop dx
        mov input[11] ,dl
        jmp sshiftrow3

 sshiftrow3:   
        cmp si,15
        jz KeyScheduling1
        cmp si,12
        inc si
        
        cmp si,12
        
        jnz jmp sshiftrow3
        mov al,input[si]
        push ax   
        mov al,input[13]
        mov input[12],al
        mov al,input[14]
        mov input[13],al
        mov al,input[15]
        mov input[14],al
       
        pop dx
        mov input[15] ,dl
       
        cmp si,12
    
        mov al,input[si]
        push ax    
        mov al,input[13]
        mov input[12],al
        mov al,input[14]
        mov input[13],al
        mov al,input[15]
        mov input[14],al
       
        pop dx
        mov input[15] ,dl
        
        cmp si,12
        
        mov al,input[si]
        push ax    
        mov al,input[13]
        mov input[12],al
        mov al,input[14]
        mov input[13],al
        mov al,input[15]
        mov input[14],al
       
        pop dx
        mov input[15],dl
        
        inc si
        jmp sshiftrow3
              
 
 
 KeyScheduling1: 
       xor si,si
       xor di,di 
       xor ax,ax
       xor bx,bx
                
;Move Last Column in temp
     mov di,3 
     
  LL1:
     mov al,key[di]      
     mov temp[si],al
     inc si
     cmp si,4
     je LL2
     add di,4
     jmp LL1
    
;Shift left                
 LL2: 
     xor si,si       
     mov al, temp[0]
     push ax
     mov al,temp[1]
     mov temp[0],al
     mov al,temp[2]
     mov temp[1],al
     mov al,temp[3]
     mov temp[2],al
     pop dx
     mov temp[3],dl
    
     jmp L33
     
;Change to Subbytes    
L33:   
    cmp si,4                  ; compare index with length of array
    jz L44              ; if index == length then terminate proc
   
    mov bl, temp[si]    ; put array[0] in bl
    mov al ,sbx[bx]     ;  put sbx [ value of array[0] ] in al
    mov temp[si],al     ;  overwrite sbx value in array[0]
   
    inc si
    jmp L33
   
;Xor with Rcon and 1st Column in key 0          
L44: xor di,di
     xor si,si
     xor bx,bx
     mov bx,a
            
L55: mov al,Rcon[bx]     
     mov cl,temp[di]
     xor cl,al
     xor cl,key[si]
    
     mov key1[si],cl
         
     add si,4
     add bx,10
     inc di
      
     cmp di,4
     jz L66
     jmp L55
         

;xor 1st coloumn in key 1 with the coloumn before it by four (2nd coloumn in key 0)
                                                                            
L66:
    xor al,al
    xor bx,bx   ; counter 4 loops
    xor cl,cl
    xor si,si   ; index si for key1 = 0
    mov di,1    ; index di for clipher key = 1
   
L77:mov al,key1[si]   ; a0
    mov cl,key[di]    ; 28
   
    xor cl,al         ; = 88
   
    mov key1[di],cl
   
    add si,4          ; si = 4
    add di,4          ; di = 5                                                         
    inc bx            ; bx = 1
   
    cmp bx,4
    jz L88
    jmp L77
   
   
L88:  
    xor al,al
    xor bx,bx   ; counter 4 loops
    xor cl,cl
    mov si,1   ; index si for key1 = 1
    mov di,2    ; index di for clipher key = 2
   
L99:mov al,key1[si] 
    mov cl,key[di]   
   
    xor cl,al         
   
    mov key1[di],cl   


    add si,4         
    add di,4                                                                   
    inc bx           
   
    cmp bx,4
    jz L100
    jmp L99
   
L100:
    xor al,al             
    xor bx,bx
    xor cl,cl
    mov si,2  
    mov di,3
   
L111:mov al,key1[si] 
    mov cl,key[di]   
   
    xor cl,al        
   
    mov key1[di],cl
   
    add si,4         
    add di,4                                                                  
    inc bx           
   
    cmp bx,4
    jz Original0
    jmp L111    
       
Original0:
        xor si,si       
        xor di,di
        xor al,al 
        
    O11:mov al,key1[si]
        mov key[di],al
        inc si
        inc di
        cmp di,16
        jz AddRoundKey2
        jmp O11
         
AddRoundkey2:
        xor si,si 
        xor ax,ax
        xor bx,bx
          
AR:     mov al,input[si]
        mov bl,key1[si]
        xor al,bl
        mov input[si],al
        inc si
        cmp si,16
        jz  OUTPUT
        jmp AR
 
 
    
    
    
   
    
 
OUTPUT:   
;;;;;;;;;;;;;;;;print new line;;;;;;;;;;;;;;;;
    xor ax,ax
    xor dx,dx

    LEA DX,n_line ;lea means least effective address
    MOV AH,9
    INT 21H       ;print new line 

  
    LEA DX,n_line 
    MOV AH,9
    INT 21H       

      
    xor si,si 
    xor di,di
    xor ax,ax
    xor dx,dx
    xor bx,bx
     
    xor ch,ch ; ch initially zero
    mov cx,0  ; put 4 in cx to 
    mov ah,2  ; used to print a character 
      
    la2: 
    cmp si,16
    jz endcode 
    mov bh,input[si]
    inc si
   
    
    
    for:  
    mov dl,bh  ; put the first element w need to print in dl 
    shr dl,4   ;shift dl right by 4  
    shl bx,4   ; shift bx left by 4  
    
    cmp dl,10  ;cmp by 10 to see ifif it's a letter 
    jge Letter ; if its a letter jump to (if greater than or equal 10 then a letter )  
    
    ;if not then a digit
    
    add dl,48  ; getting the ascii value of the digit by adding 48 to the digit 
    int 21h    ; print it 
    jmp endloop 
            
            
    letter:
    add dl,55   ; getting the axcii value of the letter by adding 55 to the letter 
    int 21h     ; print it 
    
    endloop: ; repeat for next value 
    inc cx 
    cmp cx,2
    jnz for
    mov cx,0
    jmp la2
    
            
  endcode: mov ah,4ch ; exit code 
           int 21h 