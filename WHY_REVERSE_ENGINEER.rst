WHY Reverse Engineer?
==============================

- To achieve Interoperability
  Make some system work with software or hardware you already have

- To figure out how it works

- Keygen/Cracks

- Exploit Development

- Proprietary File Formats

Assumptions
------------------------------------------
Knowledge of the following concepts:

Endianness

Data structures

Hexadecimal notation

Intel Architecture

The Stack
------------------------------------------

- *LIFO* data structure

.. code:: assembly

   push ebp
   mov esp,ebp
   sub esp,0x08
   mov eax,45
   mov ebx,43
   add eax,ebx
   call sym_add
   ret

The Heap
---------------
Responsible for Dynamic memory allocation

The BSS
---------
Contains Uninitialized variables

The Text
-----------
Contains The assembly instructions

The Registers
------------------------------

General Purpose
''''''''''''''''''''

1. **EAX**

   return values

2. **EBX**

   Base register for memory access

3. **ECX**

   Loop Counter

4. **EDX**

   Data Register for I/O


Segment Registers
''''''''''''''''''''

Two letter abbrevs

1. **CS**

   Stores code segment

2. **DS**

   Stores Data segment

3. **ES**, **FS**, **GS**

   Far addressing (video mem etc)

4. **SS**

   Stack segment usually same as **EDX**


Indexes and Pointers
''''''''''''''''''''''

1. **EDI**

   Destination index register for array ops

2. **ESI**

   Source index register array ops

3. **EBP**

   Base Pointer  bottom of stack frame

4. **ESP**

   Stack Pointer top of stack frame

5. **EIP**

   Instruction Pointer to next instruction to be executed

The E prefix is for 32-bit, 16-bit and 8-bit are without the E prefix and finally for
64-bit the prefix is R instead of E and forward compatibility is maintained

Flags Register
''''''''''''''''''''''
Holds 32 registers in total
One bit values

1. **ZF**

   Zero Flag
   Set to 1 if result of previous op is 0

2. **SF**

   Sign Flag
   Set to 1 if result of previous op is negative -

Calling Conventions
----------------------
CDECL
''''''''''
Arguments are passed on the stack in Right-to-Left order

Return Values are passed to **EAX**

The Calling Function cleans the stack

Allowing for Variadic functions as caller knows no of args

STDCALL (AKA WINAPI)
''''''''''''''''''''
Arguments are passed on the stack in Right-to-Left order

Return Values are passed to **EAX**

The Called Function cleans the stack

FASTCALL
''''''''''''''''''''
The first 2 or 3 (32-bit or smaller ) arguments are passed directly in registers with the
most commonly used registers being **EDX**, **EAX**, and **ECX** .

The Calling Function (usually) cleans the stack


THISCALL (C++)
''''''''''''''''''''
Only Non-Static Member Functions. Also Non-Variadic

The Pointer to the class object is passed in **ECX**, and return value is passed to **EAX**.

The Called Function cleans the Stack


OPERAND TYPES
-------------

- Immediates :03xf

- Registers :

  **EAX**, .... **ECX** the values themselves

- Memory adrresses

  [0x80542a], [eax]

- Offset Types by bytes

  [eax + 0x4]

- Sibs which are offsets by multiplication and addition

  [ eax * 4 + ecx ] , [eax * 2 + ecx]


OPERATIONS
------------------------

- *mov*

  Move destination, source
  reg,mem,immediate any combination

- *add,sub*

  addition and subtraction

- *cmp*

  compare  subtract source from destination and assign a flag
  if **ZF** is 1 the destination and source are equivalent

- *test*

  test does bitwise and of source and destination and assigns a flag
  to **ZF** or **SF** depending on the result

- *jcc/jmp*

  conditional and regular jumps

  jz/jnz if **ZF** is zero or not jump

  ja/jae jump above and jump above equal

  jb/jbe/bjnb jump below and jump below equal


- push/pop

  one operand and operate on stack

- bitwise ops

   and, or , xor, not



Recognizing Programming Constructs
==================================
Function Prologue and Epilogue

.. code:: assembly

   push ebp
   mov ebp, esp
   sub esp, N

   ...
   mov esp,ebp
   pop ebp
   ret

About CALL and RET
------------------
Have an Implicit Operation
Call will push **EIP** onto the Stack
Return will pop the **EIP**

LOOPS
------
**ECX** is usually loop counter
conditional jumps based on loop counter
easier to spot in call graphs

SWITCH STATEMENTS
-------------------
jmp dwords
endian formatted mem addressess
with controlled offsets

