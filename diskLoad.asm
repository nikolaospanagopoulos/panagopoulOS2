;read DH sectors into ES:BX memory location from drive DL
diskLoad:
   push dx ;store dx on stack so we can check number of sectors read later
