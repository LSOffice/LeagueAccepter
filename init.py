import subprocess
import psutil

opened = False

def is_app_open(app_name):
    # Check if the application is running
    for proc in psutil.process_iter():
        if proc.name() == app_name:
            # Application is running, execute the .bat file
            return True
    return False

# Specify the application name and the path to the .bat file
app_name = "LeagueClient.exe"
bat_path = "run.bat"

while True:
    value = is_app_open(app_name)
    if value and not opened: subprocess.Popen(bat_path, shell=True)
    opened = value