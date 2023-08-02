# -
# Copyright (c) 2017, Lukasz Marcin Podkalicki <lpodkalicki@gmail.com>
# -

TARGET=release
DRIVERS=drivers
SOURCES=src
INCLUDES=inc
SYSTEM=system


###################################################

CC=arm-none-eabi-gcc
LD=arm-none-eabi-gcc
AR=arm-none-eabi-ar
AS=arm-none-eabi-as
CP=arm-none-eabi-objcopy
OD=arm-none-eabi-objdump
SE=arm-none-eabi-size
SF=st-flash

###################################################

vpath %.c $(DRIVERS)

INC_DIRS = $(SOURCES)
INC_DIRS += $(INCLUDES)
INC_DIRS += $(SYSTEM)
INC_DIRS += $(DRIVERS)/CMSIS/Device/ST/STM32L0xx/Include
INC_DIRS += $(DRIVERS)/CMSIS/Device/ST/STM32L0xx/Source
INC_DIRS += $(DRIVERS)/CMSIS/Include
INC_DIRS += $(DRIVERS)/STM32L0xx_HAL_Driver/Inc
INC_DIRS += $(DRIVERS)/STM32L0xx_HAL_Driver/Inc/Legacy
INC_DIRS += $(DRIVERS)/STM32L0xx_HAL_Driver/Src
INC_DIRS += .

INC = $(addprefix -I,$(INC_DIRS))

###################################################

CFLAGS  = -std=gnu99 -g -Wall -TSTM32L053R8TX_FLASH.ld
CFLAGS += -mcpu=cortex-m0plus -static --specs=nano.specs -mfloat-abi=soft -mthumb -Wl,--start-group -lc -lm -Wl,--end-group
CFLAGS += --specs=nosys.specs -Wl,-Map="project.map" -Wl,--gc-sections

###################################################

SRCS =  ./src/main.c \
./startup_stm32l053r8tx.s \
./src/project_config.c \
./src/project_api.c \
./drivers/CMSIS/Device/ST/STM32L0xx/Source/system_stm32l0xx.c \
./drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal.c \
./drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_tim.c \
./drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_tim_ex.c \
./drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_cortex.c \
./drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_rcc.c \
./drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_rcc_ex.c \
./drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_dma.c \
./drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_uart.c \
./drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_uart_ex.c \
./drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_gpio.c \
./src/stm32l0xx_it.c \
./src/stm32l0xx_hal_msp.c 

###################################################

.PHONY: $(TARGET)

$(TARGET): $(TARGET).elf

$(TARGET).elf: $(SRCS)
	$(CC) -O0 $(CFLAGS) $(INC) $^ -o $@ 
	$(CP) -O ihex $(TARGET).elf $(TARGET).hex

clean:
	rm -f *.o $(TARGET).elf $(TARGET).hex $(TARGET).bin

flash: 
	$(SF) --reset --freq=4000k --format ihex write $(TARGET).hex
	