#define CONFIG_IDF_TARGET_ESP32 true
#define TCP_OVERSIZE 536 // FIXME

/* RTOS */
#include "freertos/FreeRTOS.h"
#include "freertos/event_groups.h"
#include "freertos/task.h"
/* RTOS */

/* HAL */
/*
#include "driver/adc.h"
#include "driver/can.h"
#include "driver/dac.h"
#include "driver/gpio.h"
#include "driver/i2c.h"
#include "driver/i2s.h"
#include "driver/ledc.h"
#include "driver/rmt.h"
#include "driver/mcpwm.h"
#include "driver/spi_common.h"
#include "driver/spi_master.h"
#include "driver/spi_slave.h"
#include "driver/timer.h"
#include "driver/uart.h"
*/
/* HAL */

/* ESP */
#include <esp_clk.h>
#include <esp_netif.h>
#include <esp_system.h>
/* ESP */

/* NEWLIB */
#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <string.h>
#include <signal.h>
#include <sys/errno.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/param.h>
#include <sys/un.h>
#include <sys/uio.h>
#include <math.h>
#include <time.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <dirent.h>
#include <pthread.h>
#include <limits.h>
#include <lwip/err.h>
#include <lwip/sockets.h>
#include <lwip/sys.h>
#include <lwip/netdb.h>
#include <lwip/init.h>
