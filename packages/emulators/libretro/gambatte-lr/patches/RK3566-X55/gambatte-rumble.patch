diff -rupN gambatte.orig/libgambatte/libretro/libretro.cpp gambatte/libgambatte/libretro/libretro.cpp
--- gambatte.orig/libgambatte/libretro/libretro.cpp	2023-04-22 02:40:59.910646193 +0900
+++ gambatte/libgambatte/libretro/libretro.cpp	2023-04-22 02:45:29.415891251 +0900
@@ -39,6 +39,9 @@
 #include <cstring>
 #include <algorithm>
 #include <cmath>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
 
 #ifdef _3DS
 extern "C" void* linearMemAlign(size_t size, size_t alignment);
@@ -1119,6 +1122,18 @@ void cartridge_set_rumble(unsigned activ
    else
       rumble_strength_down++;
 
+   // Check write access for duty cycle for rk3566
+   char* filepath = "/sys/class/pwm/pwmchip1/pwm0/duty_cycle";
+   int returnval;
+   returnval = access (filepath, F_OK);
+   if (returnval == 0){
+     returnval = access (filepath, W_OK);
+     if (errno == EACCES){
+       system("sudo chmod 777 /sys/class/pwm/pwmchip1/pwm0/duty_cycle &");
+     }
+   }
+
+
    rumble_active = true;
 }
 
@@ -1140,8 +1155,56 @@ static void apply_rumble(void)
    if (strength == rumble_strength_last)
       return;
 
-   rumble.set_rumble_state(0, RETRO_RUMBLE_WEAK, strength);
-   rumble.set_rumble_state(0, RETRO_RUMBLE_STRONG, strength);
+   //rumble.set_rumble_state(0, RETRO_RUMBLE_WEAK, strength);
+   //rumble.set_rumble_state(0, RETRO_RUMBLE_STRONG, strength);
+
+    uint pwm_duty_cycle = 0;
+    switch(strength) {
+      case 65535:
+        pwm_duty_cycle = 100000;
+        break;
+      case 58982:
+        pwm_duty_cycle = 200000;
+        break;
+      case 52429:
+        pwm_duty_cycle = 300000;
+        break;
+      case 45876:
+        pwm_duty_cycle = 400000;
+        break;
+      case 39323:
+        pwm_duty_cycle = 500000;
+        break;
+      case 32770:
+        pwm_duty_cycle = 600000;
+        break;
+      case 26217:
+        pwm_duty_cycle = 650000;
+        break;
+      case 19664:
+        pwm_duty_cycle = 700000;
+        break;
+      case 13111:
+        pwm_duty_cycle = 750000;
+        break;
+      case 6558:
+        pwm_duty_cycle = 800000;
+        break;
+      default:
+        pwm_duty_cycle = 1000000;
+    }
+
+    FILE *file;
+	if ((file = fopen("/sys/class/pwm/pwmchip0/pwm0/duty_cycle", "r+"))) {
+        fprintf(file, "%u", pwm_duty_cycle);
+	    fclose(file);
+    } else if ((file = fopen("/sys/class/pwm/pwmchip1/pwm0/duty_cycle", "r+"))) {
+        fprintf(file, "%u", pwm_duty_cycle);
+        fclose(file);
+	} else {
+        rumble.set_rumble_state(0, RETRO_RUMBLE_WEAK, strength);
+        rumble.set_rumble_state(0, RETRO_RUMBLE_STRONG, strength);
+    }
 
    rumble_strength_last = strength;
 }
@@ -1156,8 +1219,20 @@ static void deactivate_rumble(void)
        (rumble_strength_last == 0))
       return;
 
-   rumble.set_rumble_state(0, RETRO_RUMBLE_WEAK, 0);
-   rumble.set_rumble_state(0, RETRO_RUMBLE_STRONG, 0);
+   //rumble.set_rumble_state(0, RETRO_RUMBLE_WEAK, 0);
+   //rumble.set_rumble_state(0, RETRO_RUMBLE_STRONG, 0);
+
+    FILE *file;
+    if ((file = fopen("/sys/class/pwm/pwmchip0/pwm0/duty_cycle", "r+"))) {
+        fprintf(file, "%u", 1000000);
+	    fclose(file);
+    } else if ((file = fopen("/sys/class/pwm/pwmchip1/pwm0/duty_cycle", "r+"))) {
+        fprintf(file, "%u", 1000000);
+        fclose(file);
+    } else {
+        rumble.set_rumble_state(0, RETRO_RUMBLE_WEAK, 0);
+        rumble.set_rumble_state(0, RETRO_RUMBLE_STRONG, 0);
+    }
 
    rumble_strength_last = 0;
 }
