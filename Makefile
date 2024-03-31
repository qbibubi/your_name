# Directories
SRC_DIR := src
OBJ_DIR := obj
BIN_DIR := bin

# Compiler and flags
CC := gcc
AS := nasm
CFLAGS := -Wall -Wextra -I$(SRC_DIR)/include
LDFLAGS := -melf_x86_64
ASFLAGS := -felf64

# Source files
C_FILES := $(wildcard $(SRC_DIR)/*.c)
ASM_FILES := $(wildcard $(SRC_DIR)/*.asm)

# Object files
OBJ_C := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(C_FILES))
OBJ_ASM := $(patsubst $(SRC_DIR)/%.asm,$(OBJ_DIR)/%.o,$(ASM_FILES))

# Binary
TARGET := $(BIN_DIR)/output

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJ_C) $(OBJ_ASM)
	@mkdir -p $(@D)
	$(LD) $(LDFLAGS) -o $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c -o $@ $<

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm
	@mkdir -p $(@D)
	$(AS) $(ASFLAGS) -o $@ $<

clean:
	@$(RM) -r $(OBJ_DIR) $(BIN_DIR)
