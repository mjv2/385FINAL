# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\Mark\Desktop\ece385\FINALPROJECT\dec_10_wksp\dec_10_test\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\Mark\Desktop\ece385\FINALPROJECT\dec_10_wksp\dec_10_test\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {dec_10_test}\
-hw {C:\Users\Mark\Desktop\ece385\FINALPROJECT\dec_10_test.xsa}\
-out {C:/Users/Mark/Desktop/ece385/FINALPROJECT/dec_10_wksp}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {dec_10_test}
platform generate -quick
platform clean
platform generate
platform clean
platform generate
platform clean
platform generate
platform active {dec_10_test}
platform config -updatehw {C:/Users/Mark/Desktop/temporary/ece385/FINALPROJECT/mb_usb_hdmi_top.xsa}
platform clean
platform generate
platform config -updatehw {C:/Users/Mark/Desktop/temporary/ece385/FINALPROJECT/mb_usb_hdmi_top.xsa}
platform clean
platform generate
platform active {dec_10_test}
platform config -updatehw {C:/Users/Mark/Desktop/temporary/ece385/FINALPROJECT/dec_10_test.xsa}
platform clean
platform generate
platform config -updatehw {C:/Users/Mark/Desktop/temporary/ece385/FINALPROJECT/dec_10_test.xsa}
platform clean
platform generate
platform config -updatehw {C:/Users/Mark/Desktop/temporary/ece385/FINALPROJECT/dec_10_test.xsa}
platform clean
platform generate
platform active {dec_10_test}
platform config -updatehw {C:/Users/Mark/Desktop/temporary/ece385/FINALPROJECT/dec_10_test.xsa}
platform clean
platform generate
platform config -updatehw {C:/Users/Mark/Desktop/temporary/ece385/FINALPROJECT/dec_10_test.xsa}
platform clean
platform generate
