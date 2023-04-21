diff -rupN parallel-n64.orig/mupen64plus-core/src/plugin/emulate_game_controller_via_libretro.c parallel-n64/mupen64plus-core/src/plugin/emulate_game_controller_via_libretro.c
--- parallel-n64.orig/mupen64plus-core/src/plugin/emulate_game_controller_via_libretro.c	2023-04-22 02:20:28.289400421 +0900
+++ parallel-n64/mupen64plus-core/src/plugin/emulate_game_controller_via_libretro.c	2023-04-22 02:22:35.315128633 +0900
@@ -257,15 +257,36 @@ EXPORT void CALL inputControllerCommand(
 
                 if ((dwAddress == PAK_IO_RUMBLE) && (rumble.set_rumble_state))
                 {
+					FILE *file;
                     if (*Data)
                     {
-                        rumble.set_rumble_state(Control, RETRO_RUMBLE_WEAK, 0xFFFF);
-                        rumble.set_rumble_state(Control, RETRO_RUMBLE_STRONG, 0xFFFF);
+                        //rumble.set_rumble_state(Control, RETRO_RUMBLE_WEAK, 0xFFFF);
+                        //rumble.set_rumble_state(Control, RETRO_RUMBLE_STRONG, 0xFFFF);
+                        if ((file = fopen("/sys/class/pwm/pwmchip0/pwm0/duty_cycle", "r+"))) {
+                           fputs("10", file);
+                           fclose(file);
+                        } else if ((file = fopen("/sys/class/pwm/pwmchip1/pwm0/enable", "r+"))) {
+                           fputs("0", file);
+                           fclose(file);
+                        } else {
+                           rumble.set_rumble_state(Control, RETRO_RUMBLE_WEAK, 0xFFFF);
+                           rumble.set_rumble_state(Control, RETRO_RUMBLE_STRONG, 0xFFFF);
+                        }
                     }
                     else
                     {
-                        rumble.set_rumble_state(Control, RETRO_RUMBLE_WEAK, 0);
-                        rumble.set_rumble_state(Control, RETRO_RUMBLE_STRONG, 0);
+                        //rumble.set_rumble_state(Control, RETRO_RUMBLE_WEAK, 0);
+                        //rumble.set_rumble_state(Control, RETRO_RUMBLE_STRONG, 0);
+                        if ((file = fopen("/sys/class/pwm/pwmchip0/pwm0/duty_cycle", "r+"))) {
+                           fputs("1000000", file);
+                           fclose(file);
+                        } else if ((file = fopen("/sys/class/pwm/pwmchip1/pwm0/enable", "r+"))) {
+                           fputs("1", file);
+                           fclose(file);
+                        } else {
+                           rumble.set_rumble_state(Control, RETRO_RUMBLE_WEAK, 0);
+                           rumble.set_rumble_state(Control, RETRO_RUMBLE_STRONG, 0);
+                        }
                     }
                 }
             }
