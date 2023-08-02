/**
******************************************************************************
* @file           : main.c
* @brief          : Main program body
******************************************************************************
*/

/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "project_config.h"
#include "project_api.h"

/* Private typedef -----------------------------------------------------------*/

/* Private define ------------------------------------------------------------*/
extern TIM_HandleTypeDef htim2;
extern TIM_HandleTypeDef htim6;

/* Variables -------------------------------------------------------------*/
uint8_t Flag = FALSE;

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{

  HAL_Init();

  /* Configure the system clock */
  SystemClock_Config();

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_USART2_UART_Init();
  MX_TIM2_Init();
  MX_TIM6_Init();
  HAL_TIM_Base_Start_IT(&htim2);
  HAL_TIM_Base_Start_IT(&htim6);

  while (1)
  {
    if(Flag)
    {
      SendUartCommand(0x55,0x00,0x01,0x02);
      Flag=FALSE;
    }
  }
}

/*
 * Callback handler for TIM
 */
void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim)
{
  if(htim == &htim2)
  {
    HAL_GPIO_TogglePin(LD2_GPIO_Port, LD2_Pin);
    
  }
  if(htim == &htim6)
  {
    Flag=TRUE;
  }
}

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  __disable_irq();
  while (1)
  {
  }

}

/************************ END OF FILE ****************************************/
