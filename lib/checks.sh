# shellcheck shell=bash

check_cpu() {
    local cpu_usage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'.' -f1)
    print_status "CPU usage: ${cpu_usage}%"
    if [ "${cpu_usage}" -gt "${THRESHOLD}" ]; then
        print_warning "CPU usage is high: ${cpu_usage}%"
    fi
}

check_ram() {
    local ram_usage
    ram_usage=$(free | awk '/^Mem:/{printf "%.0f", $3/$2*100}')
    print_status "RAM usage: ${ram_usage}%"
    if [ "${ram_usage}" -gt "${THRESHOLD}" ]; then
        print_warning "RAM usage is high: ${ram_usage}"
    fi
}

check_disk() {
  local disk_usage
  disk_usage=$(df / | awk 'NR==2{print $5}' | tr -d '%')
  print_status "Disk usage: ${disk_usage}%"
  if [ "${disk_usage}" -gt "${THRESHOLD}" ]; then
    print_warning "Disk usage is high: ${disk_usage}%"
  fi
}

check_network() {
  local interface
  interface=$(ip route | awk '/default/{print $5}' | head -1)
  local rx_before tx_before rx_after tx_after
  rx_before=$(cat /sys/class/net/"${interface}"/statistics/rx_bytes)
  tx_before=$(cat /sys/class/net/"${interface}"/statistics/tx_bytes)
  sleep 1
  rx_after=$(cat /sys/class/net/"${interface}"/statistics/rx_bytes)
  tx_after=$(cat /sys/class/net/"${interface}"/statistics/tx_bytes)
  local rx_speed tx_speed
  rx_speed=$(( (rx_after - rx_before) / 1024 ))
  tx_speed=$(( (tx_after - tx_before) / 1024 ))
  print_status "Network (${interface}) — DOWN: ${rx_speed} KB/s UP: ${tx_speed} KB/s"
}

check_processes() {
  local total hungry
  total=$(ps aux | wc -l)
  hungry=$(ps aux --sort=-%cpu | awk 'NR>1 && $3>50{print $11, $3"%"}' | head -5)
  print_status "Total processes: ${total}"
  if [ -n "${hungry}" ]; then
    print_warning "High CPU processes:"
    echo "${hungry}"
  fi
}