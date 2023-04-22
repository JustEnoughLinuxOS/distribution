diff -rupN mgba.orig/src/platform/libretro/libretro.c mgba/src/platform/libretro/libretro.c
--- mgba.orig/src/platform/libretro/libretro.c	2023-04-22 02:27:49.936093350 +0900
+++ mgba/src/platform/libretro/libretro.c	2023-04-22 02:54:23.978187106 +0900
@@ -1728,12 +1728,33 @@ void retro_run(void) {
 #endif
 
 	if (rumbleCallback) {
+        FILE *file;
 		if (rumbleUp) {
-			rumbleCallback(0, RETRO_RUMBLE_STRONG, rumbleUp * 0xFFFF / (rumbleUp + rumbleDown));
-			rumbleCallback(0, RETRO_RUMBLE_WEAK, rumbleUp * 0xFFFF / (rumbleUp + rumbleDown));
+			//rumbleCallback(0, RETRO_RUMBLE_STRONG, rumbleUp * 0xFFFF / (rumbleUp + rumbleDown));
+			//rumbleCallback(0, RETRO_RUMBLE_WEAK, rumbleUp * 0xFFFF / (rumbleUp + rumbleDown));
+            if ((file = fopen("/sys/class/pwm/pwmchip0/pwm0/duty_cycle", "r+"))) {
+               fputs("10", file);
+               fclose(file);
+            } else if ((file = fopen("/sys/class/pwm/pwmchip1/pwm0/enable", "r+"))) {
+               fputs("0", file);
+               fclose(file);
+            } else {
+			   rumbleCallback(0, RETRO_RUMBLE_STRONG, rumbleUp * 0xFFFF / (rumbleUp + rumbleDown));
+			   rumbleCallback(0, RETRO_RUMBLE_WEAK, rumbleUp * 0xFFFF / (rumbleUp + rumbleDown));
+			}
 		} else {
-			rumbleCallback(0, RETRO_RUMBLE_STRONG, 0);
-			rumbleCallback(0, RETRO_RUMBLE_WEAK, 0);
+			//rumbleCallback(0, RETRO_RUMBLE_STRONG, 0);
+			//rumbleCallback(0, RETRO_RUMBLE_WEAK, 0);
+            if ((file = fopen("/sys/class/pwm/pwmchip0/pwm0/duty_cycle", "r+"))) {
+               fputs("1000000", file);
+               fclose(file);
+            } else if ((file = fopen("/sys/class/pwm/pwmchip1/pwm0/enable", "r+"))) {
+               fputs("1", file);
+               fclose(file);
+            } else {
+			   rumbleCallback(0, RETRO_RUMBLE_STRONG, 0);
+			   rumbleCallback(0, RETRO_RUMBLE_WEAK, 0);
+			}
 		}
 		rumbleUp = 0;
 		rumbleDown = 0;
