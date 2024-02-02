./bin/os: ./bin/boot.bin ./bin/kernel.bin ./bin/fileTable.bin
	cat ./bin/boot.bin ./bin/fileTable.bin ./bin/kernel.bin > ./bin/os.bin
./bin/boot.bin:
	fasm ./boot.asm  ./bin/boot.bin
./bin/kernel.bin:
	fasm ./kernel.asm ./bin/kernel.bin
./bin/fileTable.bin:
	fasm ./fileTable.asm ./bin/fileTable.bin
clean:
	rm ./bin/*.bin
