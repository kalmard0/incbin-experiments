extern char blob_data[];
__asm__(
".globl blob_data\n"
".section .rodata\n"
".type blob_data, @object\n"
"blob_data:\n"
".incbin \"blob.data\"\n"
".size blob_data, .-blob_data\n");

//char get(unsigned long idx) { return blob_data[idx]; }
