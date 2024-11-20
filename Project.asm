IDEAL
MODEL small
STACK 100h
DATASEG
    x dw ?
    y dw ?
    
    color db ?
    
    startX dw ?
    endX dw ?
    
    startY dw ?
    endY dw ?
	
	colorEnemy db ?
    
    startXEnemy dw ?
    endXEnemy dw ?
    
    startYEnemy dw ?
    endYEnemy dw ?
	
	displaybombbool db 0
	
	bombcolour db 15
	
filename db 'image.bmp',0
filehandle dw ?
Header db 54 dup (0)
Palette db 256*4 dup (0)
ScrLine db 320 dup (0)
ErrorMsg db 'Error', 13, 10 ,'$'

filename1 db 'Intro.bmp',0

filename2 db 'explain.bmp',0

filename3 db 'ults.bmp',0

filename4 db 'story.bmp',0

filename5 db 'Redwin.bmp',0

filename6 db 'bluewin.bmp',0

filename7 db 'Bomb.bmp',0

Clock  equ es:6Ch 

   startXshoot dw ?
   startYshoot dw ?
   endXshoot dw ?
   endYshoot dw ?  

   startXshootBrother dw ?
   startYshootBrother dw ?
   endXshootBrother dw ?
   endYshootBrother dw ?   
   
   startXBomb dw ?
   startYBomb dw ?
   endXBomb dw ?
   endYBomb dw ?
   Bombbool db 0
   
    Hp_Count_Dig db 0
    Hp_Count_Tens db 1
	Hp_Count_Dig_brother db 0
    Hp_Count_Tens_brother db 1
    Display_Hp db 'Hp:', '$'
	Display_Hp_Enemy db 'Hp:', '$'
    Display_Hp_Count_Digits db '0','$'
    Display_Hp_Count_Tens db '1','$'
	Display_Hp_Count_Digits_Brother db '0','$'
    Display_Hp_Count_Tens_Brother db '1','$'

p386

CODESEG

Cuphead db 0,	0,	0,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	0,	0, 0,	0,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,255,	255,	255,	0,	255,	0,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,255,	255,	255,	255,	255,  0, 255,	255,	255,	255,	255,	255,	255,	255,	255,	255,255,	255,	255,   255,	255,	255,	0,0,  0,	0,	0,	255,	255,	255,	255,	255,255,	255,	255,	255,	255,	255,	255,	0,	0,	0,	0,	0,	0,	0,0,	255,255,255,255,255,255,255,255,0,	0,	0,	0,	0,	0,	15,	15,	15,15,	15,	15,	15,	15,	15,	15,	15,	15,	15,	15,	15,	15,	0,	15,	15, 15,	15,	15,	15,	15,	15,	15,	15,	15,	15,	15,	15,	15,	15,	15,	15, 15,	15,	15,	15,	15,	15,	15,	15,	15,	15,	15,	15,	15,	15,	15,	15,15,	0,	0,	15,	15,	15, 15,	15,	15,	15,	15,	15,	15,	15,	15,	15,15,	15,	0,	0,	0,	0,	0,	0,	0,	7,	7,	7,	7,	7,	7,	7,0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,0,	0,	0,	0,	0,	0,	0,	0,	,	0,	0,	0,	0,	0,	0,	0,0,0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0
CupheadBrother db 0,	0,	0,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	0,	0, 0,	0, 255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,	255,255,	255,	255,	255,	0,  255, 0,	255,	255,	255,	255,	255,	255,	255,	255,	255,255,	255,	255,   255,	255,	255,	255,255,  0,	0,	0,	255,	255,	255,	255,	255,255,	255,	255,	255,	255,	255,	255,	0,	0,	0,	0,	0,	0,	0,0,	255,255,255,255,255,255,255,255,0,	0,	0,	0,	0,	0,	234,	234,	234,234, 234,	234,	234,	234,	234,	234,	234,	234,	234,	234,	234,	234,	0,	234,	234, 234,	234,	234,	234,	234,	234,	234,	234,	234,	234,	234,	234,	234,	234,	234,	234, 234,	234,	234,	234,	234,	234,	234,	234,	234,	234,	234,	234,	234,	234,	234,	234,234,	0,	0,	234,	234,	234, 234,	234,	234,	234,	234,	234,	234,	234,	234,	234,234,	234,	0,	0,	0,	0,	0,	0,	0,	7,	7,	7,	7,	7,	7,	7,0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,0,	0,	0,	0,	0,	0,	0,	0,	,	0,	0,	0,	0,	0,	0,	0,0,0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0



proc OpenFile2
; Open file
mov ah, 3Dh
xor al, al
int 21h
jc openerror
mov [filehandle], ax
ret
openerror :
mov dx, offset ErrorMsg
mov ah, 9h
int 21h
ret
endp OpenFile2

proc ReadHeader
; Read BMP file header, 54 bytes
mov ah,3fh
mov bx, [filehandle]
mov cx,54
mov dx,offset Header
int 21h
ret
endp ReadHeader

proc ReadPalette
; Read BMP file color palette, 256 colors * 4 bytes (400h)
mov ah,3fh
mov cx,400h
mov dx,offset Palette
int 21h
ret
endp ReadPalette

proc CopyPal
; Copy the colors palette to the video memory
; The number of the first color should be sent to port 3C8h
; The palette is sent to port 3C9h
mov si,offset Palette
mov cx,256
mov dx,3C8h
mov al,0
; Copy starting color to port 3C8h
out dx,al
; Copy palette itself to port 3C9h
inc dx
PalLoop:
; Note: Colors in a BMP file are saved as BGR values rather than RGB .
mov al,[si+2] ; Get red value .
shr al,2 ; Max. is 255, but video palette maximal
; value is 63. Therefore dividing by 4.
out dx,al ; Send it .
mov al,[si+1] ; Get green value .
shr al,2
out dx,al ; Send it .
mov al,[si] ; Get blue value .
shr al,2
out dx,al ; Send it .
add si,4 ; Point to next color .
; (There is a null chr. after every color.)
loop PalLoop
ret
endp CopyPal

proc CopyBitmap
; BMP graphics are saved upside-down .
; Read the graphic line by line (200 lines in VGA format),
; displaying the lines from bottom to top.
mov ax, 0A000h
mov es, ax
mov cx,200
PrintBMPLoop :
push cx
; di = cx*320, point to the correct screen line
mov di,cx
shl cx,6
shl di,8
add di,cx
; Read one line
mov ah,3fh
mov cx,320
mov dx,offset ScrLine
int 21h
; Copy one line into video memory
cld ; Clear direction flag, for movsb
mov cx,320
mov si,offset ScrLine
rep movsb ; Copy line to the screen
 ;rep movsb is same as the following code :
 ;mov es:di, ds:si
 ;inc si
 ;inc di
 ;dec cx
;loop until cx=0
pop cx
loop PrintBMPLoop
ret
endp CopyBitmap
proc CloseFile
    mov ah,3Eh
    mov bx,[filehandle]
    int 21h
    ret
endp CloseFile


proc Openfile
call OpenFile2
call ReadHeader
call ReadPalette
call CopyPal
call CopyBitmap
call CloseFile
ret
endp Openfile




proc SwitchToGraphicsMode
    mov ax, 13h
    int 10h
    
    ret
endp SwitchToGraphicsMode


proc SwitchToTextMode
    mov ax, 2
    int 10h
    
    ret
endp SwitchToTextMode


proc DisplayCuphead
    mov cx, [startX] ;x 
    mov dx, [startY] ;y
	mov bx,0
	Lp:
        mov ah, 0ch
        mov al, [Cuphead+bx] 
        mov bh, 00h
        int 10h
		
        inc cx
		inc bx
        mov ax, cx
        sub ax, [EndX] ;x
        cmp ax, 1 ;width
        jng Lp

        mov cx, [startX] ;x
        inc dx

        mov ax, dx
        sub ax, [endY] ;y
        cmp ax, 1 ;height
        jng Lp

    ret
endp DisplayCuphead


proc DisplayEnemy
    mov cx, [startXEnemy] ;x 
    mov dx, [startYEnemy] ;y
	mov bx,0
	LpEnemy:
        mov ah, 0ch
        mov al, [CupheadBrother+bx]
        mov bh, 00h
        int 10h
		
        inc cx
		inc bx	
        mov ax, cx
        sub ax, [endXEnemy] ;x
        cmp ax, 1 ;width
        jng LpEnemy

        mov cx, [StartXEnemy] ;x
        inc dx

       mov ax, dx
       sub ax, [endYEnemy] ;y
       cmp ax, 1 ;height
       jng LpEnemy

    ret
endp DisplayEnemy

proc Exit
    mov ax, 4c00h
    int 21h

    ret
endp Exit

proc EndGame
    call SwitchToTextMode
    call Exit

    ret
endp EndGame

proc Shoot
mov bx,[endX]
mov [endXshoot], bx 
mov bx, [startY]
mov [startYshoot], bx 
mov bx , [startX]
mov [startXshoot], bx
 mov cx, [endXshoot] ;x 
    mov dx,[startYshoot] ;y
	mov bx,0
	ShootLp:
	add dx , 5
        mov ah, 0ch
        mov al, 255
        mov bh, 00h
        int 10h
		
       inc cx
	   inc bx
       mov ax, cx
       sub ax, [endX] ;x
        cmp ax, 0;width
        jng ShootLp

        mov cx, [startX] ;x
        inc dx
	  
       mov ax, dx
       sub ax,[startY] ;y
       cmp ax, 0 ;height
       jng ShootLp
	
	mov   ax, 40h 
    mov   es, ax 
    mov   ax, [Clock] 
FirstTick :  
    cmp   ax, [Clock] 
    je   FirstTick 
     ;count 1 sec 
     mov cx, 18   ; 18x0.055sec = ~1sec 
DelayLoop: 
     mov ah, 1
    int 16h
	jz beforetick
	
	mov ah, 0
    int 16h
	
    cmp ah, 11h
    je CallMoveUpshoot
	
	cmp ah, 1Fh
    je CallMoveDownshoot
    
	cmp ah, 20h
   je CallMoveRightshoot
	
	cmp ah, 1eh
    je CallMoveLeftshoot
	
	cmp ah, 4bh
	je CallMoveLeftbrothershoot
	
	cmp ah, 4dh
	je CallMoveRightbrothershoot
	
	cmp ah, 50h
	je CallMoveDownbrothershoot
	
	cmp ah, 48h
	je CallMoveUpbrothershoot
	
	
	mov ax,[Clock]
	jmp Tick
	
CallMoveUpshoot:
    call MoveUp
	mov   ax, 40h 
    mov   es, ax
	mov ax,[Clock]		
    jmp Tick
	
CallMoveDownshoot:
    call MoveDown
	mov   ax, 40h 
    mov   es, ax
	mov ax,[Clock]
	jmp Tick
	
CallMoveLeftshoot:
	call MoveLeft
	mov   ax, 40h 
    mov   es, ax
	mov ax,[Clock]
	jmp Tick
	
CallMoveRightshoot:
	call MoveRight
	mov   ax, 40h 
    mov   es, ax
	mov ax,[Clock]
	jmp Tick	
	
CallMoveLeftbrothershoot:
  call MoveLeftEnemy
    mov   ax, 40h 
    mov   es, ax
	mov ax,[Clock]
	jmp Tick
	
CallMoveRightbrothershoot:
  call MoveRightEnemy
    mov   ax, 40h 
    mov   es, ax
	mov ax,[Clock]
	jmp Tick
	
CallMoveUpbrothershoot:
  call MoveUpEnemy
    mov   ax, 40h 
    mov   es, ax
	mov ax,[Clock]
	jmp Tick
	
CallMoveDownbrothershoot:
  call MoveDownEnemy
    mov   ax, 40h 
    mov   es, ax
	mov ax,[Clock]
	jmp Tick
	
	
	beforetick:
	mov ax,[Clock]
Tick : 
   cmp   ax, [Clock] 
   je   Tick 
    add [endXshoot], 10
	add [startXshoot], 10
 mov cx, [endXshoot] ;x 
    mov dx,[startYshoot] ;y
	mov cx, [endXshoot] ;x 
    mov dx,[startYshoot] ;y
	add dx , 5
        mov ah, 0ch
        mov al, 255
        mov bh, 00h
        int 10h
		mov bx, [startXEnemy]
		cmp [endXshoot], bx
		je Shoothit
		
		Checkbullet: 
		cmp [endXshoot],316
		je EndMoveshoot
		call DelayLoop
		
		CheckbullethitBomb:
		mov bx, [startXBomb]
		cmp [endXshoot], bx
		je bullethitBomb
	    
		bullethitBomb:
		mov bx , [startYBomb]
		cmp [startYshoot],bx
		je Update_Hpcallerandstopbullet
		call DelayLoop
		
		Shoothit:
		mov bx,[startYEnemy]
		cmp [startYshoot],bx
		je Update_Hpcallerandstopbullet
		call DelayLoop
		
		
		Update_Hpcallerandstopbullet:
		call HpBrother
		cmp [startYshoot],bx
		je EndMoveshoot
		call DelayLoop
		
	EndMoveshoot:
	call ReadKeyboardLoop
		ret
endp Shoot


proc ShootBrother
mov bx,[endXEnemy]
mov [endXshootBrother], bx 
mov bx, [startYEnemy]
mov [startYshootBrother], bx 
mov bx ,[startXEnemy]
mov [startXshootBrother], bx
 mov cx, [startXshootBrother] ;x 
    mov dx,[startYshootBrother] ;y
	ShootLpBrother:
	mov bx,0
	add dx , 5
        mov ah, 0ch
        mov al, 255
        mov bh, 00h
        int 10h
		
        inc cx
        mov ax, cx
        sub ax, [endX] ;x
        cmp ax, 1;width
        jng ShootLpBrother

        mov cx, [startXEnemy] ;x
        inc dx

       mov ax, dx
       sub ax,[startYEnemy] ;y
       cmp ax, 1 ;height
       jng ShootLpBrother
	
	mov   ax, 40h 
    mov   es, ax 
    mov   ax, [Clock] 
FirstTickBrother :  
    cmp   ax, [Clock] 
    je   FirstTickBrother 
     ;count 1 sec 
     mov cx, 18   ; 18x0.055sec = ~1sec 
DelayLoopBrother: 
      mov ah, 1
    int 16h
	jz beforetickBrother
	
	mov ah, 0
    int 16h

	
	  cmp ah, 48h
    je CallMoveUpshootBrother
	
	cmp ah, 50h
    je CallMoveDownshootBrother
    
	cmp ah, 4dh
   je CallMoveRightshootBrother
	
	cmp ah, 4bh
    je CallMoveLeftshootBrother
	
	cmp ah, 11h
    je CallMoveUpshootred
	
	cmp ah, 1Fh
    je CallMoveDownshootred
    
	cmp ah, 20h
   je CallMoveRightshootred
	
	cmp ah, 1eh
    je CallMoveLeftshootred
	
	mov ax,[Clock]
	jmp TickBrother
	

	
CallMoveUpshootBrother:
    call MoveUpEnemy
	mov   ax, 40h 
    mov   es, ax 
	mov ax,[Clock]		
    jmp TickBrother
	
CallMoveDownshootBrother:
    call MoveDownEnemy
	mov   ax, 40h 
    mov   es, ax 
	mov ax,[Clock]
	jmp TickBrother
	
CallMoveLeftshootBrother:
	call MoveLeftEnemy
	mov   ax, 40h 
    mov   es, ax 
	mov ax,[Clock]
	jmp TickBrother
	
CallMoveRightshootBrother:
	call MoveRightEnemy
	mov   ax, 40h 
    mov   es, ax 
	mov ax,[Clock]
	jmp TickBrother	
	
	CallMoveUpshootred:
    call MoveUp
	mov   ax, 40h 
    mov   es, ax
	mov ax,[Clock]		
    jmp TickBrother
	
CallMoveDownshootred:
    call MoveDown
	mov   ax, 40h 
    mov   es, ax
	mov ax,[Clock]
	jmp TickBrother
	
CallMoveLeftshootred:
	call MoveLeft
	mov   ax, 40h 
    mov   es, ax
	mov ax,[Clock]
	jmp TickBrother
	
CallMoveRightshootred:
	call MoveRight
	mov   ax, 40h 
    mov   es, ax
	mov ax,[Clock]
	jmp TickBrother
	
	beforetickBrother:
	mov ax,[Clock]
TickBrother : 
   cmp   ax, [Clock] 
   je   TickBrother
    sub [endXshootBrother], 10
	sub [startXshootBrother], 10
 mov cx, [endXshootBrother] ;x 
    mov dx,[startYshootBrother] ;y
	mov cx, [endXshootBrother] ;x 
    mov dx,[startYshootBrother] ;y
	add dx , 5
        mov ah, 0ch
        mov al, 255
        mov bh, 00h
        int 10h
		mov bx, [endX]
		cmp [startXshootBrother], bx
		je Shoothitbrother
		
		Checkbulletbrother: 
		cmp [endXshootBrother], 2
		je EndMoveshootBrother
		call DelayLoopBrother
	    
		Shoothitbrother:
		mov bx,[startY]
		cmp [startYshootBrother],bx
		je Update_Hpcallerandstopbullet_brother
		call DelayLoopBrother
		
		
		
		Update_Hpcallerandstopbullet_brother:
		call Hp
		cmp [startYshootBrother],bx
		je EndMoveshootBrother
		jmp DelayLoopBrother
		
	EndMoveshootBrother:
	call ReadKeyboardLoop
		ret
endp ShootBrother

proc ShootUlt
mov bx,[endXEnemy]
mov [endXshootBrother], bx 
mov bx, [startYEnemy]
mov [startYshootBrother], bx 
mov bx ,[startXEnemy]
mov [startXshootBrother], bx
 mov cx, [startXshootBrother] ;x 
    mov dx,[startYshootBrother] ;y
	ShootLpUlt:
	add dx , 5
        mov ah, 0ch
        mov al, 255
        mov bh, 00h
        int 10h
		
        inc cx
        mov ax, cx
        sub ax, [endX] ;x
        cmp ax, 1;width
        jng ShootLpUlt

        mov cx, [startXEnemy] ;x

       mov ax, dx
       sub ax,[startYEnemy] ;y
       cmp ax, 1 ;height
       jng ShootLpUlt
	   
	 secondshootult:
      sub dx , 5	 
	  mov bx,0
        mov ah, 0ch
        mov al, 255
        mov bh, 00h
        int 10h
		
        inc cx
        mov ax, cx
        sub ax, [endX] ;x
        cmp ax, 1;width
        jng ShootLpUlt

        mov cx, [startXEnemy] ;x
        inc dx

       mov ax, dx
       sub ax,[startYEnemy] ;y
       cmp ax, 1 ;height
       jng ShootLpUlt
	
	   
	   thirdshootult:
	   add dx , 2
	   mov bx,0
        mov ah, 0ch
        mov al, 255
        mov bh, 00h
        int 10h
		
        inc cx
        mov ax, cx
        sub ax, [endX] ;x
        cmp ax, 1;width
        jng ShootLpUlt

        mov cx, [startXEnemy] ;x
        inc dx

       mov ax, dx
       sub ax,[startYEnemy] ;y
       cmp ax, 1 ;height
       jng ShootLpUlt
		
	   
	
	mov   ax, 40h 
    mov   es, ax 
    mov   ax, [Clock] 
	
	
FirstTickUlt:  
    cmp   ax, [Clock] 
    je   FirstTickUlt
     ;count 1 sec 
     mov cx, 18   ; 18x0.055sec = ~1sec 
DelayLoopUlt: 
      mov ah, 1
    int 16h
	jz beforetickUlt
	
	mov ah, 0
    int 16h
	
	cmp ah, 11h
    je CallMoveUpshootUlt
	
	cmp ah, 1Fh
    je CallMoveDownshootUlt
    
	cmp ah, 20h
   je CallMoveRightshootUlt
	
	cmp ah, 1eh
    je CallMoveLeftshootUlt
	
	 
	mov ax,[Clock]
	jmp TickUlt
	
	CallMoveLeftshootUlt:
	call MoveLeft
	mov   ax, 40h 
    mov   es, ax 
	 mov   ax, [Clock] 
	 jmp TickUlt
	 
	 CallMoveDownshootUlt:
	call MoveDown
	mov   ax, 40h 
    mov   es, ax 
	 mov   ax, [Clock] 
	 jmp TickUlt
	 
	 CallMoveUpshootUlt:
	 call MoveUp
	mov   ax, 40h 
    mov   es, ax 
	 mov   ax, [Clock] 
	 jmp TickUlt
	 
	 CallMoveRightshootUlt:
	 call MoveRight
	mov   ax, 40h 
    mov   es, ax 
	 mov   ax, [Clock] 
	 jmp TickUlt
	
	beforetickUlt:
	mov ax,[Clock]
TickUlt: 
   cmp   ax, [Clock] 
   je   TickUlt
    sub [endXshootBrother], 10
	sub [startXshootBrother], 10
 mov cx, [endXshootBrother] ;x 
    mov dx,[startYshootBrother] ;y
	add dx , 5
        mov ah, 0ch
        mov al, 255
        mov bh, 00h
        int 10h
		mov bx, [endX]
		cmp [startXshootBrother], bx
		je ShoothitUlt
		secondshoot:
		sub dx, 5
		mov ah, 0ch
        mov al, 255
        mov bh, 00h
        int 10h
		cmp [startXshootBrother], bx
		je ShoothitUlt
		thirdshoot:
		add dx, 2
		mov ah, 0ch
        mov al, 255
        mov bh, 00h
        int 10h
		cmp [startXshootBrother], bx
		je ShoothitUlt
		
		
		CheckbulletUlt: 
		cmp [endXshootBrother], 2
		je EndMoveshootUlt
		call DelayLoopUlt
	    
		ShoothitUlt:
		mov bx,[startY]
		cmp [startYshootBrother],bx
		je Update_Hpcallerandstopbullet_Ult
		call DelayLoopUlt
		
		
		Update_Hpcallerandstopbullet_Ult:
		call HpBrother
		call Hp
		call Hp 
		call Hp
		cmp [startYshootBrother],bx
		je EndMoveshootUlt
		jmp DelayLoopUlt
		
	EndMoveshootUlt:
	call ReadKeyboardLoop
		ret
endp ShootUlt



proc Hp
    cmp [Hp_Count_Dig],0
    je Hp_Tens
    dec[Hp_Count_Dig]
    jmp End_Death
    Hp_Tens:
    mov [Hp_Count_Dig],9
    dec [Hp_Count_Tens]
    End_Death:
    Call Update_Hp
	CheckifBluewon:
	cmp [Hp_Count_Dig],0 
    jne endHP
	cmp [Hp_Count_Tens],0 
	jne endHP
	jmp Bluewin
	
Redwin:
mov dx, offset filename5
call Openfile
Redwinkeyboard:

 mov ah, 1
    int 16h
    jz Redwinkeyboard
    
    mov ah, 0
    int 16h
	
	cmp ah,1ch
	je Start
	
	cmp ah, 1
	je EndGame
	
	jmp Redwinkeyboard
	
	endHP:
    ret
endp Hp


proc HpBrother
    cmp [Hp_Count_Dig_brother],0 ;checking if the life digit is on 0 so I will change the asarot and yehidot
    je Hp_TensBrother
    dec[Hp_Count_Dig_brother]
    jmp End_Death_Brother
    Hp_TensBrother:
    mov [Hp_Count_Dig_brother],9
    dec [Hp_Count_Tens_brother]
    End_Death_Brother:
    Call Update_Hp_Brother
	CheckifRedwon:
	cmp [Hp_Count_Dig_brother],0 
    jne endproc
	cmp [Hp_Count_Tens_brother],0 
	jne endproc
	jmp Redwin
	
	Bluewin:
mov dx, offset filename6
call Openfile
Bluewinkeyboard:
 mov ah, 1
    int 16h
    jz Bluewinkeyboard
    
    mov ah, 0
    int 16h
	
	cmp ah,1ch
	je Start
	
	cmp ah, 1
	je EndGame
	jmp Bluewinkeyboard
	
	endproc:
    ret
endp HpBrother


proc RestoreHp
mov [Hp_Count_Tens_brother], 2
mov [Hp_Count_Dig_brother],0
mov [Hp_Count_Dig],0
mov [Hp_Count_Tens],2
mov [Display_Hp_Count_Digits],'0'
mov [Display_Hp_Count_Tens],'2'
mov [Display_Hp_Count_Digits_Brother],'0'
mov [Display_Hp_Count_Tens_Brother],'2'
endp RestoreHp



proc DisplayHP ; draws the "HP:" text
    mov ah,02h
    mov bh,0h ; page number
    mov dl, 10 ; collum number
    mov dh, 253 ; row number

    int 10h

    mov ah,09h
    lea dx,[Display_Hp]
    int 21h
    ret
endp DisplayHP

proc Update_Hp
    xor ax,ax
    mov al,[Hp_Count_Dig]
    add al,30h ;ascii
    mov [Display_Hp_Count_Digits],al
    xor ax,ax
    mov al,[Hp_Count_Tens]
    add al,30h
    mov [Display_Hp_Count_Tens],al
    call Draw_Hp_Count
    ret 
endp Update_Hp

proc Update_Hp_Brother
    xor ax,ax
    mov al,[Hp_Count_Dig_brother]
    add al,30h ;ascii
    mov [Display_Hp_Count_Digits_Brother],al
    xor ax,ax
    mov al,[Hp_Count_Tens_brother]
    add al,30h
    mov [Display_Hp_Count_Tens_Brother],al
    call Draw_Hp_Count
    ret 
endp Update_Hp_Brother

proc DisplayHPBrother; draws the "HP:" text
    mov ah,02h
    mov bh,0h ; page number
    mov dl, 200 ; collum number
    mov dh, 252 ; row number

    int 10h

    mov ah,09h
    lea dx,[Display_Hp_Enemy]
    int 21h
    ret
endp DisplayHPBrother

proc Draw_Hp_Count ;draws the hp number
     ;draws digits
    mov ah,02h
    mov bh,0h ; page number
    mov dl, 14 ; collum number
    mov dh, 253 ; row number
    int 10h

    mov ah,09h
    lea dx,[Display_Hp_Count_Digits]
    int 21h
    ;draws tens
    mov ah,02h
    mov bh,0h ; page number
    mov dl, 13 ; collum number
    mov dh, 253 ; row number
    int 10h

    mov ah,09h
    lea dx,[Display_Hp_Count_Tens]
    int 21h
    ret
endp Draw_Hp_Count


proc Draw_Hp_Count_Enemy ;draws the hp number
     ;draws digits
    mov ah,02h
    mov bh,0h ; page number
    mov dl, 204 ; collum number
    mov dh, 252 ; row number
    int 10h

    mov ah,09h
    lea dx,[Display_Hp_Count_Digits_Brother]
    int 21h
    ;draws tens
    mov ah,02h
    mov bh,0h ; page number
    mov dl, 203 ; collum number
    mov dh, 252 ; row number
    int 10h

    mov ah,09h
    lea dx,[Display_Hp_Count_Tens_Brother]
    int 21h
    ret
endp Draw_Hp_Count_Enemy


proc MoveUp
    cmp [startY], 0
    je EndMoveUp

    mov [color], 0
    call DisplayCuphead
    
    sub [startY], 10
    sub [endY], 10
    
    mov [color], 2
    
	mov dx, offset filename
 call Openfile
    call DisplayCuphead
	call DisplayEnemy
	call DisplayHP
	call Draw_Hp_Count
	call DisplayHPBrother
	call Draw_Hp_Count_Enemy

  EndMoveUp:
    ret
endp MoveUp

proc MoveUpEnemy
 cmp [startYEnemy], 0
    je EndMoveUpEnemy

    mov [colorEnemy], 0
	call DisplayEnemy
    
    sub [startYEnemy], 10
    sub [endYEnemy], 10
    
    mov [colorEnemy], 15
    
	mov dx, offset filename
 call Openfile
    call DisplayCuphead
	call DisplayEnemy
	call DisplayHP
	call Draw_Hp_Count
	call DisplayHPBrother
	call Draw_Hp_Count_Enemy


  EndMoveUpEnemy:
    ret
endp MoveUpEnemy

proc MoveDown
	cmp [startY], 190
    je EndMoveDown

    mov [color], 0
    call DisplayCuphead
    
    add [startY], 10
    add [endY], 10
    
    mov [color], 2
    
	mov dx, offset filename
 call Openfile
    call DisplayCuphead
	call DisplayEnemy
	call DisplayHP
	call Draw_Hp_Count
	call DisplayHPBrother
	call Draw_Hp_Count_Enemy


  EndMoveDown:
		ret
endp MoveDown

proc MoveDownEnemy
cmp [startYEnemy], 190
    je EndMoveDownEnemy

    mov [colorEnemy], 0
    call DisplayEnemy
    
    add [startYEnemy], 10
    add [endYEnemy], 10
    
    mov [colorEnemy], 15
    
	mov dx, offset filename
 call Openfile
    call DisplayCuphead
	call DisplayEnemy
	call DisplayHP
	call Draw_Hp_Count
	call DisplayHPBrother
	call Draw_Hp_Count_Enemy


  EndMoveDownEnemy:
		ret
endp MoveDownEnemy


proc MoveRight
	cmp [startX], 300
    je EndMoveRight

    mov [color], 0
    call DisplayCuphead
    
    add [startX], 10
    add [endX], 10
       
    
	mov dx, offset filename
 call Openfile
    call DisplayCuphead
	call DisplayEnemy
	call DisplayHP
	call Draw_Hp_Count
	call DisplayHPBrother
	call Draw_Hp_Count_Enemy
	
  EndMoveRight:
		ret
endp MoveRight

proc MoveRightEnemy
cmp [startXEnemy], 300
    je EndMoveRightEnemy

    mov [colorEnemy], 0
	Call DisplayEnemy
    
    add [startXEnemy], 10
    add [endXEnemy], 10
    
    mov [colorEnemy], 15
    
	mov dx, offset filename
 call Openfile
    call DisplayCuphead
	call DisplayEnemy
	call DisplayHp
	call Draw_Hp_Count
	call DisplayHPBrother
	call Draw_Hp_Count_Enemy
	
	
  EndMoveRightEnemy:
		ret
endp MoveRightEnemy


proc MoveLeft
    cmp [startX], 10
    je EndMoveLeft

    mov [color], 0
    call DisplayCuphead
    
    sub [startX], 10
    sub [endX], 10
    
    mov [color], 2
    
	mov dx, offset filename
 call Openfile
    call DisplayCuphead
	call DisplayEnemy
	call DisplayHP
	call Draw_Hp_Count
	call DisplayHPBrother
	call Draw_Hp_Count_Enemy
	

  EndMoveLeft:
		ret
endp MoveLeft

proc MoveLeftEnemy
cmp [startXEnemy], 10
    je EndMoveLeftEnemy

    mov [colorEnemy], 0
	call DisplayEnemy
    
    sub [startXEnemy], 10
    sub [endXEnemy], 10
    
    mov [colorEnemy], 15
    
	mov dx, offset filename
 call Openfile
    call DisplayCuphead
	call DisplayEnemy
	call DisplayHP
	call Draw_Hp_Count
	call DisplayHPBrother
	call Draw_Hp_Count_Enemy

  EndMoveLeftEnemy:
		ret
endp MoveLeftEnemy

proc MoveTelleport1

    mov [color], 0
    call DisplayCuphead
    
    mov [startX],200
	mov [endX],216
    
    mov [color], 2
    
	mov dx, offset filename
 call Openfile
    call DisplayCuphead
	call DisplayEnemy
	call DisplayHP
	call Draw_Hp_Count
	call DisplayHPBrother
	call Draw_Hp_Count_Enemy

	
	ret
endp MoveTelleport1

proc MoveTelleport2
 mov [color], 0
    call DisplayCuphead
    
    mov [startX],220
	mov [endX],236
    
    mov [color], 2
    
	mov dx, offset filename
 call Openfile
    call DisplayCuphead
	call DisplayEnemy
	call DisplayHP
	call Draw_Hp_Count
	call DisplayHPBrother
	call Draw_Hp_Count_Enemy

	
	ret
endp MoveTelleport2

proc MoveTelleport3
 mov [color], 0
    call DisplayCuphead
    
    mov [startX],240
	mov [endX],256
    
    mov [color], 2
    
	mov dx, offset filename
 call Openfile
    call DisplayCuphead
	call DisplayEnemy
	call DisplayHP
	call Draw_Hp_Count
	call DisplayHPBrother
	call Draw_Hp_Count_Enemy
	
	ret
endp MoveTelleport3

proc MoveTelleport4
 mov [color], 0
    call DisplayCuphead
    
    mov [startX],260
	mov [endX],276
    
    mov [color], 2
    
	mov dx, offset filename
 call Openfile
    call DisplayCuphead
	call DisplayEnemy
	call DisplayHP
	call Draw_Hp_Count
	call DisplayHPBrother
	call Draw_Hp_Count_Enemy
	
	ret
endp MoveTelleport4

proc MoveTelleport5
 mov [color], 0
    call DisplayCuphead
    
    mov [startX],280
	mov [endX],296
    
    mov [color], 2
    
	mov dx, offset filename
 call Openfile
    call DisplayCuphead
	call DisplayEnemy
	call DisplayHP
	call Draw_Hp_Count
	call DisplayHPBrother
	call Draw_Hp_Count_Enemy
	
	ret
endp MoveTelleport5

proc MainGame
   call RestoreHp
    
    mov [startX], 30
    mov [endX], 46
    
    mov [startY], 90
    mov [endY], 100
	
	mov [colorEnemy], 234
    
    mov [startXEnemy], 256
    mov [endXEnemy], 272
    
    mov [startYEnemy], 90
    mov [endYEnemy], 100
    
	mov dx, offset filename
 call Openfile
    call DisplayCuphead
	call DisplayEnemy
	call DisplayHP
	call Draw_Hp_Count
	call DisplayHPBrother
	call Draw_Hp_Count_Enemy
	
	
ReadKeyboardLoop:
    mov ah, 1
    int 16h
    jz ReadKeyboardLoop
    
    mov ah, 0
    int 16h
    
    cmp ah, 1
    je CallEndGame
    
	 cmp ah, 1eh ;a
    je CallMoveLeft
	
	  cmp ah, 20h ;d
    je CallMoveRight
	
	 cmp ah, 11h ;w
    je CallMoveup
	
	cmp ah, 1Fh ;s
    je CallMoveDown
	
    cmp ah, 48h
    je CallMoveupEnemy
	
	cmp ah, 50h
    je CallMoveDownEnemy
    
	cmp ah, 4dh
    je CallMoveRightEnemy
	
	cmp ah, 4bh
    je CallMoveLeftEnemy
	
	cmp ah , 02h
	je CallMoveTelleport1
	
	cmp ah, 03h
	je CallMoveTelleport2
	
	cmp ah, 04h
	je CallMoveTelleport3
	
	cmp ah, 05h
	je CallMoveTelleport4
	
	cmp ah, 06h
	je CallMoveTelleport5
	
	cmp ah,1ch
	je CallShootBrother
	
	cmp ah, 19h
	je CallshootUlt
  	
	cmp ah , 39h
	je CallShoot
	jmp ReadKeyboardLoop
	
	
CallShoot: 
call Shoot
jmp ReadKeyboardLoop

CallShootBrother: 
call ShootBrother
jmp ReadKeyboardLoop

CallMoveUp:
    call MoveUp
    jmp ReadKeyboardLoop
	
CallMoveupEnemy:
    call MoveUpEnemy
	jmp ReadKeyboardLoop
	
CallMoveDown:
    call MoveDown
    jmp ReadKeyboardLoop

CallMoveRightEnemy:
    call MoveRightEnemy
    jmp ReadKeyboardLoop
	
CallMoveLeft:
	call MoveLeft
	jmp ReadKeyboardLoop
	
CallMoveLeftEnemy:
    call MoveLeftEnemy
	jmp ReadKeyboardLoop
	
CallMoveRight:
	call MoveRight
	jmp ReadKeyboardLoop
	
CallMoveDownEnemy:
    call MoveDownEnemy
	jmp ReadKeyboardLoop
	
CallMoveTelleport1:
    call MoveTelleport1
	jmp ReadKeyboardLoop
	
CallMoveTelleport2:
   call MoveTelleport2
   jmp ReadKeyboardLoop
	
CallMoveTelleport3:
    call MoveTelleport3
	jmp ReadKeyboardLoop
	
CallMoveTelleport4:
   call MoveTelleport4
   jmp ReadKeyboardLoop
	
CallMoveTelleport5:
    call MoveTelleport5
	jmp ReadKeyboardLoop
	
CallshootUlt:
   call ShootUlt
   jmp ReadKeyboardLoop
	
CallEndGame:
    call EndGame

    ret
endp MainGame


Start:
    mov ax, @data
    mov ds, ax
  ; Graphic mode
mov ax, 13h
int 10h

mov dx, offset filename1
call Openfile

keypressIntro:
    mov ah, 1
    int 16h
    jz keypressIntro
    
    mov ah, 0 ;waiting for keypress
    int 16h
	
	cmp ah, 1ch ; asking if he pressed enter
    je Callstorytelling
	
	cmp ah,21h ;asking if he pressed the letter f
	je CallExplanationImage
	jmp keypressIntro
	
	CallExplanationImage:
    mov dx, offset filename2
	call Openfile	
    jmp keypressExplanationImage
	
keypressExplanationImage:
 mov ah, 1
    int 16h
    jz keypressExplanationImage
    
    mov ah, 0 ;waiting for keypress
    int 16h
	
	cmp ah, 1ch ; asking if he pressed enter
    je Callultexplanation
	jmp keypressExplanationImage
	
Callultexplanation:
mov dx, offset filename3
call Openfile

UltexplanationKeypress:
mov ah, 1
    int 16h
    jz UltexplanationKeypress
    
    mov ah, 0 ;waiting for keypress
    int 16h
	
	cmp ah, 1ch ; asking if he pressed enter
    je Callstorytelling
	jmp UltexplanationKeypress 


Callstorytelling:
mov dx, offset filename4
call Openfile	

keypressStorytelling:
    mov ah, 1
    int 16h
    jz keypressStorytelling
    
    mov ah, 0 ;waiting for keypress
    int 16h
	
	cmp ah, 1ch ; asking if he pressed enter
    je MainImage

	
	
jmp keypressStorytelling


MainImage:
 mov dx, offset filename
 call Openfile
	


    call MainGame
	
END Start