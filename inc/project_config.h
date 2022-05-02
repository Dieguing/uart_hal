#ifndef __CONFIG_H
#define __CONFIG_H

/* Defines -----------------------------------*/
#define TRUE  1
#define FALSE 0

/* Private variables ---------------------------------------------------------*/
TIM_HandleTypeDef htim2;
TIM_HandleTypeDef htim6;
UART_HandleTypeDef huart2;

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