
#: For migrate one dir from C: to D: in same path, such as this `airshipper`: 

#: 1. dir prepare
New-Item -ItemType Directory -Force -Path "D:\Users\hmrg\AppData\Roaming\airshipper"
#: 2. robo moving
robocopy "C:\Users\hmrg\AppData\Roaming\airshipper" "D:\Users\hmrg\AppData\Roaming\airshipper" /E /MOVE
#: 3. create link
New-Item -ItemType Junction -Path "C:\Users\hmrg\AppData\Roaming\airshipper" -Target "D:\Users\hmrg\AppData\Roaming\airshipper"
