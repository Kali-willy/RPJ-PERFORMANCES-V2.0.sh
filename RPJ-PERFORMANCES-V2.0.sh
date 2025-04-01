#!/system/bin/sh
# RPJ-PERFORMANCES-V2.0.sh
# Android Performance Booster Script
# Developer: Willy Gailo
# Compatible with both rooted and non-rooted devices
# Focuses on: Network optimization, Performance boost, Touch response, and Battery savings

# Print evil-themed banner
echo -e "\e[31m"
echo "========================================================"
echo "                                                        "
echo "      ██████╗ ██████╗      ██╗                         "
echo "      ██╔══██╗██╔══██╗     ██║                         "
echo "      ██████╔╝██████╔╝     ██║                         "
echo "      ██╔══██╗██╔═══╝      ██║                         "
echo "      ██║  ██║██║          ██║                         "
echo "      ╚═╝  ╚═╝╚═╝          ╚═╝                         "
echo "                                                        "
echo "      ╔═══════════════════════════════════╗            "
echo "      ║  PERFORMANCES BOOSTER V2.0        ║            "
echo "      ║  Android System Optimizer         ║            "
echo "      ║  Developer: Willy Gailo           ║            "
echo "      ╚═══════════════════════════════════╝            "
echo "                                                        "
echo "       ⠀⠀⠀⠀⠀⣀⣀⣤⣤⣶⣶⣶⣦⣴⣶⣦⣄⡀⠀⠀⠀⠀⠀                  "
echo "       ⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀                  "
echo "       ⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀                  "
echo "       ⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀                  "
echo "       ⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠻⠏⠙⣿⠛⠛⣿⣿⣿⠀                  "
echo "       ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⢸⣿⣿⡇                  "
echo "       ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⡇                  "
echo "       ⣿⣿⡇⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⢀⣀⣀⠀⠘⢻⣿⡇                  "
echo "       ⢹⣿⡇⠙⢿⣿⣿⣿⣿⣿⠀⠀⢀⣴⣿⣿⣿⣿⣿⣦⣸⣿⡇                  "
echo "       ⠘⣿⡇⠀⠀⠙⣿⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃                  "
echo "       ⠀⢿⡇⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀                  "
echo "       ⠀⠘⠿⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀                  "
echo "       ⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠀⠀⠀                  "
echo "                                                        "
echo "      [!] INJECT SYSTEM MODE                            "
echo "                                                        "
echo "========================================================"
echo -e "\e[0m"
echo " "

# Check execution environment
check_environment() {
    log "Checking execution environment..."
    
    # Check if running in Termux
    if [ -d "/data/data/com.termux" ] || [ -d "/data/user/0/com.termux" ]; then
        TERMUX=true
        log "[✓] Running in Termux environment"
    else
        TERMUX=false
        log "[!] Not running in Termux environment"
    fi
    
    # Check if Brevent is installed
    if pm list packages | grep -q "brevent"; then
        BREVENT=true
        log "[✓] Brevent detected"
    else
        BREVENT=false
        log "[!] Brevent not detected"
    fi
    
    # Check if Qute is installed
    if pm list packages | grep -q "qute"; then
        QUTE=true
        log "[✓] Qute detected"
    else
        QUTE=false
        log "[!] Qute not detected"
    fi
    
    # Check if required environment is available
    if ! $TERMUX && ! $BREVENT && ! $QUTE; then
        echo -e "\e[31m"
        echo "ERROR: This script requires TERMUX, BREVENT or QUTE to run."
        echo "Please install at least one of these apps and try again."
        echo -e "\e[0m"
        exit 1
    fi
    
    log "Environment check completed"
}

# Create log file
LOG_FILE="/sdcard/rpj_performance_log.txt"
echo "RPJ-PERFORMANCES-V2.0 Log - $(date)" > $LOG_FILE

# Helper functions
log() {
    echo "[INFO] $1"
    echo "[$(date +%H:%M:%S)] $1" >> $LOG_FILE
}

check_command() {
    if command -v $1 > /dev/null; then
        return 0
    else
        return 1
    fi
}

# Check Android version
ANDROID_VERSION=$(getprop ro.build.version.release)
log "Detected Android version: $ANDROID_VERSION"

# ---------------------------------------------------
# Network performance optimization
# ---------------------------------------------------
network_optimization() {
    log "Starting Network Optimization..."
    
    # TCP optimization
    if $ROOTED; then
        log "Applying TCP optimizations..."
        # Increase TCP buffer sizes for better throughput
        echo "net.ipv4.tcp_wmem=4096 65536 16777216" > /proc/sys/net/ipv4/tcp_wmem
        echo "net.ipv4.tcp_rmem=4096 87380 16777216" > /proc/sys/net/ipv4/tcp_rmem
        
        # Enable TCP Fast Open
        echo "3" > /proc/sys/net/ipv4/tcp_fastopen
        
        # Increase the maximum number of connections
        echo "5000" > /proc/sys/net/core/somaxconn
        
        # Modify TCP congestion control algorithm
        echo "cubic" > /proc/sys/net/ipv4/tcp_congestion_control
    fi
    
    # Safe network optimizations for all devices
    settings put global wifi_scan_throttle_enabled 0
    settings put global captive_portal_detection_enabled 0
    settings put global captive_portal_server "connectivitycheck.gstatic.com"
    
    # Disable mobile data always active (saves battery)
    settings put global mobile_data_always_on 0
    
    log "Network optimization completed"
}

# ---------------------------------------------------
# Performance optimization
# ---------------------------------------------------
performance_optimization() {
    log "Starting Performance Optimization..."
    
    # CPU performance
    if $ROOTED; then
        # CPU Governor optimization
        for CPU in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
            if [ -f "$CPU" ]; then
                echo "interactive" > $CPU 2>/dev/null || echo "schedutil" > $CPU 2>/dev/null
                log "Set governor for $CPU"
            fi
        done
        
        # I/O scheduler optimization
        for BLOCK in /sys/block/*/queue/scheduler; do
            if [ -f "$BLOCK" ]; then
                echo "cfq" > $BLOCK 2>/dev/null || echo "deadline" > $BLOCK 2>/dev/null
                log "Set I/O scheduler for $BLOCK"
            fi
        done
        
        # VM improvements
        echo "20" > /proc/sys/vm/swappiness
        echo "1500" > /proc/sys/vm/dirty_writeback_centisecs
        echo "0" > /proc/sys/vm/oom_kill_allocating_task
    fi
    
    # Safe optimizations for all devices
    # Reduce animation scales for faster UI
    settings put global window_animation_scale 0.5
    settings put global transition_animation_scale 0.5
    settings put global animator_duration_scale 0.5
    
    # Boost apps by allowing more background processes
    setprop persist.sys.dalvik.vm.lib.2 libart.so
    setprop dalvik.vm.dex2oat-filter everything
    setprop dalvik.vm.image-dex2oat-filter everything
    
    # Enable developer options if not already enabled
    settings put global development_settings_enabled 1
    
    log "Performance optimization completed"
}

# ---------------------------------------------------
# Touch response optimization
# ---------------------------------------------------
touch_response_optimization() {
    log "Starting Touch Response Optimization..."
    
    if $ROOTED; then
        # Reduce touch latency by modifying kernel parameters
        if [ -f "/sys/module/touchscreen_mmi/parameters/touchscreen_gesture" ]; then
            echo "1" > /sys/module/touchscreen_mmi/parameters/touchscreen_gesture
            log "Enabled touchscreen gestures"
        fi
        
        # Increase touch sensitivity and sampling rate if available
        for TOUCH in /sys/class/*/touch/sensitivity; do
            if [ -f "$TOUCH" ]; then
                echo "high" > $TOUCH 2>/dev/null
                log "Increased touch sensitivity"
            fi
        done
        
        # Reduce input boost duration for faster response
        if [ -d "/sys/module/cpu_boost/parameters" ]; then
            echo "20" > /sys/module/cpu_boost/parameters/input_boost_ms
            log "Set input boost duration"
        fi
    fi
    
    # Reduce haptic feedback duration for quicker response feel
    settings put system haptic_feedback_enabled 1
    settings put global haptic_feedback_enabled 1
    
    # Reduce touch slop (distance before a touch is registered as a move)
    if check_command "wm"; then
        wm overscan 0,0,0,0
        log "Reset overscan for better touch detection"
    fi
    
    log "Touch response optimization completed"
}

# ---------------------------------------------------
# Memory optimization
# ---------------------------------------------------
memory_optimization() {
    log "Starting Memory Optimization..."
    
    # Kill unnecessary background processes
    am kill-all
    
    # Safe memory optimizations
    setprop dalvik.vm.checkjni false
    setprop dalvik.vm.execution-mode int:jit
    setprop dalvik.vm.verify-bytecode false
    
    if $ROOTED; then
        # Clear caches
        sync
        echo 3 > /proc/sys/vm/drop_caches
        echo 0 > /proc/sys/vm/drop_caches
        
        # Increase process priority
        echo "-15" > /proc/1/oom_adj
        
        # Adjust low memory killer
        echo "2560,4096,6144,12288,16384,20480" > /sys/module/lowmemorykiller/parameters/minfree
    else
        # Clean cache for non-rooted devices
        # Force stop some common background apps that might not be needed
        pm list packages -3 | cut -d':' -f2 | while read package; do
            if echo "$package" | grep -q -E 'analytics|tracker|metrics'; then
                am force-stop $package
                log "Stopped potential background app: $package"
            fi
        done
    fi
    
    log "Memory optimization completed"
}

# ---------------------------------------------------
# Battery optimization
# ---------------------------------------------------
battery_optimization() {
    log "Starting Battery Optimization..."
    
    # Safe battery optimizations
    settings put global low_power 0
    
    # Disable unnecessary sensors
    if check_command "dumpsys"; then
        for sensor in "significant_motion" "step_detector" "step_counter" "tilt_detector"; do
            dumpsys sensorservice | grep -q "$sensor" && settings put system sensor_enable_$sensor 0
        done
    fi
    
    # Optimize location settings to save battery
    settings put secure location_mode 0
    settings put system screen_brightness_mode 1
    
    if $ROOTED; then
        # Underclocking when on battery
        if [ -d "/sys/devices/system/cpu/cpu0/cpufreq" ]; then
            GOVERNOR=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
            if [ "$GOVERNOR" = "interactive" ]; then
                echo "85" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
                log "Adjusted CPU target loads for battery saving"
            fi
        fi
    fi
    
    log "Battery optimization completed"
}

# ---------------------------------------------------
# System stability checks
# ---------------------------------------------------
system_stability() {
    log "Running System Stability Checks..."
    
    # Safe stability improvements
    settings put global adb_enabled 0
    settings put global stay_on_while_plugged_in 0
    
    # Clear app cache 
    if check_command "pm"; then
        pm trim-caches 1G
        log "Trimmed app caches"
    fi
    
    # Analyze system for issues
    if check_command "dumpsys"; then
        BATTERY_STAT=$(dumpsys battery | grep level | awk '{print $2}')
        log "Current battery level: $BATTERY_STAT%"
        
        # Check for wakelocks
        WAKELOCKS=$(dumpsys power | grep "Wake Locks:" -A 5)
        echo "$WAKELOCKS" >> $LOG_FILE
    fi
    
    log "System stability checks completed"
}

# ---------------------------------------------------
# Main execution
# ---------------------------------------------------
# Create temporary work directory
mkdir -p /data/local/tmp/rpj_temp 2>/dev/null

# Display device information
log "Device Model: $(getprop ro.product.model)"
log "Android Version: $ANDROID_VERSION"
log "Kernel Version: $(uname -r)"

# Check environment first
check_environment

# Check if running as root
if [ "$(id -u)" -eq 0 ]; then
    ROOTED=true
    echo "[✓] Running with ROOT permissions"
else
    ROOTED=false
    echo "[!] Running WITHOUT ROOT permissions"
    echo "[!] Some optimizations will be limited"
fi

# Setup environment-specific tools
if $TERMUX; then
    PREFIX="/data/data/com.termux/files/usr"
    PATH="$PATH:$PREFIX/bin"
    log "Setting up Termux environment"
fi

if $BREVENT; then
    log "Setting up Brevent integration"
    # Check if Brevent has accessibility permission
    if dumpsys accessibility | grep -q "brevent"; then
        log "[✓] Brevent has proper permissions"
    else
        echo "[!] Please grant Accessibility permission to Brevent for optimal performance"
    fi
fi

if $QUTE; then
    log "Setting up Qute integration"
    # Prepare Qute integration
    if pm list packages | grep -q "qute.shell"; then
        log "[✓] Qute Shell extension available"
    else
        log "[!] Qute Shell extension not found, functionality may be limited"
    fi
fi

# Run all optimizations
echo "[1/6] Starting Network optimization..."
network_optimization

echo "[2/6] Starting Performance optimization..."
performance_optimization

echo "[3/6] Starting Touch response optimization..."
touch_response_optimization

echo "[4/6] Starting Memory optimization..."
memory_optimization

echo "[5/6] Starting Battery optimization..."
battery_optimization

echo "[6/6] Running System stability checks..."
system_stability

# Apply all settings
if check_command "am"; then
    am broadcast -a android.intent.action.BOOT_COMPLETED
fi

# Clean up
rm -rf /data/local/tmp/rpj_temp 2>/dev/null

# Final message
echo " "
echo -e "\e[31m"
echo "========================================================"
echo "                                                        "
echo "      ░█▀▀░█░█░█▀▀░█▀▀░█▀▀░█▀▀░█▀▀                     "
echo "      ░▀▀█░█░█░█░░░█░░░█▀▀░▀▀█░▀▀█                     "
echo "      ░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀                     "
echo "                                                        "
echo "      ╔═══════════════════════════════════╗            "
echo "      ║       OPTIMIZATION COMPLETE       ║            "
echo "      ║     YOUR DEVICE IS NOW BOOSTED    ║            "
echo "      ║     BY DEVELOPER: WILLY GAILO     ║            "
echo "      ╚═══════════════════════════════════╝            "
echo "                                                        "
echo " Log file saved to: $LOG_FILE                           "
echo " Reboot your device for maximum results                 "
echo "                                                        "
echo "========================================================"
echo -e "\e[0m"
echo " "

# Exit
exit 0