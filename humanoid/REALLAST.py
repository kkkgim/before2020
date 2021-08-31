
####        # -*- coding: utf-8 -*-

import platform
import numpy as np
import argparse
import cv2
import serial
import time
import sys



#-----------------------------------------------
yellow_Lower = (25, 133, 84)
yellow_Upper = (45, 253, 253)
#red_Lower = (0,134,84)
#red_Upper = (24,253,253)
red_Lower = (158, 60, 84)
red_Upper = (196, 223, 239)
blue_Lower = (100,50,0)
blue_Upper = (160,251,170)
green_Lower =(43,130,27)
green_Upper = (102,255,117)
now_color = 0
serial_use = 0
min_area=10
serial_port =  None
Temp_count = 0
Read_RX =  0
#--------------------------------------------
def check_send_serial(serials,send_data,tic):
        TX_data(serials,send_data)
        tic = float(tic)
        time.sleep(tic)
        count = 0
        #print(" TX=> " + str(send_data))
        
        Read_RX = RX_data(serials)
        
        while(Read_RX <> send_data):

            count=count+1
            print('ssss')
            if send_data == 239:
                    if count ==150:
                            Read_RX = send_data
                            break
            elif send_data == 237 or send_data ==238 or send_data == 243 or send_data == 241 or send_data == 242:
                    if count == 150:
                            Read_RX = send_data
                            break
            elif count == 30:
                    Read_RX = send_data
                    break

            if(Read_RX == send_data):
                break
            else:
                time.sleep(0.25)
                Read_RX = RX_data(serials)
            
        #print("RX ==>"+str(Read_RX))
#----------------------------------------------
def HoughLines(img):
    #H_View_Size = 450
    #W_View_Size = 200

    #img.set(3,H_View_Size)
    #img.set(4,W_View_Size)
    cv2.imwrite('/home/pi/hough1.jpg', img)
    img = cv2.imread('/home/pi/hough1.jpg')
    count = 1
    imgray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    edges = cv2.Canny(img, 0, 45, apertureSize = 3)
    cv2.imwrite('/home/pi/hough2.jpg', edges)

    lines = cv2.HoughLines(edges, 1, np.pi/180, 20)
    point1=[0,0]
    point2=[0,0]
    point3=[0,0]
    point4=[0,0]
    
   
    for line in lines:
        r, theta = line[0]
        a = np.cos(theta)
        b = np.sin(theta)
        x0 = a*r
        y0 = b*r
        x1=int(x0+1000*(-b))
        y1=int(y0+1000*a)
        x2=int(x0-1000*(-b))
        y2=int(y0-1000*a)

        #if(x1<0 and y2>450):
        #    continue
        #if(y1<0 and y1>200):
        #    continue
        #if(y2<0 and y2>200):
        #    continue
        
        #if(x2>450 and x2<0):
        #    continue
        X3,Y3,X4,Y4 = x1,y1,x2,y2

    if X3 == None or Y3 == None or X4 == None or Y4 == None:
            X3=0
            Y3=0
            X4=0
            Y4=0
            
    point = [X3,Y3,X4,Y4]
    return point, r, theta*180/np.pi
    
#----------------------------------------------
#----------------------------------------------
def create_blank(width, height, rgb_color=(0, 0, 0)):

    image = np.zeros((height, width, 3), np.uint8)
    color = tuple(reversed(rgb_color))
    image[:] = color

    return image

#-----------------------------------------------
def TX_data(serial, one_byte):  # one_byte= 0~255
    global Temp_count
    try:
        serial.write(chr(int(one_byte)))
    except:
        Temp_count = Temp_count  + 1
        print("TX Serial Not Open " + str(Temp_count))
        pass
#-----------------------------------------------
def RX_data(serial):
    global Temp_count
    try:
        if serial.inWaiting() > 0:
            result = serial.read(1)
            RX = ord(result)
            return RX
        else:
            return 0
    except:
        Temp_count = Temp_count  + 1
        print("RX Serial Not Open " + str(Temp_count))
        return 0
        pass
#-----------------------------------------------
def get_Yellow():
        box = np.zeros((4,2))
        count = 0
        i=0
        Area=0
        while count<7:
    
                (grabbed, frameYellow) = camera.read()
                frameYellow = np.int16(frameYellow)
                contrast = 70
                brightness = 70

                frameYellow = frameYellow*(contrast/127 + 1) - contrast + brightness

                frameYellow = np.clip(frameYellow, 0, 255)

                frameYellow = np.uint8(frameYellow)

                frameYellow = cv2.medianBlur(frameYellow, 5)
                
                count=count+1         
                kernel = cv2.getStructuringElement(cv2.MORPH_RECT,(4,4))
                hsv = cv2.cvtColor(frameYellow, cv2.COLOR_BGR2HSV)
                mask = cv2.inRange(hsv, yellow_Lower, yellow_Upper)
                mask = cv2.erode(mask, kernel, iterations=1)
                mask = cv2.dilate(mask, kernel, iterations=2)

                cnts = cv2.findContours(mask.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)[-2]

                if len(cnts) > 0:
                    c = max(cnts, key=cv2.contourArea)
                    Area = cv2.contourArea(c) / min_area
                        
                    if Area > 1000:
                            Area = 1000
                                    
                    if Area > min_area:
                        rect = cv2.minAreaRect(c)
                        box = cv2.boxPoints(rect)
                        box = np.int0(box)
                        cv2.drawContours(frameYellow, [box], 0, (0,255,255), 3)
                    

                else:
                    box = np.zeros((4,2))
                        
                #cv2.imshow('mini CTS4 - MaskYellow', mask)
                #cv2.imshow('mini CTS4 - Video', frameYellow )
                #key = 0xFF & cv2.waitKey(1)

        return box,Area
#-----------------------------------------------
def get_Red(i):
    count = 0
    lastY = 0
    avgX = 0
    AreaRed = 0
    while count<i:
        
        (grabbed, frameRed) = camera.read()
        frameRed = np.int16(frameRed)
        contrast = 70
        brightness = 75

        frameRed = frameRed*(contrast/127 + 1) - contrast + brightness

        frameRed = np.clip(frameRed, 0, 255)

        frameRed = np.uint8(frameRed)

        frameRed = cv2.medianBlur(frameRed, 3)
        
        kernel = cv2.getStructuringElement(cv2.MORPH_RECT,(4,4))
        hsvRed = cv2.cvtColor(frameRed, cv2.COLOR_BGR2HSV)
        maskRed = cv2.inRange(hsvRed, red_Lower, red_Upper)
        maskRed = cv2.erode(maskRed, kernel, iterations=1)
        maskRed = cv2.dilate(maskRed, kernel, iterations=2)
            
        cntRed = cv2.findContours(maskRed.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)[-2]

        if len(cntRed) > 0:
            cRed = max(cntRed, key=cv2.contourArea)
            AreaRed = cv2.contourArea(cRed) / min_area                
            if AreaRed > 255:
                AreaRed = 255
                                   
            if AreaRed > min_area:
                xRed, yRed, wRed, hRed = cv2.boundingRect(cRed)
                cv2.rectangle(frameRed, (xRed, yRed), (xRed + wRed, yRed + hRed), (0, 0, 255), 2)
                lastY = yRed + hRed
                avgX = (xRed+xRed+wRed)/2
        else:
            print('Red is Empty')
            xRed=0
            yRed=0
            wRed=0
            hRed=0
                
        #cv2.imshow('mini CTS4 - MaskRed', maskRed)
        #cv2.imshow('mini CTS4 - Video', frameRed)
        #key = 0xFF & cv2.waitKey(1)
        count = count +1


    return lastY, avgX, xRed, wRed
#-----------------------------------------------
def get_Blue():
    count = 0
    lastY = 0
    firstY = 0
    AreaBlue=0
    while count<7:
        
        (grabbed, frameBlue) = camera.read()
        frameBlue = np.int16(frameBlue)
        contrast = 70
        brightness = 75

        frameBlue = frameBlue*(contrast/127 + 1) - contrast + brightness

        frameBlue= np.clip(frameBlue, 0, 255)

        frameBlue = np.uint8(frameBlue)

        frameBlue = cv2.medianBlur(frameBlue, 3)
        kernel = cv2.getStructuringElement(cv2.MORPH_RECT,(4,4))
        hsvBlue = cv2.cvtColor(frameBlue, cv2.COLOR_BGR2HSV)
        maskBlue = cv2.inRange(hsvBlue, blue_Lower, blue_Upper)
        maskBlue = cv2.erode(maskBlue, kernel, iterations=1)
        maskBlue = cv2.dilate(maskBlue, kernel, iterations=2)
            
        cntBlue = cv2.findContours(maskBlue.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)[-2]

        if len(cntBlue) > 0:
            cBlue = max(cntBlue, key=cv2.contourArea)
            AreaBlue = cv2.contourArea(cBlue) / min_area                
            if AreaBlue > 255:
                AreaBlue = 255
                                    
            if AreaBlue > min_area:
                xBlue, yBlue, wBlue, hBlue = cv2.boundingRect(cBlue)
                cv2.rectangle(frameBlue, (xBlue, yBlue), (xBlue + wBlue, yBlue + hBlue), (255,0,0), 2)
                lastY = yBlue + hBlue
                firstY = yBlue
        else:
            print('Blue is Empty')
            xBlue=0
            yBlue=0
            wBlue=0
            hBlue=0
                
        #cv2.imshow('mini CTS4 - MaskBlue', maskBlue)
        #cv2.imshow('mini CTS4 - Video', frameBlue)
        #key = 0xFF & cv2.waitKey(1)
        count = count +1


    return lastY,firstY, xBlue, wBlue
#-----------------------------------------------
def get_Green():
    
    count = 0
    lastY = 0
    avgX = 0
    AreaGreen=0
    while count<3:
        (grabbed, frameGreen) = camera.read()
        frameGreen = np.int16(frameGreen)
        contrast = 70
        brightness = 75

        frameGreen = frameGreen*(contrast/127 + 1) - contrast + brightness

        frameGreen= np.clip(frameGreen, 0, 255)

        frameGreen = np.uint8(frameGreen)
        kernel = cv2.getStructuringElement(cv2.MORPH_RECT,(4,4))
        hsvGreen = cv2.cvtColor(frameGreen, cv2.COLOR_BGR2HSV)
        maskGreen = cv2.inRange(hsvGreen, green_Lower, green_Upper)
        maskGreen = cv2.erode(maskGreen, kernel, iterations=1)
        maskGreen = cv2.dilate(maskGreen, kernel, iterations=2)
            
        cntGreen = cv2.findContours(maskGreen.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)[-2]

        if len(cntGreen) > 0:
            cGreen = max(cntGreen, key=cv2.contourArea)
            AreaGreen = cv2.contourArea(cGreen) / min_area                
         
            if AreaGreen > 255:
                AreaGreen = 255
                    
                            
            if AreaGreen > min_area:
                xGreen, yGreen, wGreen, hGreen = cv2.boundingRect(cGreen)
                cv2.rectangle(frameGreen, (xGreen, yGreen), (xGreen + wGreen, yGreen + hGreen), (0, 255, 0), 2)
                lastY = yGreen + hGreen
                avgX = (xGreen+xGreen+wGreen)/2
        else:
            print('Green is Empty')
            xGreen=0
            yGreen=0
            wGreen=0
            hGreen=0
                
        #cv2.imshow('mini CTS4 - MaskGreen', maskGreen)
        #cv2.imshow('mini CTS4 - Video', frameGreen)
        #key = 0xFF & cv2.waitKey(1)
        count = count +1

        
    return lastY, avgX
    
# **************************************************
# **************************************************
# **************************************************
if __name__ == '__main__':
    #------------------------------------- 
    #---- user Setting -------------------
    #-------------------------------------
    W_View_size =  450 
    H_View_size = 200

    BPS =  4800  # 4800,9600,14400, 19200,28800, 57600, 115200
    serial_use = 1
    now_color = 0
    step = 0
    
    #-------------------------------------
    ap = argparse.ArgumentParser()
    args = vars(ap.parse_args())
    #---------------------------
    if not args.get("video", False):
        camera = cv2.VideoCapture(0)
    else:
        camera = cv2.VideoCapture(args["video"])
    #---------------------------
    camera.set(3, W_View_size)
    camera.set(4, H_View_size)
    #camera.set(5, 60)
    #time.sleep(0.1) # 0.5
    #---------------------------
    if serial_use <> 0:
        serial_port = serial.Serial('/dev/ttyAMA0', BPS, timeout=0.001)
        serial_port.flush() # serial cls
    i=0
    YellowFirst = 1
    RedFirst = 1
    FirstBlue = 1
    count = 0
    #---------------------------------------------------------------------------------
    #---------------------------------------------------------------------------------
    #---------------------------------------------------------------------------------
    count0 = 0
    first_Blank = 1
    check_send_serial(serial_port,234,0)
    while step==0:    
        
        if YellowFirst == 1:
                YellowFirst = 0
                box,Area = get_Yellow()
                box,Area = get_Yellow()
                box,Area = get_Yellow()
        else:
                box,Area = get_Yellow()
        x0 = box[0][0]
        x1 = box[1][0]
        x2 = box[2][0]
        x3 = box[3][0]
        y0 = box[0][1]
        y1 = box[1][1]
        y2 = box[2][1]
        y3 = box[3][1]
                    
        if x1 == 0. and x2 == 0.:
                print('Yellow is Empty')
                check_send_serial(serial_port,220,0) #dagari dulgi
                if RedFirst == 1:
                        RedFirst = 0
                        RedY,avgX, xRed, wRed = get_Red(7)
                        RedY,avgX, xRed, wRed  = get_Red(7)
                        RedY,avgX, xRed, wRed  = get_Red(7)
                else:
                        RedY,avgX, xRed, wRed  = get_Red(7)
                if RedY >=10:
                        
                        check_send_serial(serial_port,231,0)
                        check_send_serial(serial_port,232,0)
                        check_send_serial(serial_port,222,0)
                        check_send_serial(serial_port,222,0)
                        check_send_serial(serial_port,222,0)
                        check_send_serial(serial_port,222,0)
                        check_send_serial(serial_port,222,0)
                        check_send_serial(serial_port,234,0)
                        step=1
                        break

                else:
                        if first_Blank == 1:
                                check_send_serial(serial_port,254,0)
                                check_send_serial(serial_port,254,0)
                                first_Blank = 0
                        else:
                                check_send_serial(serial_port,236,0)
                                check_send_serial(serial_port,254,0)
                                check_send_serial(serial_port,254,0)
        else:
                print('Yellow!')      
                print ('x0, x1, x2, x3 =', x0, x1, x2, x3)      

                if x2 - x0 <0:
                        print('Robot is Left Side!')
                        if x0-x1>=200 and y3-y0<=60:
                                print("Is Full")
                                check_send_serial(serial_port,235,0)        
                        elif x3<150:
                                print("Robot is So Far!")
                                check_send_serial(serial_port, 233, 0)
                        elif x3>300:
                                print("Robot is So Far!")
                                check_send_serial(serial_port, 231, 0)
                        else:
                                if x3-x2==0:
                                        x3=x3+1
                                slope = float((float(y3-y2)/float(x3-x2)))
                                print(slope)
                                if slope>0.3 and slope<5.0 and x3>=150 and x3<210:          
                                        check_send_serial(serial_port,235,0)
                                elif slope>0.3 and slope<5.0 and x3>240 and x3<=300:          
                                        check_send_serial(serial_port,235,0)
                                elif slope>=5.0 or (slope >=0.0 and slope <=0.3) or(x3>=210 and x3<=240):
                                        if count0 == 0:
                                                check_send_serial(serial_port,254,0)
                                                check_send_serial(serial_port,254,0)
                                                check_send_serial(serial_port,254,0)
                                                count0 = count0 + 1
                                        else:
                                                check_send_serial(serial_port,254,0)
                                                check_send_serial(serial_port,254,0)
                        
                elif x2-x0>=0:
                        print("Robot is Right Side!")
                        if  x3-x0>=200 and y2-y3<=60:
                                print("Is Full")
                                check_send_serial(serial_port,236,0)
                        elif x0<150:
                                print("Robot is So Far!")
                                check_send_serial(serial_port, 233, 0)
                        elif x0>300:
                                print("Robot is So Far!")
                                check_send_serial(serial_port, 231, 0)
                        else:
                                if x0-x3==0:
                                        x3=x3+1
                                slope = float((float(y0-y3)/float(x0-x3)))
                                print(slope)
                                if slope<-0.3 and slope>-5.0 and x0<210 and x0>=150:          
                                        check_send_serial(serial_port,236,0)
                                if slope<-0.3 and slope>-5.0 and x0>240 and x0<=300:          
                                        check_send_serial(serial_port,236,0)
                                elif slope<=-5.0 or (slope <=-0.0 and slope>=-0.3) or(x0>=210 and x0<=240):
                                        if count0 == 0:
                                                check_send_serial(serial_port,254,0)
                                                check_send_serial(serial_port,254,0)
                                                check_send_serial(serial_port,254,0)
                                                count0 = count0 + 1
                                        else:
                                                check_send_serial(serial_port,254,0)
                                                check_send_serial(serial_port,254,0)
    #---------------------------------------------------------------------------------
    fall = 0
    stair = 0
    while step ==1:
        if stair==0:
                check_send_serial(serial_port, 234, 0)
                time.sleep(1.5)
                check_send_serial(serial_port, 237, 0)
                check_send_serial(serial_port, 248, 0)
                check_send_serial(serial_port, 231, 0)
                check_send_serial(serial_port, 222, 0)
                check_send_serial(serial_port, 222, 0)
                check_send_serial(serial_port, 221, 0)
                stair=1
                blueLastY,blueFirstY,xBlue,wBlue = get_Blue()
                blueLastY,blueFirstY,xBlue,wBlue = get_Blue()
                blueLastY,blueFirstY,xBlue,wBlue = get_Blue()
        if blueLastY >=10: # 2nd floor
                print('First Blue')
                check_send_serial(serial_port,237,0)
                check_send_serial(serial_port,234,0)
                check_send_serial(serial_port, 221, 0)
                blueLastY,blueFirstY,xBlue,wBlue = get_Blue()
                blueLastY,blueFirstY,xBlue,wBlue = get_Blue()
        if blueLastY >= 150:
                print('Second Blue')
                check_send_serial(serial_port,248,0)
                check_send_serial(serial_port,248,0)
                check_send_serial(serial_port,243,0)
                check_send_serial(serial_port,248,0)
                check_send_serial(serial_port,243,0)
                check_send_serial(serial_port,248,0)
                step = 2
                break                 
        else:
                lastYRed, avgXRed, xRed, wRed = get_Red(3)
                if RedY >=10:
                        check_send_serial(serial_port,231,0)
                        check_send_serial(serial_port,232,0)
                        check_send_serial(serial_port,232,0)
                        check_send_serial(serial_port,254,0)
                        check_send_serial(serial_port,222,0)
                        check_send_serial(serial_port,222,0)
                        stair=0                                                          
                        continue

    #---------------------------------------------------------------------------------                               
    bridgeCount = 0
    cornerCount2 = 0
    countLeft2 = 0
    while step == 2:
        print('step2!')
        
        box,Area = get_Yellow()
        print('Yellow!')
        x0 = box[0][0]
        x1 = box[1][0]
        x2 = box[2][0]
        x3 = box[3][0]
        y0 = box[0][1]
        y1 = box[1][1]
        y2 = box[2][1]
        y3 = box[3][1]
        print ('x0, x1, x2, x3 =', x0, x1, x2, x3)
        if bridgeCount == 4:
                check_send_serial(serial_port, 253, 0)
                cornerCount2 = cornerCount2 + 1
                bridgeCount = bridgeCount +1   
        if x1 == 0. and x2 == 0.:
                if bridgeCount >=4:
                        check_send_serial(serial_port,215,0)
                else:
                        check_send_serial(serial_port, 224, 0)
                        box,Area = get_Yellow()
                        if Area > 0:
                                print('yellow is empty daegari right!')
                                check_send_serial(serial_port, 251, 0)
                        else:
                                print('Yellow is Empty') 
                                check_send_serial(serial_port, 250, 0)
                                countLeft2 = countLeft2 + 1
                                if countLeft2 == 2:
                                      check_send_serial(serial_port, 251, 0)
                                      countLeft2 = 0  
        else:
                        if x2-x0 <0:
                                print('Robot is Left Side!')
                                if x0-x1>=200 and y3-y0<=60:
                                        print("Is Full")
                                        check_send_serial(serial_port,235,0)        
                                elif x3<163:
                                        print("Robot is So Far!")
                                        check_send_serial(serial_port, 246, 0)
                                elif x3>287:
                                        print("Robot is So Far!")
                                        check_send_serial(serial_port, 247, 0)
                                else:
                                        if x3-x2==0:
                                                x3=x3+1
                                        slope = float((float(y3-y2)/float(x3-x2)))
                                        print(slope)
                                        if slope>0.5 and slope<4.0 and x3>=163 and x3<210:          
                                                check_send_serial(serial_port,235,0)
                                        elif slope>0.5 and slope<4.0 and x3>240 and x3<=287:
                                                check_send_serial(serial_port,247,0)
                                                check_send_serial(serial_port,235,0)
                                        elif slope>=4.0 or (slope >=0.0 and slope <=0.5) or(x3>=210 and x3<=240):
                                                TX_data(serial_port, 228)
                                                print('Send RED LIGHT 228')
                                                time.sleep(0.25)
                                                Read_RX = RX_data(serial_port)
                                                print("Rx = ?", Read_RX)
                                                if Read_RX == 77 and bridgeCount > 4:
                                                        check_send_serial(serial_port, 241, 0)
                                                        check_send_serial(serial_port, 234, 0)
                                                        step = 3
                                                        break
                                                else:
                                                        if bridgeCount == 0:
                                                                check_send_serial(serial_port, 254, 0)
                                                                bridgeCount = bridgeCount +1
                                                        elif bridgeCount >= 4:
                                                                check_send_serial(serial_port, 254, 0)
                                                        else:
                                                                check_send_serial(serial_port, 254, 0)
                                                                check_send_serial(serial_port, 254, 0)
                                                                bridgeCount = bridgeCount +1
                                                        
                        elif x2-x0>=0:
                                print("Robot is Right Side!")
                                if  x3-x0>=200 and y2-y3<=60:
                                        print("Is Full")
                                        check_send_serial(serial_port,236,0)
                                elif x0<163:
                                        print("Robot is So Far!")
                                        check_send_serial(serial_port, 246, 0)
                                elif x0>287:
                                        print("Robot is So Far!")
                                        check_send_serial(serial_port, 247, 0)
                                else:
                                        if x0-x3==0:
                                                x3=x3+1
                                        slope = float((float(y0-y3)/float(x0-x3)))
                                        print(slope)
                                        if slope<-0.5 and slope>-4.0 and x0<210 and x0>=163:          
                                                check_send_serial(serial_port,236,0)
                                        if slope<-0.5 and slope>-4.0 and x0>240 and x0<=287:
                                                check_send_serial(serial_port,246,0)
                                                check_send_serial(serial_port,236,0)
                                        elif slope<=-4.0 or (slope <=-0.0 and slope>=-0.5) or(x0>=210 and x0<=240):
                                                TX_data(serial_port, 228)
                                                print('Send TX')
                                                time.sleep(0.25)
                                                Read_RX = RX_data(serial_port)
                                                print("Rx = ?", Read_RX)
                                                if Read_RX == 77 and bridgeCount > 4:
                                                        check_send_serial(serial_port, 241, 0)
                                                        check_send_serial(serial_port, 234, 0)
                                                        step = 3
                                                        break
                                                else:
                                                        if bridgeCount ==0:
                                                                check_send_serial(serial_port, 254, 0)
                                                                bridgeCount = bridgeCount +1
                                                        elif bridgeCount >=4 :
                                                                check_send_serial(serial_port, 254, 0)
                                                        else:
                                                                check_send_serial(serial_port, 254, 0)
                                                                check_send_serial(serial_port, 254, 0)
                                                                bridgeCount = bridgeCount +1
                                                        
    #---------------------------------------------------------------------------------
    count3 = 0
    countTurnel=0
    countLeft3 = 0
    countRight3 = 0
    AreaCount3 = 0
    while step ==3:
        print('step3!!')
        TX_data(serial_port,228)
        time.sleep(0.25)
        Read_RX = RX_data(serial_port)
        print("Rx = ?", Read_RX)
        if Read_RX == 78 and countTurnel >=2:
                print('Turnel')
                check_send_serial(serial_port, 233, 0)
                check_send_serial(serial_port, 239,0)
                check_send_serial(serial_port, 234,0)
                step=4
                break
                                                
        box,Area = get_Yellow()
        x0 = box[0][0]
        x1 = box[1][0]
        x2 = box[2][0]
        x3 = box[3][0]
        y0 = box[0][1]
        y1 = box[1][1]
        y2 = box[2][1]
        y3 = box[3][1]
        if Area >=700 and AreaCount3 == 0:
                check_send_serial(serial_port,252,0)
                AreaCount3 = AreaCount3 + 1
        print ('x0, x1, x2, x3 =', x0, x1, x2, x3)
        if x1 == 0. and x2 == 0. :
                check_send_serial(serial_port, 224, 0)
                box,Area = get_Yellow()
                if Area > 0:
                        print('yellow is empty daegari right!')
                        check_send_serial(serial_port, 251, 0)
                else:
                        print('Yellow is Empty')    
                        if countLeft3 == 2:
                              check_send_serial(serial_port, 251, 0)
                              countLeft3 = 0
                        else:
                                check_send_serial(serial_port, 250, 0)
                                countLeft3 = countLeft3 + 1
        else:
                if x2 - x0 <0:
                        print('Robot is Left Side!')
                        if x0-x1>=200 and y3-y0<=60 and AreaCount3 < 2:
                                print("Is Full")
                                check_send_serial(serial_port,235,0)
                                countLeft3 = 0
                                AreaCount3 = AreaCount3 + 1
                        elif x3<50:
                                print("Robot is So Far!")
                                check_send_serial(serial_port, 233, 0)
                                countLeft3 = 0
                        elif x3>400:
                                print("Robot is So Far!")
                                check_send_serial(serial_port, 231, 0)
                                countLeft3 = 0
                        
                        else:
                                if x3-x2==0:
                                        x3=x3+1
                                slope = float((float(y3-y2)/float(x3-x2)))
                                print(slope)
                                if slope>0.8 and slope<5.0:          
                                        check_send_serial(serial_port,235,0)
                                        countLeft3 = 0
                                elif slope>0.8 and slope<5.0:          
                                        check_send_serial(serial_port,235,0)
                                        countLeft3 = 0
                                elif slope>=5.0 or (slope >=0.0 and slope <0.8):
                                        print('slope is Center')
                                        if count3 >=1 and count3<4:
                                                check_send_serial(serial_port, 249, 0)
                                                check_send_serial(serial_port, 249, 0)
                                                AreaCount3 = AreaCount3+1
                                                count3 = count3+1
                                                countTurnel = countTurnel+1
                                        else:
                                                check_send_serial(serial_port, 249, 0)
                                                count3 = count3+1
                                                countTurnel = countTurnel+1
                                                        
                                        
                                        
                elif x2-x0>=0:
                        countLeft3 = 0
                        print("Robot is Right Side!")
                        if  x3-x0>=200 and y2-y3<=60:
                                print("Is Full")
                                check_send_serial(serial_port,236,0)
                                
                        elif x0<50:
                                print("Robot is So Far!")
                                check_send_serial(serial_port, 233, 0)
                                
                        elif x0>400:
                                print("Robot is So Far!")
                                check_send_serial(serial_port, 231, 0)
                    
                        else:
                                if x0-x3==0:
                                        x3=x3+1
                                slope = float((float(y0-y3)/float(x0-x3)))
                                print(slope)
                                if slope<-0.8 and slope>-5.0:          
                                        check_send_serial(serial_port,236,0)
                                        countRight3 = countRight3+1
                                elif slope<-0.8 and slope>-5.0:          
                                        check_send_serial(serial_port,236,0)
                                        countRight3 = countRight3+1
                                elif slope<=-5.0 or (slope <=-0.0 and slope>=-0.8):
                                        print('slope is Center')
                                        if count3 >=1 and count3<4:
                                                check_send_serial(serial_port, 249, 0)
                                                check_send_serial(serial_port, 249, 0)
                                                AreaCount3 = AreaCount3+1
                                                count3 = count3+1
                                                countTurnel = countTurnel+1
                                        else: 
                                                check_send_serial(serial_port, 249, 0)
                                                count3 = count3+1
                                                countTurnel = countTurnel+1                  
                        
                    
    #---------------------------------------------------------------------------------
    count4 = 0
    countBelb = 0
    countLeft4 = 0
    while step ==4:
        print('step4!!')
        
        
        box,Area = get_Yellow()
        x0 = box[0][0]
        x1 = box[1][0]
        x2 = box[2][0]
        x3 = box[3][0]
        y0 = box[0][1]
        y1 = box[1][1]
        y2 = box[2][1]
        y3 = box[3][1]
        
        print ('x0, x1, x2, x3 =', x0, x1, x2, x3)
        if x1 == 0. and x2 == 0. :
                if countBelb <1:
                        check_send_serial(serial_port, 224, 0)
                else:
                        check_send_serial(serial_port, 234, 0)
                box,Area = get_Yellow()
                if Area > 0:
                        print('yellow is empty daegari right!')
                        check_send_serial(serial_port, 236, 0)
                else:
                        print('Yellow is Empty')
                        if countBelb >= 1:
                              check_send_serial(serial_port, 234, 0)
                              check_send_serial(serial_port, 215, 0)
                        if countLeft4 == 2:
                              check_send_serial(serial_port, 235, 0)
                              countLeft4 = 0
                        else:
                                check_send_serial(serial_port, 250, 0)
                                countLeft4 = countLeft4 + 1      
        else:
                countLeft4 = 0
                if x2 - x0 <0:
                        print('Robot is Left Side!')
                        if x0-x1>=200 and y3-y0<=60:
                                print("Is Full")
                                check_send_serial(serial_port,235,0)        
                        elif x3<60:
                                print("Robot is So Far!")
                                check_send_serial(serial_port, 233, 0)
                        elif x3>190:
                                print("Robot is So Far!")
                                check_send_serial(serial_port, 231, 0)
                        else:
                                if x3-x2==0:
                                        x3=x3+1
                                slope = float((float(y3-y2)/float(x3-x2)))
                                print(slope)
                                if slope>1.0 and slope<6.0 and x3>=60 and x3<110:          
                                        check_send_serial(serial_port,235,0)
                                elif slope>1.0 and slope<6.0 and x3>140 and x3<=190:          
                                        check_send_serial(serial_port,235,0)
                                elif slope>=6.0 or (slope >=0.0 and slope <=1.0) or(x3>=110 and x3<=140):
                                        print('slope is Center')
                                        TX_data(serial_port,228)
                                        time.sleep(0.25)
                                        Read_RX = RX_data(serial_port)
                                        print("Rx = ?", Read_RX)
                                        if Read_RX == 79 and countBelb >= 1:
                                                print('Belb')
                                                check_send_serial(serial_port, 248,0)
                                                check_send_serial(serial_port, 248,0)
                                                check_send_serial(serial_port, 242,0)
                                                check_send_serial(serial_port, 234,0)
                                                time.sleep(0.25)
                                                check_send_serial(serial_port, 251,0)
                                                check_send_serial(serial_port, 251,0)
                                                check_send_serial(serial_port, 251,0)
                                                check_send_serial(serial_port, 231,0)
                                                check_send_serial(serial_port, 231,0)
                                                continue
                                        
                                        if count4 > 1:
                                                check_send_serial(serial_port, 232, 0)
                                                countBelb = countBelb+1
                                        
                                        else:
                                                check_send_serial(serial_port, 249, 0)
                                                check_send_serial(serial_port, 249, 0)
                                                count4 = count4+1
                                                countBelb = countBelb+1
                                        
                                        
                elif x2-x0>=0:
                        print("Robot is Right Side!")
                        if  x3-x0>=200 and y2-y3<=60:
                                print("Is Full")
                                check_send_serial(serial_port,236,0)
                        elif x0<60:
                                print("Robot is So Far!")
                                check_send_serial(serial_port, 233, 0)
                        elif x0>190:
                                print("Robot is So Far!")
                                check_send_serial(serial_port, 231, 0)
                        else:
                                if x0-x3==0:
                                        x3=x3+1
                                slope = float((float(y0-y3)/float(x0-x3)))
                                print(slope)
                                if slope<-1.0 and slope>-6.0 and x0<110 and x0>=60:          
                                        check_send_serial(serial_port,236,0)
                                elif slope<-1.0 and slope>-6.0 and x0>140 and x0<=190:          
                                        check_send_serial(serial_port,236,0)
                                elif slope<=-6.0 or (slope <=-0.0 and slope>=-1.0) or(x0>=110 and x0<=140):
                                        TX_data(serial_port,228)        
                                        time.sleep(0.25)
                                        Read_RX = RX_data(serial_port)
                                        print("Rx = ?", Read_RX)
                                        if Read_RX == 79 and countBelb >= 1:
                                                
                                                print('Belb')
                                                check_send_serial(serial_port, 248,0)
                                                check_send_serial(serial_port, 248,0)
                                                check_send_serial(serial_port, 248,0)
                                                check_send_serial(serial_port, 242,0)
                                                check_send_serial(serial_port, 234,0)
                                                time.sleep(0.5)
                                                check_send_serial(serial_port, 251,0)
                                                check_send_serial(serial_port, 251,0)
                                                check_send_serial(serial_port, 251,0)
                                                check_send_serial(serial_port, 231,0)
                                                check_send_serial(serial_port, 231,0)
                                                continue

                                        print('slope is Center')
                                        if count4 > 1:
                                                check_send_serial(serial_port, 232, 0)
                                                countBelb = countBelb+1
                                        else: 
                                                check_send_serial(serial_port, 249, 0)
                                                check_send_serial(serial_port, 249, 0)
                                                count4 = count4+1
                                                countBelb = countBelb+1
