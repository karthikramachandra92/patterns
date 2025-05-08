#!/bin/bash

# Define the base pattern names and their file skeletons
declare -A patterns
patterns=(
  ["interrupt_state_machine"]="uart_fsm.c uart_fsm.h uart_ring_buffer.c uart_defs.h test_uart_fsm.c"
  ["event_dispatcher"]="dispatcher.c dispatcher.h event_queue.c events.h test_dispatcher.c"
  ["dma_circular_buffer"]="dma_logger.c dma_logger.h buffer.c buffer_defs.h test_dma_logger.c"
  ["memory_pool_allocator"]="mempool.c mempool.h mempool_config.h test_mempool.c"
  ["software_timer_framework"]="timer.c timer.h timer_defs.h test_timer.c"
  ["cooperative_scheduler"]="scheduler.c scheduler.h task.h test_scheduler.c"
  ["watchdog_system"]="watchdog.c watchdog.h system_state.c watchdog_defs.h test_watchdog.c"
  ["critical_section_abstraction"]="critical.c critical.h arch_defs.h test_critical.c"
  ["mockable_hal"]="hal_gpio.c hal_i2c.c hal_mock.c hal.h test_hal.c"
  ["safe_bootloader"]="bootloader.c flash_layout.c image_validator.c bootloader_defs.h test_bootloader.c"
  ["state_machine_framework"]="state_machine.c state_machine.h event_queue.c state_table.c state_defs.h test_state_machine.c state_diagram.dot"
)

# Loop through and create folders + files
for pattern in "${!patterns[@]}"; do
  echo "Creating: $pattern"

  mkdir -p "$pattern"/{src,include,tests,docs}

  for file in ${patterns[$pattern]}; do
    case $file in
      *.c|*.h)
        if [[ "$file" == *test* ]]; then
          touch "$pattern/tests/$file"
        elif [[ "$file" == *_defs.h || "$file" == *_config.h || "$file" == task.h || "$file" == arch_defs.h ]]; then
          touch "$pattern/include/$file"
        else
          touch "$pattern/src/$file"
        fi
        ;;
      *.dot)
        touch "$pattern/docs/$file"
        ;;
    esac
  done

  touch "$pattern/README.md"
  echo "✅ Done: $pattern"
done

