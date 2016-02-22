import pyautogui
import time

print(pyautogui.position())

pyautogui.moveTo(100,100)
pyautogui.moveTo(600,500,duration=2)

#pyautogui.click(80,80)
#pyautogui.doubleClick(200,150)
#pyautogui.rightClick(300,200)

pyautogui.click(600,500)
pyautogui.typewrite("Bhishan")
pyautogui.typewrite("hello world", interval=1.0)

time.sleep(2)

print(pyautogui.KEYBOARD_KEYS)
time.sleep(2)

pyautogui.press('right');pyautogui.press('enter')

pyautogui.hotkey('ctrl','r');pyautogui.hotkey('ctrl','s')