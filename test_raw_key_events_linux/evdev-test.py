#!/usr/bin/env python3

from evdev import UInput, ecodes as e
from time import sleep

ui = UInput()

def sendKey(key, description):
    print(f"Pressing key {description}")
    if key == e.KEY_EXIT or key == e.KEY_CHANNELUP or e.KEY_CHANNELDOWN:
        ui.write(e.EV_KEY, key, 1)
        ui.write(e.EV_KEY, key, 0)
    else:
        ui.write(e.EV_KEY, key, 1)
        ui.write(e.EV_KEY, key, 0)
    ui.syn()
    sleep(1)

if __name__ == "__main__":
    sleep(5)
    sendKey(e.KEY_EXIT, "EXIT")
    '''
    print("sending key F1")
    sendKey(e.KEY_F1)
    sleep(1)
    print("sending key F2")
    sendKey(e.KEY_F2)
    sleep(1)
    print("sending key F3")
    sendKey(e.KEY_F3)
    sleep(1)
    print("sending key F4")
    sendKey(e.KEY_F4)
    '''
    while True:
        pass
