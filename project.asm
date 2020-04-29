.data
	message: .asciiz ". degeri giriniz.\n"
	birincideger:.float 1.0
	girileceksayi: .float 10.0
	sifir: .float 0.0
	
.text
	main:
		addi $t0,$zero,0
		lwc1 $f1, birincideger #printing 1.0 to f1 coprocessor
		lwc1 $f4,girileceksayi    ## write 10.0 to f4 coprocessor
		
		jal while
		
		while:
			beq $t0,10,exit
			jal degergirme
			
			li $v0,5
			syscall
			move $t1,$v0
			#f2 = 1/n  ------ f1 = 1.0		
			#convert the integer to float
			mtc1 $t1, $f0
			cvt.s.w $f0, $f0
			#convert the integer to float
			
			
			
			########################
			div.s $f2,$f1,$f0 	##	f2=1.0/input
			add.s $f3,$f3,$f2	##     ortalama=ortalama+f2
			########################	
			
			j while
		
		exit:	
			div.s $f5,$f4,$f3    ## harmonikortalama= harmonikortalama / ortalama
			
			li $v0,2             ##printing for float we should use v0
			mov.s $f12,$f5		
			syscall		     ##printting for float we should use v0
			
			
			
			#exit the program
			li $v0,10
			syscall
		
		
	degergirme:
			addi $t0,$t0,1
			li $v0,1
			move $a0,$t0
			syscall
			li $v0,4
			la $a0,message
			syscall
			jr $ra
			
			
			
	####################################		
	##önemli floatý print ettirme ::  ##
	##		li $v0,2	   ##
	##		mov.s $f12,$f0	   ##
	##		syscall		   ##
	##				   ##
	##				   ##
	#################################### 