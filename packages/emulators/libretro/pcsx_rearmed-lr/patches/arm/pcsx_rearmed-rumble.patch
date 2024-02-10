diff -rupN pcsx_rearmed.orig/frontend/libretro.c pcsx_rearmed/frontend/libretro.c
--- pcsx_rearmed.orig/frontend/libretro.c	2023-04-21 22:53:59.598872468 +0900
+++ pcsx_rearmed/frontend/libretro.c	2023-04-21 22:46:50.415698804 +0900
@@ -40,6 +40,9 @@
 
 #include <libretro.h>
 #include "libretro_core_options.h"
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
 
 #ifdef USE_LIBRETRO_VFS
 #include <streams/file_stream_transforms.h>
@@ -516,7 +519,35 @@ void plat_trigger_vibrate(int pad, int l
 
    if (in_enable_vibration)
    {
-      rumble_cb(pad, RETRO_RUMBLE_STRONG, high << 8);
+    FILE *file;
+
+    if (high > 0){
+       if ((file = fopen("/sys/class/pwm/pwmchip0/pwm0/duty_cycle", "r+"))) {
+          fputs("10", file);
+          fclose(file);
+       } else if ((file = fopen("/sys/class/pwm/pwmchip1/pwm0/duty_cycle", "r+"))) {
+          fputs("10", file);
+          fclose(file);
+       }
+    } else if (low > 0){
+       if ((file = fopen("/sys/class/pwm/pwmchip0/pwm0/duty_cycle", "r+"))) {
+          fputs("500000", file);
+          fclose(file);
+       } else if ((file = fopen("/sys/class/pwm/pwmchip1/pwm0/duty_cycle", "r+"))) {
+          fputs("500000", file);
+          fclose(file);
+       }
+    } else {
+       if ((file = fopen("/sys/class/pwm/pwmchip0/pwm0/duty_cycle", "r+"))) {
+          fputs("1000000", file);
+          fclose(file);
+       } else if ((file = fopen("/sys/class/pwm/pwmchip1/pwm0/duty_cycle", "r+"))) {
+          fputs("1000000", file);
+          fclose(file);
+       }
+    }
+	  
+	  rumble_cb(pad, RETRO_RUMBLE_STRONG, high << 8);
       rumble_cb(pad, RETRO_RUMBLE_WEAK, low ? 0xffff : 0x0);
    }
 }
@@ -1850,8 +1881,18 @@ static void update_variables(bool in_fli
    {
       if (strcmp(var.value, "disabled") == 0)
          in_enable_vibration = 0;
-      else if (strcmp(var.value, "enabled") == 0)
+      else if (strcmp(var.value, "enabled") == 0) {
          in_enable_vibration = 1;
+         // Check write access for duty cycle for rk3566
+         char* filepath = "/sys/class/pwm/pwmchip1/pwm0/duty_cycle";
+         int returnval;
+         returnval = access (filepath, F_OK);
+         if (returnval == 0){
+           returnval = access (filepath, W_OK);
+           if (errno == EACCES)
+             system("sudo chmod 777 /sys/class/pwm/pwmchip1/pwm0/duty_cycle &");
+         }
+      }
    }
 
    var.value = NULL;
