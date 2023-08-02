#include "main.h"
#include "project_api.h"
#include "project_config.h"

void SendUartCommand (uint8_t addH, uint8_t addL, uint8_t dataH, uint8_t dataL)
{
  uint8_t tx_temp[4];
  tx_temp[0]=addH;
  tx_temp[1]=addL;
  tx_temp[2]=dataH;
  tx_temp[3]=dataL;

  HAL_UART_Transmit(&huart2, tx_temp, 4, 100);

}