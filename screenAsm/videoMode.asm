
setVideoMode:
   mov ah, 0x00
   mov al, 0x03   ;80x25 16 color text (CGA,EGA,MCGA,VGA)
   int 0x10
   ret

changeColorPallete:
   mov ah, 0x0B
   mov bh, 0x00 ;1 pallete, 0 background
   mov bl, 0x01 ;color value
   int 0x10
   ret




;	AH = 0B
;	BH = palette color ID
;	   = 0	to set background and border color
;	   = 1	to select 4 color palette
;	BL = color value (when BH = 0)
;	   = palette value (when BH = 1)


;	Palette    Pixel	  Color
;	   0	     0	    current background color
;		     1	    green (2)
;		     2	    red (4)
;		     3	    brown (6)
;	   1	     0	    current background color
;		     1	    cyan (3)
;		     2	    magenta (5)
;		     3	    white (7)
;
;	- does not work for all EGA and VGA video modes
;	- sets border color in text mode (BH = 0)
