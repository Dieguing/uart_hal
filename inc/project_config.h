#ifndef __PROJECT_CONFIG_H
#define __PROJECT_CONFIG_H

/* Defines -----------------------------------*/
#define TRUE  1
#define FALSE 0

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
void MX_GPIO_Init(void);
void MX_USART2_UART_Init(void);
void MX_TIM2_Init(void);
void MX_TIM6_Init(void);

typedef enum 
{
  TX_NO = 0,
  TX_OK
}STATUS;

#endif