diff -rupN pokemini.orig/libretro/libretro.c pokemini/libretro/libretro.c
--- pokemini.orig/libretro/libretro.c	2023-04-22 01:45:35.820500323 +0900
+++ pokemini/libretro/libretro.c	2023-04-22 02:04:01.948180006 +0900
@@ -16,6 +16,7 @@
 #include <libretro_core_options.h>
 #include <retro_miscellaneous.h>
 #include <streams/file_stream.h>
+#include <errno.h>
 
 // PokeMini headers
 #include "MinxIO.h"
@@ -156,6 +157,16 @@ static void InitialiseRumbleInterface(vo
 {
 	if (environ_cb(RETRO_ENVIRONMENT_GET_RUMBLE_INTERFACE, &rumble))
 	{
+        // Check write access for duty cycle for rk3566
+        char* filepath = "/sys/class/pwm/pwmchip1/pwm0/duty_cycle";
+        int returnval;
+        returnval = access (filepath, F_OK);
+        if (returnval == 0){
+          returnval = access (filepath, W_OK);
+          if (errno == EACCES){
+            system("sudo chmod 777 /sys/class/pwm/pwmchip1/pwm0/duty_cycle &");
+          }
+        }
 		if (log_cb)
 			log_cb(RETRO_LOG_INFO, "Rumble environment supported\n");
 	}
@@ -167,26 +178,88 @@ static void InitialiseRumbleInterface(vo
 
 static void ActivateControllerRumble(void)
 {
-	if (!rumble.set_rumble_state ||
+	/*if (!rumble.set_rumble_state ||
 		 (rumble_strength_prev == rumble_strength))
 		return;
 
 	rumble.set_rumble_state(0, RETRO_RUMBLE_WEAK,   rumble_strength);
 	rumble.set_rumble_state(0, RETRO_RUMBLE_STRONG, rumble_strength);
-	rumble_strength_prev = rumble_strength;
+	rumble_strength_prev = rumble_strength;*/
+
+    uint pwm_duty_cycle = 0;
+    switch(rumble_strength) {
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
+	    rumble.set_rumble_state(0, RETRO_RUMBLE_WEAK,   rumble_strength);
+	    rumble.set_rumble_state(0, RETRO_RUMBLE_STRONG, rumble_strength);
+	    rumble_strength_prev = rumble_strength;
+	}
 }
 
 ///////////////////////////////////////////////////////////
 
 static void DeactivateControllerRumble(void)
 {
-	if (!rumble.set_rumble_state ||
+	/*if (!rumble.set_rumble_state ||
 		 (rumble_strength_prev == 0))
 		return;
 
 	rumble.set_rumble_state(0, RETRO_RUMBLE_WEAK,   0);
 	rumble.set_rumble_state(0, RETRO_RUMBLE_STRONG, 0);
-	rumble_strength_prev = 0;
+	rumble_strength_prev = 0;*/
+
+    FILE *file;
+    if ((file = fopen("/sys/class/pwm/pwmchip0/pwm0/duty_cycle", "r+"))) {
+        fprintf(file, "%u", 1000000);
+	    fclose(file);
+    } else if ((file = fopen("/sys/class/pwm/pwmchip1/pwm0/duty_cycle", "r+"))) {
+        fprintf(file, "%u", 1000000);
+        fclose(file);
+    } else {
+	    rumble.set_rumble_state(0, RETRO_RUMBLE_WEAK,   0);
+	    rumble.set_rumble_state(0, RETRO_RUMBLE_STRONG, 0);
+	    rumble_strength_prev = 0;
+	}
 }
 
 ///////////////////////////////////////////////////////////
