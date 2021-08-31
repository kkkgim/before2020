'******** 2족 보행로봇 초기 영점 프로그램 ********

DIM I AS BYTE
DIM J AS BYTE
DIM MODE AS BYTE
DIM A AS BYTE
DIM A_old AS BYTE
DIM B AS BYTE
DIM C AS BYTE
DIM 보행속도 AS BYTE
DIM 좌우속도 AS BYTE
DIM 좌우속도2 AS BYTE
DIM 보행순서 AS BYTE
DIM 현재전압 AS BYTE
DIM 반전체크 AS BYTE
DIM 모터ONOFF AS BYTE
DIM 자이로ONOFF AS BYTE
DIM 기울기앞뒤 AS INTEGER
DIM 기울기좌우 AS INTEGER
DIM 자세 AS BYTE
DIM 곡선방향 AS BYTE
DIM 패스트발순서 AS BYTE
DIM 슬로우발순서 AS BYTE
DIM 발순서 AS BYTE
DIM 넘어진확인 AS BYTE
DIM 기울기확인횟수 AS BYTE
DIM 보행횟수 AS BYTE
DIM 보행COUNT AS BYTE
DIM 단계 AS BYTE
DIM 적외선거리값  AS BYTE
DIM 좌우 AS BYTE

DIM S11  AS BYTE
DIM S16  AS BYTE
'************************************************
DIM NO_0 AS BYTE
DIM NO_1 AS BYTE
DIM NO_2 AS BYTE
DIM NO_3 AS BYTE
DIM NO_4 AS BYTE

DIM NUM AS BYTE

DIM BUTTON_NO AS INTEGER
DIM SOUND_BUSY AS BYTE
DIM TEMP_INTEGER AS INTEGER

'**** 기울기센서포트 설정 ****
CONST 앞뒤기울기AD포트 = 0
CONST 좌우기울기AD포트 = 1
CONST 기울기확인시간 = 20  'ms


CONST min = 61	'뒤로넘어졌을때
CONST max = 107	'앞으로넘어졌을때
CONST COUNT_MAX = 3


CONST 머리이동속도 = 10
'************************************************



PTP SETON 				'단위그룹별 점대점동작 설정
PTP ALLON				'전체모터 점대점 동작 설정

DIR G6A,1,0,0,1,0,0		'모터0~5번
DIR G6D,0,1,1,0,1,1		'모터18~23번
DIR G6B,1,1,1,1,1,1		'모터6~11번
DIR G6C,0,0,0,0,1,0		'모터12~17번

'************************************************

OUT 52,0	'머리 LED 켜기
'***** 초기선언 '************************************************

보행순서 = 0
반전체크 = 0
기울기확인횟수 = 0
보행횟수 = 1
모터ONOFF = 0
단계 = 0
좌우 = 0
슬로우발순서= 0 
패스트발순서= 0
발순서= 0
'****초기위치 피드백*****************************


TEMPO 230
MUSIC "cdefg"



SPEED 5
GOSUB MOTOR_ON

S11 = MOTORIN(11)
S16 = MOTORIN(16)

SERVO 11, 100
SERVO 16, S16



GOSUB 전원초기자세
GOSUB 기본자세


GOSUB 자이로INIT
GOSUB 자이로MID
GOSUB 자이로ON



PRINT "VOLUME 200 !"
PRINT "SOUND 12 !" '안녕하세요

GOSUB All_motor_mode3



GOTO MAIN	'시리얼 수신 루틴으로 가기

'************************************************

'*********************************************
' Infrared_Distance = 60 ' About 20cm
' Infrared_Distance = 50 ' About 25cm
' Infrared_Distance = 30 ' About 45cm
' Infrared_Distance = 20 ' About 65cm
' Infrared_Distance = 10 ' About 95cm
'*********************************************
'************************************************
시작음:
    TEMPO 220
    MUSIC "O23EAB7EA>3#C"
    RETURN
    '************************************************
종료음:
    TEMPO 220
    MUSIC "O38GD<BGD<BG"
    RETURN
    '************************************************
에러음:
    TEMPO 250
    MUSIC "FFF"
    RETURN
    '************************************************
    '************************************************
MOTOR_ON: '전포트서보모터사용설정

    GOSUB MOTOR_GET

    MOTOR G6B
    DELAY 50
    MOTOR G6C
    DELAY 50
    MOTOR G6A
    DELAY 50
    MOTOR G6D

    모터ONOFF = 0
    GOSUB 시작음			
    RETURN

    '************************************************
    '전포트서보모터사용설정
MOTOR_OFF:

    MOTOROFF G6B
    MOTOROFF G6C
    MOTOROFF G6A
    MOTOROFF G6D
    모터ONOFF = 1	
    GOSUB MOTOR_GET	
    GOSUB 종료음	
    RETURN
    '************************************************
    '위치값피드백
MOTOR_GET:
    GETMOTORSET G6A,1,1,1,1,1,0
    GETMOTORSET G6B,1,1,1,0,0,1
    GETMOTORSET G6C,1,1,1,0,1,0
    GETMOTORSET G6D,1,1,1,1,1,0
    RETURN

    '************************************************
    '위치값피드백
MOTOR_SET:
    GETMOTORSET G6A,1,1,1,1,1,0
    GETMOTORSET G6B,1,1,1,0,0,1
    GETMOTORSET G6C,1,1,1,0,1,0
    GETMOTORSET G6D,1,1,1,1,1,0
    RETURN

    '************************************************
All_motor_Reset:

    MOTORMODE G6A,1,1,1,1,1,1
    MOTORMODE G6D,1,1,1,1,1,1
    MOTORMODE G6B,1,1,1,,,1
    MOTORMODE G6C,1,1,1,,1

    RETURN
    '************************************************
All_motor_mode2:

    MOTORMODE G6A,2,2,2,2,2
    MOTORMODE G6D,2,2,2,2,2
    MOTORMODE G6B,2,2,2,,,2
    MOTORMODE G6C,2,2,2,,2

    RETURN
    '************************************************
All_motor_mode3:

    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    MOTORMODE G6B,3,3,3,,,3
    MOTORMODE G6C,3,3,3,,3

    RETURN
    '************************************************
Leg_motor_mode1:
    MOTORMODE G6A,1,1,1,1,1
    MOTORMODE G6D,1,1,1,1,1
    RETURN
    '************************************************
Leg_motor_mode2:
    MOTORMODE G6A,2,2,2,2,2
    MOTORMODE G6D,2,2,2,2,2
    RETURN

    '************************************************
Leg_motor_mode3:
    MOTORMODE G6A,3,3,3,3,3
    MOTORMODE G6D,3,3,3,3,3
    RETURN
    '************************************************
Leg_motor_mode4:
    MOTORMODE G6A,3,2,2,1,3
    MOTORMODE G6D,3,2,2,1,3
    RETURN
    '************************************************
Leg_motor_mode5:
    MOTORMODE G6A,3,2,2,1,2
    MOTORMODE G6D,3,2,2,1,2
    RETURN
    '************************************************
Arm_motor_mode1:
    MOTORMODE G6B,1,1,1,,,1
    MOTORMODE G6C,1,1,1,,1
    RETURN
    '************************************************
Arm_motor_mode2:
    MOTORMODE G6B,2,2,2,,,2
    MOTORMODE G6C,2,2,2,,2
    RETURN

    '************************************************
Arm_motor_mode3:
    MOTORMODE G6B,3,3,3,,,3
    MOTORMODE G6C,3,3,3,,3
    RETURN
    '************************************************
    '***********************************************
    '***********************************************
    '**** 자이로감도 설정 ****
자이로INIT:

    GYRODIR G6A, 0, 0, 1, 0,0
    GYRODIR G6D, 1, 0, 1, 0,0

    GYROSENSE G6A,200,150,30,150,0
    GYROSENSE G6D,200,150,30,150,0

    RETURN
    '***********************************************
    '**** 자이로감도 설정 ****
자이로MAX:

    GYROSENSE G6A,250,180,30,180,0
    GYROSENSE G6D,250,180,30,180,0

    RETURN
    '***********************************************
자이로MID:

    GYROSENSE G6A,200,150,30,150,0
    GYROSENSE G6D,200,150,30,150,0

    RETURN
    '***********************************************
자이로MIN:

    GYROSENSE G6A,200,100,30,100,0
    GYROSENSE G6D,200,100,30,100,0
    RETURN
    '***********************************************
자이로ON:


    GYROSET G6A, 4, 3, 3, 3, 0
    GYROSET G6D, 4, 3, 3, 3, 0


    자이로ONOFF = 1

    RETURN
    '***********************************************
자이로OFF:

    GYROSET G6A, 0, 0, 0, 0, 0
    GYROSET G6D, 0, 0, 0, 0, 0


    자이로ONOFF = 0
    RETURN

    '************************************************
전원초기자세:
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  35,  90,
    MOVE G6C,100,  35,  90
    WAIT
    mode = 0
    RETURN
    '************************************************
안정화자세:
    MOVE G6A,98,  76, 145,  93, 101, 100
    MOVE G6D,98,  76, 145,  93, 101, 100
    MOVE G6B,100,  35,  90,
    MOVE G6C,100,  35,  90
    WAIT
    mode = 0

    RETURN
    '******************************************	


    '************************************************
기본자세:


    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80,
    MOVE G6C,100,  30,  80,
    WAIT
    mode = 0

    RETURN
    '******************************************	
문기본자세:

	SPEED 9
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80,
    WAIT
    mode = 0

    RETURN
    '******************************************	
기본자세2:
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80,
    MOVE G6C,100,  30,  80
    WAIT

    mode = 0
    RETURN
    '******************************************	
차렷자세:
    MOVE G6A,100, 56, 182, 76, 100, 100
    MOVE G6D,100, 56, 182, 76, 100, 100
    MOVE G6B,100,  30,  80,
    MOVE G6C,100,  30,  80
    WAIT
    mode = 2
    RETURN
    '******************************************
앉은자세:
    GOSUB 자이로OFF
    MOVE G6A,100, 145,  28, 145, 100, 100
    MOVE G6D,100, 145,  28, 145, 100, 100
    MOVE G6B,100,  30,  80,
    MOVE G6C,100,  30,  80
    WAIT
    mode = 1

    RETURN
    '******************************************


    '******************************************
    '**********************************************
    '**********************************************
RX_EXIT:

    ERX 4800, A, MAIN

    GOTO RX_EXIT
    '**********************************************
GOSUB_RX_EXIT:

    ERX 4800, A, GOSUB_RX_EXIT2

    GOTO GOSUB_RX_EXIT

GOSUB_RX_EXIT2:
    RETURN
    '**********************************************
계단내려가기승환:
	GOSUB Leg_motor_mode3
	SPEED 4
    MOVE G6D, 88,  74, 144,  95, 110
    MOVE G6A,108,  76, 146,  93,  96
    MOVE G6B,100,40
    MOVE G6C,100,50
    WAIT
    
    SPEED 15
    MOVE G6C,100,70
    MOVE G6D,114,83,146 , 85,103
    MOVE G6A, 85, 100, 100, 100, 115 ' MOVE G6A, 90, 100, 110, 100, 114   
    WAIT

    SPEED 3
    MOVE G6D,116,83,155,57,95
    MOVE G6A,85,40,120,170,115
    MOVE G6B,40,100
    MOVE G6C,50,45
    
    SPEED 5
    MOVE G6A,95,50,120,165,110
    MOVE G6D,114,78,170,45,92
    MOVE G6B,100,70
    MOVE G6C,40,20
    WAIT
    
    SPEED 5
    MOVE G6A,105,50,120,145,95 ' 105,50,120,145,95
    MOVE G6D,114,78,170,25,92
    WAIT
    
    SPEED 3
    MOVE G6A,95,55,120,120,110
    MOVE G6D,114,95,170,20,92
    WAIT
    
    SPEED 10
    MOVE G6D, ,110
    WAIT
    
    'GOSUB 계단오른쪽턴
    WAIT
    
    GOTO RX_EXIT
    '**********************************************
코너인식3:
	GOSUB 가뿌자 
	WAIT
	GOSUB 왼쪽턴60
	WAIT
	GOSUB 전진달리기fast
	WAIT
	GOSUB 전진달리기fast
	WAIT
	
	GOSUB 기본자세
	WAIT
	
	RETURN
    '**********************************************
코너인식2:
	GOSUB 왼쪽턴45
	WAIT
	GOSUB 전진달리기fast
	WAIT
	GOSUB 전진달리기fast
	WAIT
	GOSUB 전진달리기fast
	WAIT
	GOSUB 왼쪽턴45
	WAIT
	
	GOSUB 기본자세
	WAIT
	
	RETURN
    '**********************************************
계단한걸음전진:
	보행COUNT = 0
    보행속도 = 13
    좌우속도 = 4
    넘어진확인 = 0
    
    GOSUB Leg_motor_mode3
	SPEED 4

    MOVE G6A, 88,  74, 144,  95, 110
    MOVE G6D,108,  76, 146,  93,  96
    MOVE G6B,100
    MOVE G6C,100
    WAIT

    SPEED 10

    MOVE G6A, 90, 90, 120, 105, 110,100
    MOVE G6D,110,  76, 147,  93,  96,100
    MOVE G6B,90
    MOVE G6C,110
    WAIT
    
    SPEED 보행속도

    MOVE G6A, 86,  56, 145, 115, 110
    MOVE G6D,108,  76, 147,  93,  96
    WAIT


    SPEED 좌우속도
    GOSUB Leg_motor_mode3

    MOVE G6A,110,  76, 147, 93,  96
    MOVE G6D,86, 100, 145,  69, 110
    WAIT
    
    SPEED 보행속도

    GOSUB 앞뒤기울기측정
    IF 넘어진확인 = 1 THEN
        넘어진확인 = 0
    ENDIF
    
    
    MOVE G6A,110,  76, 147,  93, 96,100
    MOVE G6D,90, 90, 120, 105, 110,100
    MOVE G6B,110
    MOVE G6C,90
    WAIT
    
    SPEED 3
    GOSUB 기본자세
    
    RETURN
    '**********************************************
한걸음전진:
	보행COUNT = 0
    보행속도 = 13
    좌우속도 = 4
    넘어진확인 = 0
	
	GOSUB Leg_motor_mode3
    
    SPEED 4

    MOVE G6A, 88,  74, 144,  95, 110
    MOVE G6D,108,  76, 146,  93,  96
    MOVE G6B,100
    MOVE G6C,100
    WAIT

    SPEED 10'

    MOVE G6A, 90, 90, 120, 105, 110,100
    MOVE G6D,110,  76, 147,  96,  96,100
    MOVE G6B,90
    MOVE G6C,110
    WAIT
    
    SPEED 보행속도

    MOVE G6A, 86,  56, 145, 115, 110
    MOVE G6D,108,  76, 147,  96,  96
    WAIT


    SPEED 좌우속도
    GOSUB Leg_motor_mode3

    MOVE G6A,110,  76, 147, 93,  96
    MOVE G6D,86, 100, 145,  69, 110
    WAIT


    SPEED 보행속도

    GOSUB 앞뒤기울기측정
    IF 넘어진확인 = 1 THEN
        넘어진확인 = 0
        
    ENDIF
    
    SPEED 6

    MOVE G6D,  88,  74, 144,  95, 110
    MOVE G6A, 108,  76, 146,  93,  96
    MOVE G6C, 100
    MOVE G6B, 100
    WAIT
	    
	SPEED 2
	GOSUB 기본자세 
	
	RETURN 
	'*************************************

양발전진:										' 한걸음만 전진하도록! 
	보행COUNT = 0
    보행속도 = 13
    좌우속도 = 4
    넘어진확인 = 0

    GOSUB Leg_motor_mode3

    IF 보행순서 = 0 THEN
        보행순서 = 1

        SPEED 4

        MOVE G6A, 88,  74, 144,  95, 110
        MOVE G6D,108,  76, 146,  93,  96
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        SPEED 10'

        MOVE G6A, 90, 90, 120, 105, 110,100
        MOVE G6D,110,  76, 147,  93,  96,100
        MOVE G6B,90
        MOVE G6C,110
        WAIT


        GOTO 연속전진_1	
    ELSE
        보행순서 = 0

        SPEED 4

        MOVE G6D,  88,  74, 144,  95, 110
        MOVE G6A, 108,  76, 146,  93,  96
        MOVE G6C, 100
        MOVE G6B, 100
        WAIT

        SPEED 10

        MOVE G6D, 90, 90, 120, 105, 110,100
        MOVE G6A,110,  76, 147,  93,  96,100
        MOVE G6C,90
        MOVE G6B,110
        WAIT


        GOTO 연속전진_2	

    ENDIF


    '*******************************


연속전진_1:

    'ETX 4800,11 '진행코드를 보냄
    SPEED 보행속도

    MOVE G6A, 86,  56, 145, 115, 110
    MOVE G6D,108,  76, 147,  93,  96
    WAIT


    SPEED 좌우속도
    GOSUB Leg_motor_mode3

    MOVE G6A,110,  76, 147, 93,  96
    MOVE G6D,86, 100, 145,  69, 110
    WAIT


    SPEED 보행속도

    GOSUB 앞뒤기울기측정
    IF 넘어진확인 = 1 THEN
        넘어진확인 = 0
        
    ENDIF

    ERX 4800,A, 연속전진_2
    IF A = 10 THEN
        GOTO 연속전진_2
    ELSE
        ' GOSUB Leg_motor_mode3

        MOVE G6A,112,  76, 146,  93, 96,100
        MOVE G6D,90, 100, 100, 115, 110,100
        MOVE G6B,110
        MOVE G6C,90
        WAIT
        HIGHSPEED SETOFF

        SPEED 8
        MOVE G6A, 106,  76, 146,  93,  96,100		
        MOVE G6D,  88,  71, 152,  91, 106,100
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT	

        SPEED 2
        GOSUB 기본자세2

        GOTO RX_EXIT
    ENDIF
    '**********

연속전진_2:

    MOVE G6A,110,  76, 147,  93, 96
    MOVE G6D,90, 90, 120, 105, 110
    MOVE G6B,110
    MOVE G6C,90
    WAIT

연속전진_3:
    'ETX 4800,11 '진행코드를 보냄

    SPEED 보행속도

    MOVE G6D, 86,  56, 145, 115, 110
    MOVE G6A,108,  76, 147,  93,  96
    WAIT

    SPEED 좌우속도
    MOVE G6D,110,  76, 147, 93,  96
    MOVE G6A,86, 100, 145,  69, 110
    WAIT

    SPEED 보행속도

    GOSUB 앞뒤기울기측정
    IF 넘어진확인 = 1 THEN
        넘어진확인 = 0
        
    ENDIF

    ERX 4800,A, 연속전진_4
    IF A = 11 THEN
        GOTO 연속전진_4
    ELSE

        MOVE G6A, 90, 100, 100, 115, 110,100
        MOVE G6D,112,  76, 146,  93,  96,100
        MOVE G6B,90
        MOVE G6C,110
        WAIT
        HIGHSPEED SETOFF
        SPEED 8

        MOVE G6D, 106,  76, 146,  93,  96,100		
        MOVE G6A,  88,  71, 152,  91, 106,100
        MOVE G6C, 100
        MOVE G6B, 100
        WAIT	
        SPEED 2
        GOSUB 기본자세2

        GOTO RX_EXIT
    ENDIF

연속전진_4:
    '왼발들기10
    MOVE G6A,90, 90, 120, 105, 110,100
    MOVE G6D,110,  76, 146,  93,  96,100
    MOVE G6B, 90
    MOVE G6C,110
    WAIT

    GOTO 연속전진_1
    '**********************************************
가뿌자:    
    보행COUNT = 0
    보행속도 = 12
    좌우속도 = 4
    넘어진확인 = 0
    GOSUB Leg_motor_mode3
    IF 발순서= 0 THEN
    	발순서= 1
	    SPEED 4
	
	    MOVE G6A, 88,  74, 144,  95, 110
	    MOVE G6D,108,  76, 146,  93,  96
	    MOVE G6B,100
	    MOVE G6C,100
	    WAIT
	
	    SPEED 10
	
	    MOVE G6A, 90, 90, 120, 105, 110,100
	    MOVE G6D,107,  76, 147,  93,  96,100 ' 첫번째값 110
	    MOVE G6B,90
	    MOVE G6C,110
	    WAIT
	        
	    SPEED 보행속도
	
	    MOVE G6A, 86,  56, 145, 115, 110
	    MOVE G6D,108,  76, 147,  93,  96
	    WAIT
	
	
	    SPEED 좌우속도
	    GOSUB Leg_motor_mode3
	
	    MOVE G6A,107,  76, 147, 93,  96
	    MOVE G6D,86, 100, 145,  69, 110
	    WAIT
	
	
	    SPEED 보행속도
	
	    GOSUB 앞뒤기울기측정
	    
	    MOVE G6A,110,  76, 147,  93, 96,100
	    MOVE G6D,90, 90, 120, 105, 110,100
	    MOVE G6B,110
	    MOVE G6C,90
	    WAIT
	    
	    SPEED 보행속도
	
	    MOVE G6D, 86,  56, 145, 115, 110
	    MOVE G6A,108,  76, 147,  93,  96
	    WAIT
	
	    SPEED 좌우속도
	    MOVE G6D,110,  76, 147, 93,  96
	    MOVE G6A,86, 100, 145,  69, 110
	    WAIT
	
	    SPEED 보행속도
	
	    GOSUB 앞뒤기울기측정
	    
	    MOVE G6A,90, 90, 120, 105, 110,100
	    MOVE G6D,110,  76, 146,  93,  96,100
	    MOVE G6B, 90
	    MOVE G6C,110
	    WAIT 
    ELSEIF 발순서=1 THEN
    	발순서=0
    	SPEED 4
	
	    MOVE G6D, 88,  77, 144,  100, 110
	    MOVE G6A,108,  76, 146,  93,  96
	    MOVE G6C,100
	    MOVE G6B,100
	    WAIT
	
	    SPEED 10
	
	    MOVE G6D, 90, 90, 120, 105, 110,100
	    MOVE G6A,107,  76, 147,  93,  96,100 ' 첫번째값 110
	    MOVE G6C,90
	    MOVE G6B,110
	    WAIT
	        
	    SPEED 보행속도
	
	    MOVE G6D, 86,  56, 145, 115, 110
	    MOVE G6A,108,  76, 147,  93,  96
	    WAIT
	
	
	    SPEED 좌우속도
	    GOSUB Leg_motor_mode3
	
	    MOVE G6D,107,  76, 147, 93,  96
	    MOVE G6A,86, 100, 145,  69, 110
	    WAIT
	
	
	    SPEED 보행속도
	
	    GOSUB 앞뒤기울기측정
	    
	    MOVE G6D,110,  76, 147,  93, 96,100
	    MOVE G6A,90, 90, 120, 105, 110,100
	    MOVE G6C,110
	    MOVE G6B,90
	    WAIT
	    
	    SPEED 보행속도
	
	    MOVE G6A, 86,  56, 145, 115, 110
	    MOVE G6D,108,  76, 147,  93,  96
	    WAIT
	
	    SPEED 좌우속도
	    MOVE G6A,110,  76, 147, 93,  96
	    MOVE G6D,86, 100, 145,  69, 110
	    WAIT
	
	    SPEED 보행속도
	
	    GOSUB 앞뒤기울기측정
	    
	    MOVE G6D,90, 90, 120, 105, 110,100
	    MOVE G6A,110,  76, 146,  93,  96,100
	    MOVE G6C, 90
	    MOVE G6B,110
	    WAIT 
	ENDIF
    SPEED 3
    GOSUB 기본자세
    RETURN
    '**********************************************

    '*******************************
문연속전진:
    보행COUNT = 0
    보행속도 = 13
    좌우속도 = 4
    넘어진확인 = 0

    GOSUB Leg_motor_mode3

    IF 보행순서 = 0 THEN
        보행순서 = 1

        SPEED 6

        MOVE G6A, 88,  74, 144,  95, 110
        MOVE G6D,108,  76, 146,  93,  96
        WAIT

        SPEED 10'

        MOVE G6A, 90, 90, 120, 105, 110,100
        MOVE G6D,110,  76, 147,  93,  96,100
        WAIT


        GOTO 문연속전진_1	
    ELSE
        보행순서 = 0

        SPEED 6

        MOVE G6D,  88,  74, 144,  95, 110
        MOVE G6A, 108,  76, 146,  93,  96
        WAIT

        SPEED 10

        MOVE G6D, 90, 90, 120, 105, 110,100
        MOVE G6A,110,  76, 147,  93,  96,100
        WAIT


        GOTO 문연속전진_2	

    ENDIF


    '*******************************


문연속전진_1:

    'ETX 4800,11 '진행코드를 보냄
    SPEED 보행속도

    MOVE G6A, 86,  56, 145, 115, 110
    MOVE G6D,108,  76, 147,  93,  96
    WAIT


    SPEED 좌우속도
    GOSUB Leg_motor_mode3

    MOVE G6A,110,  76, 147, 93,  96
    MOVE G6D,86, 100, 145,  69, 110
    WAIT


    SPEED 보행속도

    GOSUB 앞뒤기울기측정
    IF 넘어진확인 = 1 THEN
        넘어진확인 = 0
        
    ENDIF

    ERX 4800,A, 문연속전진_2
    IF A = 11 THEN
        GOTO 문연속전진_2
    ELSE
        ' GOSUB Leg_motor_mode3

        MOVE G6A,112,  76, 146,  93, 96,100
        MOVE G6D,90, 100, 100, 115, 110,100
        WAIT
        HIGHSPEED SETOFF

        SPEED 8
        MOVE G6A, 106,  76, 146,  93,  96,100		
        MOVE G6D,  88,  71, 152,  91, 106,100
        WAIT	

        SPEED 2
        GOSUB 기본자세2

        GOTO RX_EXIT
    ENDIF
    '**********

문연속전진_2:

    MOVE G6A,110,  76, 147,  93, 96,100
    MOVE G6D,90, 90, 120, 105, 110,100
    WAIT

문연속전진_3:
    'ETX 4800,11 '진행코드를 보냄

    SPEED 보행속도

    MOVE G6D, 86,  56, 145, 115, 110
    MOVE G6A,108,  76, 147,  93,  96
    WAIT

    SPEED 좌우속도
    MOVE G6D,110,  76, 147, 93,  96
    MOVE G6A,86, 100, 145,  69, 110
    WAIT

    SPEED 보행속도

    GOSUB 앞뒤기울기측정
    IF 넘어진확인 = 1 THEN
        넘어진확인 = 0
        
    ENDIF

    ERX 4800,A, 문연속전진_4
    IF A = 11 THEN
        GOTO 문연속전진_4
    ELSE

        MOVE G6A, 90, 100, 100, 115, 110,100
        MOVE G6D,112,  76, 146,  93,  96,100
        WAIT
        HIGHSPEED SETOFF
        SPEED 8

        MOVE G6D, 106,  76, 146,  93,  96,100		
        MOVE G6A,  88,  71, 152,  91, 106,100
        WAIT	
        SPEED 2
        GOSUB 기본자세2

        GOTO RX_EXIT
    ENDIF

문연속전진_4:
    '왼발들기10
    MOVE G6A,90, 90, 120, 105, 110,100
    MOVE G6D,110,  76, 146,  93,  96,100
    WAIT

    RETURN
    '*******************************
한번후진:
	넘어진확인 = 0
    보행속도 = 12
    좌우속도 = 4
    GOSUB Leg_motor_mode3
    
    SPEED 4
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,108,  76, 145,  93,  96
    MOVE G6B,100
    MOVE G6C,100
    WAIT

    SPEED 12
    MOVE G6A, 90, 100, 100, 115, 110
    MOVE G6D,110,  76, 145,  93,  96
    MOVE G6B,90
    MOVE G6C,110
    WAIT
    
    SPEED 보행속도

    MOVE G6D,110,  76, 145, 93,  96
    MOVE G6A,90, 98, 145,  69, 110
    WAIT

    SPEED 좌우속도
    MOVE G6D, 90,  60, 137, 120, 110
    MOVE G6A,107,  85, 137,  93,  96
    WAIT


    GOSUB 앞뒤기울기측정
    IF 넘어진확인 = 1 THEN
        넘어진확인 = 0
        
    ENDIF
    
    SPEED 11

    MOVE G6D,90, 90, 120, 105, 110
    MOVE G6A,112,  76, 146,  93, 96
    MOVE G6B,110
    MOVE G6C,90
    WAIT
    
    SPEED 5

    MOVE G6A, 106,  76, 145,  93,  96		
    MOVE G6D,  85,  72, 148,  91, 106
    MOVE G6B, 100
    MOVE G6C, 100
    WAIT	

    SPEED 7
    GOSUB 기본자세
    RETURN
    '************************************************
연속후진:
    넘어진확인 = 0
    보행속도 = 12
    좌우속도 = 4
    GOSUB Leg_motor_mode3



    IF 보행순서 = 0 THEN
        보행순서 = 1

        SPEED 4
        MOVE G6A, 88,  71, 152,  91, 110
        MOVE G6D,108,  76, 145,  93,  96
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        SPEED 10
        MOVE G6A, 90, 100, 100, 115, 110
        MOVE G6D,110,  76, 145,  93,  96
        MOVE G6B,90
        MOVE G6C,110
        WAIT

        GOTO 연속후진_1	
    ELSE
        보행순서 = 0

        SPEED 4
        MOVE G6D,  88,  71, 152,  91, 110
        MOVE G6A, 108,  76, 145,  93,  96
        MOVE G6C, 100
        MOVE G6B, 100
        WAIT

        SPEED 10
        MOVE G6D, 90, 100, 100, 115, 110
        MOVE G6A,110,  76, 145,  93,  96
        MOVE G6C,90
        MOVE G6B,110
        WAIT


        GOTO 연속후진_2

    ENDIF


연속후진_1:
    ETX 4800,12 '진행코드를 보냄
    SPEED 보행속도

    MOVE G6D,110,  76, 145, 93,  96
    MOVE G6A,90, 98, 145,  69, 110
    WAIT

    SPEED 좌우속도
    MOVE G6D, 90,  60, 137, 120, 110
    MOVE G6A,107,  85, 137,  93,  96
    WAIT


    GOSUB 앞뒤기울기측정
    IF 넘어진확인 = 1 THEN
        넘어진확인 = 0
        
    ENDIF


    SPEED 11

    MOVE G6D,90, 90, 120, 105, 110
    MOVE G6A,112,  76, 146,  93, 96
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    ERX 4800,A, 연속후진_2
    IF A <> A_old THEN
연속후진_1_EXIT:
        HIGHSPEED SETOFF
        SPEED 5

        MOVE G6A, 106,  76, 145,  93,  96		
        MOVE G6D,  85,  72, 148,  91, 106
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT	

        SPEED 3
        GOSUB 기본자세2
        GOTO RX_EXIT
    ENDIF
    '**********

연속후진_2:
    ETX 4800,12 '진행코드를 보냄
    SPEED 보행속도
    MOVE G6A,110,  76, 145, 93,  96
    MOVE G6D,90, 98, 145,  69, 110
    WAIT


    SPEED 좌우속도
    MOVE G6A, 90,  60, 137, 120, 110
    MOVE G6D,107  85, 137,  93,  96
    WAIT


    GOSUB 앞뒤기울기측정
    IF 넘어진확인 = 1 THEN
        넘어진확인 = 0
        
    ENDIF


    SPEED 11
    MOVE G6A,90, 90, 120, 105, 110
    MOVE G6D,112,  76, 146,  93,  96
    MOVE G6B, 90
    MOVE G6C,110
    WAIT


    ERX 4800,A, 연속후진_1
    IF A <> A_old THEN
연속후진_2_EXIT:
        HIGHSPEED SETOFF
        SPEED 5

        MOVE G6D, 106,  76, 145,  93,  96		
        MOVE G6A,  85,  72, 148,  91, 106
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT	

        SPEED 3
        GOSUB 기본자세2
        GOTO RX_EXIT
    ENDIF  	

    GOTO 연속후진_1
    '**********************************************

    '******************************************
횟수_전진종종걸음:
    GOSUB All_motor_mode3
    보행COUNT = 0
    SPEED 11
    HIGHSPEED SETON


    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO 횟수_전진종종걸음_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO 횟수_전진종종걸음_4
    ENDIF


    '**********************

횟수_전진종종걸음_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
    MOVE G6B, 85
    MOVE G6C,115
    WAIT


횟수_전진종종걸음_2:

    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어진확인 = 1 THEN
        넘어진확인 = 0
		RETURN
    ENDIF

    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 횟수_전진종종걸음_2_stop

    ERX 4800,A, 횟수_전진종종걸음_4
    IF A <> A_old THEN
횟수_전진종종걸음_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6C, 100
        MOVE G6B,100
        WAIT
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        SPEED 5
        GOSUB 기본자세2

        'DELAY 400
        RETURN
    ENDIF

    '*********************************

횟수_전진종종걸음_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT


횟수_전진종종걸음_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT


    GOSUB 앞뒤기울기측정
    IF 넘어진확인 = 1 THEN
        넘어진확인 = 0
        RETURN
    ENDIF

    보행COUNT = 보행COUNT + 1
    IF 보행COUNT > 보행횟수 THEN  GOTO 횟수_전진종종걸음_5_stop

    ERX 4800,A, 횟수_전진종종걸음_1
    IF A <> A_old THEN
횟수_전진종종걸음_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        SPEED 5
        GOSUB 기본자세2

        'DELAY 400
        RETURN
    ENDIF

    '*************************************

    '*********************************

    GOTO 횟수_전진종종걸음_1

    '******************************************

    '******************************************
전진종종걸음:
    GOSUB All_motor_mode3
    보행COUNT = 0
    SPEED 7
    HIGHSPEED SETON


    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        'MOVE G6B,100
        'MOVE G6C,100
        WAIT

        GOTO 전진종종걸음_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        'MOVE G6B,100
        'MOVE G6C,100
        WAIT

        GOTO 전진종종걸음_4
    ENDIF


    '**********************

전진종종걸음_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
    'MOVE G6B, 85
    'MOVE G6C,115
    WAIT


전진종종걸음_2:

    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어진확인 = 1 THEN
        넘어진확인 = 0

        GOTO RX_EXIT
    ENDIF

    ' 보행COUNT = 보행COUNT + 1
    'IF 보행COUNT > 보행횟수 THEN  GOTO 전진종종걸음_2_stop

    ERX 4800,A, 전진종종걸음_4
    IF A <> A_old THEN
전진종종걸음_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        'MOVE G6C, 100
        'MOVE G6B,100
        WAIT
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        SPEED 5
        GOSUB 기본자세2

        'DELAY 400
        GOTO RX_EXIT
    ENDIF

    '*********************************

전진종종걸음_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    'MOVE G6C, 85
    'MOVE G6B,115
    WAIT


전진종종걸음_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT


    GOSUB 앞뒤기울기측정
    IF 넘어진확인 = 1 THEN
        넘어진확인 = 0
        GOTO RX_EXIT
    ENDIF

    ' 보행COUNT = 보행COUNT + 1
    ' IF 보행COUNT > 보행횟수 THEN  GOTO 전진종종걸음_5_stop

    ERX 4800,A, 전진종종걸음_1
    IF A <> A_old THEN
전진종종걸음_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        'MOVE G6B, 100
        'MOVE G6C,100
        WAIT
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB 안정화자세
        SPEED 5
        GOSUB 기본자세2

        'DELAY 400
        GOTO RX_EXIT
    ENDIF

    '*************************************

    '*********************************

    GOTO 전진종종걸음_1

    '******************************************
    '******************************************
    '******************************************

후진종종걸음:
    GOSUB All_motor_mode3
    넘어진확인 = 0
    보행COUNT = 0
    SPEED 7
    HIGHSPEED SETON


    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  76, 145,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO 후진종종걸음_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  76, 145,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO 후진종종걸음_4
    ENDIF


    '**********************

후진종종걸음_1:
    MOVE G6D,104,  76, 147,  93,  102
    MOVE G6A,95,  95, 120, 95, 104
    MOVE G6B,115
    MOVE G6C,85
    WAIT



후진종종걸음_3:
    MOVE G6A, 103,  79, 147,  89, 100
    MOVE G6D,95,   65, 147, 103,  102
    WAIT

    GOSUB 앞뒤기울기측정
    IF 넘어진확인 = 1 THEN
        넘어진확인 = 0
        GOTO RX_EXIT
    ENDIF
    ' 보행COUNT = 보행COUNT + 1
    ' IF 보행COUNT > 보행횟수 THEN  GOTO 후진종종걸음_3_stop
    ERX 4800,A, 후진종종걸음_4
    IF A <> A_old THEN
후진종종걸음_3_stop:
        MOVE G6D,95,  85, 130, 100, 104
        MOVE G6A,104,  77, 146,  93,  102
        MOVE G6C, 100
        MOVE G6B,100
        WAIT

        'SPEED 15
        GOSUB 안정화자세
        HIGHSPEED SETOFF
        SPEED 5
        GOSUB 기본자세2

        'DELAY 400
        GOTO RX_EXIT
    ENDIF
    '*********************************

후진종종걸음_4:
    MOVE G6A,104,  76, 147,  93,  102
    MOVE G6D,95,  95, 120, 95, 104
    MOVE G6C,115
    MOVE G6B,85
    WAIT


후진종종걸음_6:
    MOVE G6D, 103,  79, 147,  89, 100
    MOVE G6A,95,   65, 147, 103,  102
    WAIT
    GOSUB 앞뒤기울기측정
    IF 넘어진확인 = 1 THEN
        넘어진확인 = 0
        GOTO RX_EXIT
    ENDIF

    ' 보행COUNT = 보행COUNT + 1
    'IF 보행COUNT > 보행횟수 THEN  GOTO 후진종종걸음_6_stop

    ERX 4800,A, 후진종종걸음_1
    IF A <> A_old THEN  'GOTO 후진종종걸음_멈춤
후진종종걸음_6_stop:
        MOVE G6A,95,  85, 130, 100, 104
        MOVE G6D,104,  77, 146,  93,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT

        'SPEED 15
        GOSUB 안정화자세
        HIGHSPEED SETOFF
        SPEED 5
        GOSUB 기본자세2

        'DELAY 400
        GOTO RX_EXIT
    ENDIF

    GOTO 후진종종걸음_1




    '******************************************

    '******************************************
전진달리기slow:
    넘어진확인 = 0
    GOSUB All_motor_mode3
    보행COUNT = 0
    SPEED 9
    
	HIGHSPEED SETON
	
	IF 슬로우발순서 = 0 THEN
		슬로우발순서= 1
    	MOVE G6A,95,  76, 145,  93, 101
    	MOVE G6D,101,  77, 145,  93, 98
    	WAIT

    	MOVE G6A,95,  80, 120, 120, 104
    	MOVE G6D,104,  77, 146,  93,  102
    	MOVE G6B, 80
    	MOVE G6C,120
    	WAIT

		MOVE G6A,95,  75, 122, 120, 104
    	MOVE G6D,104,  78, 147,  94,  100
    	WAIT
    
    	MOVE G6A,103,  69, 145, 103,  100
    	MOVE G6D, 95, 87, 160,  68, 102
    	WAIT
    
    	'MOVE G6D,95,  95, 100, 120, 104
    	MOVE G6D,95,  75, 122, 120, 104
    	MOVE G6A,104,  77, 147,  93,  102
    	MOVE G6C, 80
    	MOVE G6B,120
    	WAIT
    

    	MOVE G6D,95,  75, 122, 120, 104
    	MOVE G6A,104,  78, 147,  93,  100
    	WAIT

    	MOVE G6D,103,  69, 145, 103,  100
    	MOVE G6A, 95, 87, 160,  68, 102
    	WAIT
    
    	MOVE G6A,90,  93, 115, 100, 104
    	MOVE G6D,104,  74, 145,  92,  102
    	MOVE G6B, 100
    	MOVE G6C,100
    	WAIT
        
    ELSEIF 슬로우발순서 = 1 THEN
    	슬로우발순서= 0
    	MOVE G6D,95,  76, 145,  93, 101
    	MOVE G6A,101,  77, 145,  93, 98
    	WAIT

    	MOVE G6D,95,  80, 120, 120, 104
    	MOVE G6A,104,  77, 146,  93,  102
    	MOVE G6C, 80
    	MOVE G6B,120
    	WAIT

		MOVE G6D,95,  75, 122, 120, 104
    	MOVE G6A,104,  78, 147,  94,  100
    	WAIT
    
    	MOVE G6D,103,  69, 145, 103,  100
    	MOVE G6A, 95, 87, 160,  68, 102
    	WAIT
    
    	'MOVE G6D,95,  95, 100, 120, 104
    	MOVE G6A,95,  75, 122, 120, 104
    	MOVE G6D,104,  77, 147,  93,  102
    	MOVE G6B, 80
    	MOVE G6C,120
    	WAIT
    

    	MOVE G6A,95,  75, 122, 120, 104
    	MOVE G6D,104,  78, 147,  93,  100
    	WAIT

    	MOVE G6A,103,  69, 145, 103,  100
    	MOVE G6D, 95, 87, 160,  68, 102
    	WAIT
    
    	MOVE G6D,90,  93, 115, 100, 104
    	MOVE G6A,104,  74, 145,  92,  102
    	MOVE G6C, 100
    	MOVE G6B,100
    	WAIT
    ENDIF
    HIGHSPEED SETOFF
    SPEED 8
    GOSUB 기본자세
	WAIT
	
    RETURN
    '******************************************
전진달리기fast:
    넘어진확인 = 0
    GOSUB All_motor_mode3
    보행COUNT = 0
    SPEED 12
    
	HIGHSPEED SETON
	
	IF 패스트발순서 = 0 THEN
		패스트발순서= 1
    	MOVE G6A,95,  76, 145,  93, 101
    	MOVE G6D,101,  77, 145,  93, 98
    	WAIT

    	MOVE G6A,95,  80, 120, 120, 104
    	MOVE G6D,104,  77, 146,  93,  102
    	MOVE G6B, 80
    	MOVE G6C,120
    	WAIT

		MOVE G6A,95,  75, 122, 120, 104
    	MOVE G6D,104,  78, 147,  94,  100
    	WAIT
    
    	MOVE G6A,103,  69, 145, 103,  100
    	MOVE G6D, 95, 87, 160,  68, 102
    	WAIT
    
    	'MOVE G6D,95,  95, 100, 120, 104
    	MOVE G6D,95,  75, 122, 120, 104
    	MOVE G6A,104,  77, 147,  93,  102
    	MOVE G6C, 80
    	MOVE G6B,120
    	WAIT
    

    	MOVE G6D,95,  75, 122, 120, 104
    	MOVE G6A,104,  78, 147,  93,  100
    	WAIT

    	MOVE G6D,103,  69, 145, 103,  100
    	MOVE G6A, 95, 87, 160,  68, 102
    	WAIT
    
    	MOVE G6A,90,  93, 115, 100, 104
    	MOVE G6D,104,  74, 145,  92,  102
    	MOVE G6B, 100
    	MOVE G6C,100
    	WAIT
        
    ELSEIF 패스트발순서 = 1 THEN
    	패스트발순서= 0
    	MOVE G6D,95,  76, 145,  93, 101
    	MOVE G6A,101,  77, 145,  93, 98
    	WAIT

    	MOVE G6D,95,  80, 120, 120, 104
    	MOVE G6A,104,  77, 146,  93,  102
    	MOVE G6C, 80
    	MOVE G6B,120
    	WAIT

		MOVE G6D,95,  75, 122, 120, 104
    	MOVE G6A,104,  78, 147,  94,  100
    	WAIT
    
    	MOVE G6D,103,  69, 145, 103,  100
    	MOVE G6A, 95, 87, 160,  68, 102
    	WAIT
    
    	'MOVE G6D,95,  95, 100, 120, 104
    	MOVE G6A,95,  75, 122, 120, 104
    	MOVE G6D,104,  77, 147,  93,  102
    	MOVE G6B, 80
    	MOVE G6C,120
    	WAIT
    

    	MOVE G6A,95,  75, 122, 120, 104
    	MOVE G6D,104,  78, 147,  93,  100
    	WAIT

    	MOVE G6A,103,  69, 145, 103,  100
    	MOVE G6D, 95, 87, 160,  68, 102
    	WAIT
    
    	MOVE G6D,90,  93, 115, 100, 104
    	MOVE G6A,104,  74, 145,  92,  102
    	MOVE G6C, 100
    	MOVE G6B,100
    	WAIT
    ENDIF
    HIGHSPEED SETOFF
    SPEED 8
    GOSUB 기본자세
	WAIT
	
    RETURN
    '******************************************



    '************************************************
오른쪽옆으로20: '****
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2

    SPEED 12
    MOVE G6D, 95,  90, 125, 100, 104, 100
    MOVE G6A,105,  76, 146,  93, 104, 100
    WAIT
    
    SPEED 12
    MOVE G6D, 102,  77, 145, 93, 100, 100
    MOVE G6A,90,  80, 140,  95, 107, 100
    WAIT

    SPEED 10
    MOVE G6D,95,  76, 145,  93, 102, 100
    MOVE G6A,95,  76, 145,  93, 102, 100
    WAIT

    SPEED 8
    GOSUB 기본자세
    GOSUB All_motor_mode3
    
    RETURN
    '*************


왼쪽옆으로20: '****
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2

    SPEED 12
    MOVE G6A, 95,  90, 125, 100, 104, 100
    MOVE G6D,105,  76, 145,  93, 104, 100
    WAIT

    SPEED 12
    MOVE G6A, 102,  77, 145, 93, 100, 100
    MOVE G6D,90,  80, 140,  95, 107, 100
    WAIT

    SPEED 10
    MOVE G6A,95,  76, 145,  93, 102, 100
    MOVE G6D,95,  76, 145,  93, 102, 100
    WAIT

    SPEED 8
    GOSUB 기본자세
    GOSUB All_motor_mode3
    
    
    RETURN

    '**********************************************
왼쪽옆으로4_20: '****
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2

    SPEED 12
    MOVE G6A, 95,  90, 125, 100, 104, 100
    MOVE G6D,105,  76, 145,  93, 104, 100
    WAIT

    SPEED 12
    MOVE G6A, 102,  77, 145, 93, 100, 100
    MOVE G6D,90,  80, 140,  95, 107, 100
    WAIT

    SPEED 10
    MOVE G6A,95,  76, 145,  93, 102, 100
    MOVE G6D,95,  76, 145,  93, 102, 100
    WAIT

    SPEED 8
    GOSUB 기본자세
    GOSUB All_motor_mode3
    
    ETX 4800, 247
    GOTO RX_EXIT

    '**********************************************
왼쪽옆으로20계단: '****
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2

    SPEED 12
    MOVE G6A, 95,  90, 125, 100, 104, 100
    MOVE G6D,105,  76, 145,  93, 104, 100
    WAIT

    SPEED 12
    MOVE G6A, 102,  77, 145, 93, 100, 100
    MOVE G6D,90,  80, 140,  95, 107, 100
    WAIT

    SPEED 10
    MOVE G6A,95,  76, 145,  93, 102, 100
    MOVE G6D,95,  76, 145,  93, 102, 100
    WAIT

    SPEED 8
    GOSUB 기본자세
    GOSUB All_motor_mode3
    RETURN 
    'GOTO RX_EXIT
    '******************************************
오른쪽옆으로70:
	
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2

    DELAY  10

    SPEED 10
    MOVE G6D, 90,  90, 120, 105, 110, 100
    MOVE G6A,100,  76, 145,  93, 107, 100
    'MOVE G6C,100,  40
    'MOVE G6B,100,  40
    WAIT

    SPEED 13
    MOVE G6D, 102,  76, 145, 93, 100, 100
    MOVE G6A,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 13
    MOVE G6D,98,  76, 145,  93, 100, 100
    MOVE G6A,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 12
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT


    '  ERX 4800, A ,오른쪽옆으로70연속_loop
    '    IF A = A_OLD THEN  GOTO 오른쪽옆으로70연속_loop
    '오른쪽옆으로70연속_stop:
    
    GOSUB 기본자세
	RETURN
    '**********************************************

왼쪽옆으로70:
	
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2

    DELAY  10

    SPEED 10
    MOVE G6A, 90,  90, 120, 105, 110, 100	
    MOVE G6D,100,  76, 145,  93, 107, 100	
    'MOVE G6C,100,  40
    'MOVE G6B,100,  40
    WAIT

    SPEED 13
    MOVE G6A, 102,  76, 145, 93, 100, 100
    MOVE G6D,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 13
    MOVE G6A,98,  76, 145,  93, 100, 100
    MOVE G6D,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 12
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6A,100,  76, 145,  93, 100, 100
    WAIT

    '   ERX 4800, A ,왼쪽옆으로70연속_loop	
    '    IF A = A_OLD THEN  GOTO 왼쪽옆으로70연속_loop
    '왼쪽옆으로70연속_stop:

    GOSUB 기본자세

    RETURN

    '**********************************************
    '************************************************
    '*********************************************

왼쪽턴3:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
왼쪽턴3_LOOP:

    IF 보행순서 = 0 THEN
        보행순서 = 1
        SPEED 15
        MOVE G6D,100,  73, 145,  93, 100, 100
        MOVE G6A,100,  79, 145,  93, 100, 100
        WAIT

        SPEED 6
        MOVE G6D,100,  84, 145,  78, 100, 100
        MOVE G6A,100,  68, 145,  108, 100, 100
        WAIT

        SPEED 9
        MOVE G6D,90,  90, 145,  78, 102, 100
        MOVE G6A,104,  71, 145,  105, 100, 100
        WAIT
        SPEED 7
        MOVE G6D,90,  80, 130, 102, 104
        MOVE G6A,105,  76, 146,  93,  100
        WAIT



    ELSE
        보행순서 = 0
        SPEED 15
        MOVE G6D,100,  73, 145,  93, 100, 100
        MOVE G6A,100,  79, 145,  93, 100, 100
        WAIT


        SPEED 6
        MOVE G6D,100,  88, 145,  78, 100, 100
        MOVE G6A,100,  65, 145,  108, 100, 100
        WAIT

        SPEED 9
        MOVE G6D,104,  86, 146,  80, 100, 100
        MOVE G6A,90,  58, 145,  110, 100, 100
        WAIT

        SPEED 7
        MOVE G6A,90,  85, 130, 98, 104
        MOVE G6D,105,  77, 146,  93,  100
        WAIT



    ENDIF

    SPEED 12
    GOSUB 기본자세


    GOTO RX_EXIT

    '**********************************************
오른쪽턴3:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2

오른쪽턴3_LOOP:

    IF 보행순서 = 0 THEN
        보행순서 = 1
        SPEED 15
        MOVE G6A,100,  73, 145,  93, 100, 100
        MOVE G6D,100,  79, 145,  93, 100, 100
        WAIT


        SPEED 6
        MOVE G6A,100,  84, 145,  78, 100, 100
        MOVE G6D,100,  68, 145,  108, 100, 100
        WAIT

        SPEED 9
        MOVE G6A,90,  90, 145,  78, 102, 100
        MOVE G6D,104,  71, 145,  105, 100, 100
        WAIT
        SPEED 7
        MOVE G6A,90,  80, 130, 102, 104
        MOVE G6D,105,  76, 146,  93,  100
        WAIT



    ELSE
        보행순서 = 0
        SPEED 15
        MOVE G6A,100,  73, 145,  93, 100, 100
        MOVE G6D,100,  79, 145,  93, 100, 100
        WAIT


        SPEED 6
        MOVE G6A,100,  88, 145,  78, 100, 100
        MOVE G6D,100,  65, 145,  108, 100, 100
        WAIT

        SPEED 9
        MOVE G6A,104,  86, 146,  80, 100, 100
        MOVE G6D,90,  58, 145,  110, 100, 100
        WAIT

        SPEED 7
        MOVE G6D,90,  85, 130, 98, 104
        MOVE G6A,105,  77, 146,  93,  100
        WAIT

    ENDIF
    SPEED 12
    GOSUB 기본자세2

    GOTO RX_EXIT

    '******************************************************
    '**********************************************
왼쪽턴10:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    SPEED 5
    MOVE G6A,97,  86, 145,  83, 103, 100
    MOVE G6D,97,  66, 145,  103, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  86, 145,  83, 101, 100
    MOVE G6D,94,  66, 145,  103, 101, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    WAIT

    GOSUB 기본자세2
    GOTO RX_EXIT
    '**********************************************
오른쪽턴10:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    SPEED 5
    MOVE G6A,97,  66, 145,  103, 103, 100
    MOVE G6D,97,  86, 145,  83, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  66, 145,  103, 101, 100
    MOVE G6D,94,  86, 145,  83, 101, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100
    WAIT

    GOSUB 기본자세2
	GOTO RX_EXIT
  
    '**********************************************
    '**********************************************
왼쪽턴20:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    SPEED 8
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100

    WAIT

    GOSUB 기본자세
    
	RETURN
    '**********************************************

    '**********************************************
오른쪽턴20:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    SPEED 8
    MOVE G6A,95,  56, 145,  113, 105, 100
    MOVE G6D,95,  96, 145,  73, 105, 100
    MOVE G6B,90
    MOVE G6C,110
    WAIT

    SPEED 12
    MOVE G6A,93,  56, 145,  113, 105, 100
    MOVE G6D,93,  96, 145,  73, 105, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100

    WAIT

    GOSUB 기본자세
    
	RETURN
    '**********************************************

    '**********************************************

    '**********************************************	


    '**********************************************
왼쪽턴45:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
왼쪽턴45_LOOP:

    SPEED 10
    MOVE G6A,95,  106, 145,  63, 105, 100
    MOVE G6D,95,  46, 145,  123, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  106, 145,  63, 105, 100
    MOVE G6D,93,  46, 145,  123, 105, 100
    WAIT

    SPEED 8
    GOSUB 기본자세
    'DELAY 50
    '    GOSUB 앞뒤기울기측정
    '    IF 넘어진확인 = 1 THEN
    '        넘어진확인 = 0
    '        GOTO RX_EXIT
    '    ENDIF
    '
    '    ERX 4800,A,왼쪽턴45_LOOP
    '    IF A_old = A THEN GOTO 왼쪽턴45_LOOP
    '
    RETURN

    '**********************************************
오른쪽턴45:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
오른쪽턴45_LOOP:

    SPEED 10
    MOVE G6A,95,  46, 145,  123, 105, 100
    MOVE G6D,95,  106, 145,  63, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  46, 145,  123, 105, 100
    MOVE G6D,93,  106, 145,  63, 105, 100
    WAIT

    SPEED 8
    GOSUB 기본자세
    ' DELAY 50
    '    GOSUB 앞뒤기울기측정
    '    IF 넘어진확인 = 1 THEN
    '        넘어진확인 = 0
    '        GOTO RX_EXIT
    '    ENDIF
    '
    '    ERX 4800,A,오른쪽턴45_LOOP
    '    IF A_old = A THEN GOTO 오른쪽턴45_LOOP
    '
    RETURN
    '**********************************************
계단오른쪽턴:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2

    SPEED 10
    MOVE G6A,95,  46, 145,  123, 105, 100
    MOVE G6D,95,  106, 145,  63, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  46, 145,  123, 105, 100
    MOVE G6D,93,  106, 145,  63, 105, 100
    WAIT

    SPEED 8
    GOSUB 기본자세2
   
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2

    SPEED 10
    MOVE G6A,95,  106, 145,  63, 105, 100
    MOVE G6D,95,  46, 145,  123, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  106, 145,  63, 105, 100
    MOVE G6D,93,  46, 145,  123, 105, 100
    WAIT

    SPEED 8
    GOSUB 기본자세2
    
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2

    SPEED 10
    MOVE G6A,95,  106, 145,  63, 105, 100
    MOVE G6D,95,  46, 145,  123, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  106, 145,  63, 105, 100
    MOVE G6D,93,  46, 145,  123, 105, 100
    WAIT

    SPEED 8
    GOSUB 기본자세2
    
    RETURN
    '**********************************************
왼쪽턴60:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
왼쪽턴60_LOOP:

    SPEED 10
    MOVE G6A,95,  116, 145,  53, 105, 100
    MOVE G6D,95,  36, 145,  133, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,90,  116, 145,  53, 105, 100
    MOVE G6D,90,  36, 145,  133, 105, 100
    WAIT

    SPEED 8
    GOSUB 기본자세
    '  DELAY 50
    '    GOSUB 앞뒤기울기측정
    '    IF 넘어진확인 = 1 THEN
    '        넘어진확인 = 0
    '        GOTO RX_EXIT
    '    ENDIF
    '    ERX 4800,A,왼쪽턴60_LOOP
    '    IF A_old = A THEN GOTO 왼쪽턴60_LOOP

    RETURN

    '**********************************************
오른쪽턴60:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
오른쪽턴60_LOOP:

    SPEED 15
    MOVE G6A,95,  36, 145,  133, 105, 100
    MOVE G6D,95,  116, 145,  53, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  36, 145,  133, 105, 100
    MOVE G6D,90,  116, 145,  53, 105, 100

    WAIT

    SPEED 10
    GOSUB 기본자세
    ' DELAY 50
    '    GOSUB 앞뒤기울기측정
    '    IF 넘어진확인 = 1 THEN
    '        넘어진확인 = 0
    '        GOTO RX_EXIT
    '    ENDIF
    '    ERX 4800,A,오른쪽턴60_LOOP
    '    IF A_old = A THEN GOTO 오른쪽턴60_LOOP
    RETURN
    '****************************************
    '************************************************
    '**********************************************


    '************************************************

    ''************************************************
    '************************************************
    '************************************************
뒤로일어나기:

    HIGHSPEED SETOFF
    PTP SETON 				
    PTP ALLON		

    GOSUB 자이로OFF

    GOSUB All_motor_Reset

    SPEED 15
    GOSUB 기본자세

    MOVE G6A,90, 130, ,  80, 110, 100
    MOVE G6D,90, 130, 120,  80, 110, 100
    MOVE G6B,150, 160,  10, 100, 100, 100
    MOVE G6C,150, 160,  10, 100, 100, 100
    WAIT

    MOVE G6B,170, 140,  10, 100, 100, 100
    MOVE G6C,170, 140,  10, 100, 100, 100
    WAIT

    MOVE G6B,185,  20, 70,  100, 100, 100
    MOVE G6C,185,  20, 70,  100, 100, 100
    WAIT
    SPEED 10
    MOVE G6A, 80, 155,  85, 150, 150, 100
    MOVE G6D, 80, 155,  85, 150, 150, 100
    MOVE G6B,185,  20, 70,  100, 100, 100
    MOVE G6C,185,  20, 70,  100, 100, 100
    WAIT



    MOVE G6A, 75, 162,  55, 162, 155, 100
    MOVE G6D, 75, 162,  59, 162, 155, 100
    MOVE G6B,188,  10, 100, 100, 100, 100
    MOVE G6C,188,  10, 100, 100, 100, 100
    WAIT

    SPEED 10
    MOVE G6A, 60, 162,  30, 162, 145, 100
    MOVE G6D, 60, 162,  30, 162, 145, 100
    MOVE G6B,170,  10, 100, 100, 100, 100
    MOVE G6C,170,  10, 100, 100, 100, 100
    WAIT
    GOSUB Leg_motor_mode3	
    MOVE G6A, 60, 150,  28, 155, 140, 100
    MOVE G6D, 60, 150,  28, 155, 140, 100
    MOVE G6B,150,  60,  90, 100, 100, 100
    MOVE G6C,150,  60,  90, 100, 100, 100
    WAIT

    MOVE G6A,100, 150,  28, 140, 100, 100
    MOVE G6D,100, 150,  28, 140, 100, 100
    MOVE G6B,130,  50,  85, 100, 100, 100
    MOVE G6C,130,  50,  85, 100, 100, 100
    WAIT
    DELAY 100

    MOVE G6A,100, 150,  33, 140, 100, 100
    MOVE G6D,100, 150,  33, 140, 100, 100
    WAIT
    SPEED 10
    GOSUB 기본자세

    넘어진확인 = 1

    DELAY 200
    GOSUB 자이로ON
	ETX 4800, A_old
    RETURN


    '**********************************************
앞으로일어나기:


    HIGHSPEED SETOFF
    PTP SETON 				
    PTP ALLON

    GOSUB 자이로OFF

    HIGHSPEED SETOFF

    GOSUB All_motor_Reset

    SPEED 15
    MOVE G6A,100, 15,  70, 140, 100,
    MOVE G6D,100, 15,  70, 140, 100,
    MOVE G6B,20,  140,  15
    MOVE G6C,20,  140,  15
    WAIT

    SPEED 12
    MOVE G6A,100, 136,  35, 80, 100,
    MOVE G6D,100, 136,  35, 80, 100,
    MOVE G6B,20,  30,  80
    MOVE G6C,20,  30,  80
    WAIT

    SPEED 12
    MOVE G6A,100, 165,  70, 30, 100,
    MOVE G6D,100, 165,  70, 30, 100,
    MOVE G6B,30,  20,  95
    MOVE G6C,30,  20,  95
    WAIT

    GOSUB Leg_motor_mode3

    SPEED 10
    MOVE G6A,100, 165,  45, 90, 100,
    MOVE G6D,100, 165,  45, 90, 100,
    MOVE G6B,130,  50,  60
    MOVE G6C,130,  50,  60
    WAIT

    SPEED 6
    MOVE G6A,100, 145,  45, 130, 100,
    MOVE G6D,100, 145,  45, 130, 100,
    WAIT


    SPEED 8
    GOSUB All_motor_mode2
    GOSUB 기본자세
    넘어진확인 = 1

    '******************************
    DELAY 200
    GOSUB 자이로ON
    ETX 4800, A_old
    RETURN

    '******************************************
    '******************************************
    '******************************************
    '**************************************************

    '******************************************
    '******************************************	
    '**********************************************

머리왼쪽30도:
    SPEED 머리이동속도
    SERVO 11,70
    GOTO MAIN

머리왼쪽45도:
    SPEED 머리이동속도
    SERVO 11,55
    RETURN

머리왼쪽60도:
    SPEED 머리이동속도
    SERVO 11,40
    RETURN

머리왼쪽90도:
    SPEED 머리이동속도
    SERVO 11,10
    GOTO MAIN

머리오른쪽30도:
    SPEED 머리이동속도
    SERVO 11,130
    GOTO MAIN

머리오른쪽45도:
    SPEED 머리이동속도
    SERVO 11,145
    RETURN

머리오른쪽60도:
    SPEED 머리이동속도
    SERVO 11,160
    RETURN

머리오른쪽90도:
    SPEED 머리이동속도
    SERVO 11,190
    GOTO MAIN

머리좌우중앙:
    SPEED 머리이동속도
    SERVO 11,100
    RETURN

머리상하정면:
    SPEED 머리이동속도
    SERVO 11,100	
    SPEED 5
    GOSUB 기본자세
    GOTO MAIN

    '******************************************
전방하향80도:

    SPEED 3
    SERVO 16, 80
    ETX 4800,35
    RETURN
    '******************************************
전방하향60도:

    SPEED 3
    SERVO 16, 65
    ETX 4800,36
    RETURN

    '******************************************
    '******************************************
앞뒤기울기측정:
    FOR i = 0 TO COUNT_MAX
        A = AD(앞뒤기울기AD포트)	'기울기 앞뒤
        IF A > 250 OR A < 5 THEN RETURN
        IF A > MIN AND A < MAX THEN RETURN
        DELAY 기울기확인시간
    NEXT i

    IF A < MIN THEN
        GOSUB 기울기앞
        
    ELSEIF A > MAX THEN
        GOSUB 기울기뒤
        
    ENDIF
    RETURN
    '**************************************************
기울기앞:
    A = AD(앞뒤기울기AD포트)
    'IF A < MIN THEN GOSUB 앞으로일어나기
    IF A < MIN THEN
        GOSUB 뒤로일어나기

   	ENDIF
    RETURN

기울기뒤:
    A = AD(앞뒤기울기AD포트)
    'IF A > MAX THEN GOSUB 뒤로일어나기
    IF A > MAX THEN
        GOSUB 앞으로일어나기
    ENDIF
    RETURN
    '**************************************************
좌우기울기측정:
    FOR i = 0 TO COUNT_MAX
        B = AD(좌우기울기AD포트)	'기울기 좌우
        IF B > 250 OR B < 5 THEN RETURN
        IF B > MIN AND B < MAX THEN RETURN
        DELAY 기울기확인시간
    NEXT i

    IF B < MIN OR B > MAX THEN
        SPEED 8
        MOVE G6B,140,  40,  80
        MOVE G6C,140,  40,  80
        WAIT
        GOSUB 기본자세
    
    ENDIF
    ETX 4800, A_old	
    RETURN
    '******************************************
    '************************************************
SOUND_PLAY_CHK:
    DELAY 60
    SOUND_BUSY = IN(46)
    IF SOUND_BUSY = 1 THEN GOTO SOUND_PLAY_CHK
    DELAY 50

    RETURN
    '************************************************

    '************************************************
NUM_1_9:
    IF NUM = 1 THEN
        PRINT "1"
    ELSEIF NUM = 2 THEN
        PRINT "2"
    ELSEIF NUM = 3 THEN
        PRINT "3"
    ELSEIF NUM = 4 THEN
        PRINT "4"
    ELSEIF NUM = 5 THEN
        PRINT "5"
    ELSEIF NUM = 6 THEN
        PRINT "6"
    ELSEIF NUM = 7 THEN
        PRINT "7"
    ELSEIF NUM = 8 THEN
        PRINT "8"
    ELSEIF NUM = 9 THEN
        PRINT "9"
    ELSEIF NUM = 0 THEN
        PRINT "0"
    ENDIF

    RETURN
    '************************************************
    '************************************************
NUM_TO_ARR:

    NO_4 =  BUTTON_NO / 10000
    TEMP_INTEGER = BUTTON_NO MOD 10000

    NO_3 =  TEMP_INTEGER / 1000
    TEMP_INTEGER = BUTTON_NO MOD 1000

    NO_2 =  TEMP_INTEGER / 100
    TEMP_INTEGER = BUTTON_NO MOD 100

    NO_1 =  TEMP_INTEGER / 10
    TEMP_INTEGER = BUTTON_NO MOD 10

    NO_0 =  TEMP_INTEGER

    RETURN
    '************************************************
Number_Play: '  BUTTON_NO = 숫자대입


    GOSUB NUM_TO_ARR

    PRINT "NPL "
    '*************

    NUM = NO_4
    GOSUB NUM_1_9

    '*************
    NUM = NO_3
    GOSUB NUM_1_9

    '*************
    NUM = NO_2
    GOSUB NUM_1_9
    '*************
    NUM = NO_1
    GOSUB NUM_1_9
    '*************
    NUM = NO_0
    GOSUB NUM_1_9
    PRINT " !"

    GOSUB SOUND_PLAY_CHK
    PRINT "SND 16 !"
    GOSUB SOUND_PLAY_CHK
    RETURN
    '************************************************

    RETURN


    '******************************************

    ' ************************************************
적외선거리센서확인:

    적외선거리값= AD(5)

    IF 적외선거리값> 135 AND 단계=0 THEN '문열기 
    	MUSIC "C"
		ETX 4800, 77
	ELSEIF 적외선거리값> 100 AND 단계 = 1 THEN 
		MUSIC "C"
		ETX 4800, 78
	ELSEIF 적외선거리값> 75 AND 단계 = 2 THEN
		MUSIC "C"
		ETX 4800, 79
		
    ENDIF

    RETURN
    '******************************************
문오른쪽옆으로:
	' 오른쪽옆으로 70 1번 
	MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2

    DELAY  10

    SPEED 10
    MOVE G6D, 90,  90, 120, 105, 110, 100
    MOVE G6A,100,  76, 145,  93, 107, 100
    MOVE G6C,100,  40
    MOVE G6B,100,  40
    WAIT

    SPEED 13
    MOVE G6D, 102,  76, 145, 93, 100, 100
    MOVE G6A,83,  78, 140,  96, 115, 100
    MOVE G6C,100,  80
    MOVE G6B,100,  40
    WAIT

    SPEED 13
    MOVE G6D,98,  76, 145,  93, 100, 100
    MOVE G6A,98,  76, 145,  93, 100, 100
    MOVE G6C,100,  80
    MOVE G6B,100,  40
    WAIT

    SPEED 12
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  40
    MOVE G6B,100,  40
    WAIT
    
    GOSUB 기본자세
    WAIT
    
    RETURN
	' 오른쪽옆으로 70 끝
    'GOSUB 문열기
        'GOSUB 문연속전진
        'GOSUB 문기본자세
        'GOSUB 문연속전진
        'GOSUB 문기본자세
        'GOSUB 문연속전진
        'GOSUB 문기본자
        '*************************************
문열어뿌자:
	보행COUNT = 0
   	보행속도 = 13
   	좌우속도 = 4
    넘어진확인 = 0
 	MUSIC "C"
	
	GOSUB 왼쪽턴60
	WAIT
	
	GOSUB 기본자세
	WAIT
	
    GOSUB 왼쪽턴60
	WAIT
	
	GOSUB 기본자세
	WAIT

	GOSUB 횟수_전진종종걸음
	WAIT
	
	GOSUB 기본자세
	WAIT
	
	GOSUB 한번후진
	WAIT
	
	GOSUB 기본자세
	WAIT
	
	GOSUB 문오른쪽옆으로
	WAIT
	GOSUB 기본자세
	WAIT
	GOSUB 문오른쪽옆으로
	WAIT
	GOSUB 기본자세
	WAIT
	GOSUB 문오른쪽옆으로
	WAIT
	GOSUB 기본자세
	WAIT
	GOSUB 문오른쪽옆으로
	WAIT
	GOSUB 기본자세
	WAIT
	GOSUB 문오른쪽옆으로
	WAIT
	GOSUB 기본자세
	WAIT
	GOSUB 문오른쪽옆으로
	WAIT
	GOSUB 기본자세
	WAIT
	GOSUB 문오른쪽옆으로
	WAIT
	GOSUB 기본자세
	WAIT
	GOSUB 문오른쪽옆으로
	WAIT
	GOSUB 기본자세
	WAIT
	GOSUB 문오른쪽옆으로
	WAIT
	GOSUB 기본자세
	WAIT
	GOSUB 전진달리기fast
	WAIT
	GOSUB 기본자세
	WAIT
	GOSUB 전진달리기fast
	WAIT
	GOSUB 기본자세
	WAIT
	단계 = 1
	RETURN
	'********************************************      
문열기:
	SPEED 12
    MOVE G6B,190,20
    WAIT
    MOVE G6C,190,20
    WAIT
    
    RETURN
    '**********************************************
벨브:
   '오른쪽옆으로 1번
    SERVO 16, 100
    WAIT
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
	
	
    SPEED 12
    MOVE G6D, 95,  90, 125, 100, 104, 100
    MOVE G6A,105,  76, 146,  93, 104, 100
    WAIT

    SPEED 12
    MOVE G6D, 102,  77, 145, 93, 100, 100
    MOVE G6A,90,  80, 140,  95, 107, 100
    WAIT

    SPEED 10
    MOVE G6D,95,  76, 145,  93, 102, 100
    MOVE G6A,95,  76, 145,  93, 102, 100
    WAIT
    
    SPEED 9
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT
    
    GOSUB 오른쪽턴20
    WAIT
    
    '벨브잠그기 
    SERVO 16, 100
    SPEED 15
    'HIGHSPEED SETON
    MOVE G6B,100,  30,  80,
    MOVE G6C, 100,190,90
    WAIT
    MOVE G6C, 60,190,90
    WAIT
    SPEED 20
    MOVE G6C, 50,190,145
    WAIT
    'HIGHSPEED SETOFF
    
    
    '왼쪽옆으로 4번
    
    
    SPEED 10
    MOVE G6A, 90,  90, 120, 105, 110, 100   
    MOVE G6D,100,  76, 145,  93, 107, 100   
    WAIT

    SPEED 13
    MOVE G6A, 102,  76, 145, 93, 100, 100
    MOVE G6D,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 13
    MOVE G6A,98,  76, 145,  93, 100, 100
    MOVE G6D,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 12
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6A,100,  76, 145,  93, 100, 100
    WAIT

    SPEED 9
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT
    
    '왼쪽턴 1번
    SPEED 8
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100

    WAIT
    
    '-------------------------------------
    '팔더벌리기
    'SPEED 20
    'MOVE G6C, 40,190,150
    'WAIT
    '-------------------------------------
    SPEED 10
    MOVE G6A, 90,  90, 120, 105, 110, 100   
    MOVE G6D,100,  76, 145,  93, 107, 100   
    WAIT

    SPEED 13
    MOVE G6A, 102,  76, 145, 93, 100, 100
    MOVE G6D,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 13
    MOVE G6A,98,  76, 145,  93, 100, 100
    MOVE G6D,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 12
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6A,100,  76, 145,  93, 100, 100
    WAIT

    SPEED 9
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT
    '------------------------------------
    '왼쪽턴 1번
    SPEED 8
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100

    WAIT
    '-------------------------------------
    SPEED 10
    MOVE G6A, 90,  90, 120, 105, 110, 100   
    MOVE G6D,100,  76, 145,  93, 107, 100   
    WAIT

    SPEED 13
    MOVE G6A, 102,  76, 145, 93, 100, 100
    MOVE G6D,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 13
    MOVE G6A,98,  76, 145,  93, 100, 100
    MOVE G6D,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 12
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6A,100,  76, 145,  93, 100, 100
    WAIT

    SPEED 9
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT
    '-------------------------------------
    '왼쪽턴 1번 
    SPEED 8
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100

    WAIT
    '-------------------------------------
    SPEED 10
    MOVE G6A, 90,  90, 120, 105, 110, 100   
    MOVE G6D,100,  76, 145,  93, 107, 100   
    WAIT

    SPEED 13
    MOVE G6A, 102,  76, 145, 93, 100, 100
    MOVE G6D,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 13
    MOVE G6A,98,  76, 145,  93, 100, 100
    MOVE G6D,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 12
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6A,100,  76, 145,  93, 100, 100
    WAIT

    SPEED 9
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT
    '-------------------------------------
    
    '왼쪽턴 1번 
    SPEED 8
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100

    WAIT
    SPEED 10
    MOVE G6A, 90,  90, 120, 105, 110, 100   
    MOVE G6D,100,  76, 145,  93, 107, 100   
    WAIT
	'-------------------------------------
    SPEED 13
    MOVE G6A, 102,  76, 145, 93, 100, 100
    MOVE G6D,83,  78, 140,  96, 115, 100
    WAIT

    SPEED 13
    MOVE G6A,98,  76, 145,  93, 100, 100
    MOVE G6D,98,  76, 145,  93, 100, 100
    WAIT

    SPEED 12
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6A,100,  76, 145,  93, 100, 100
    WAIT

    SPEED 9
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT
    '앉기    
    GOSUB 자이로OFF
    MOVE G6A,100, 145,  28, 145, 100, 100
    MOVE G6D,100, 145,  28, 145, 100, 100
    
    WAIT
    
    GOSUB 환호성
    WAIT
    
    단계 = 2
	
    RETURN
'******************************************
벨브_기본자세:
	SPEED 5
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT

    mode = 0
    RETURN
'******************************************
벨브_오른쪽옆으로: 
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2

    SPEED 12
    MOVE G6D, 95,  90, 125, 100, 104, 100
    MOVE G6A,105,  76, 146,  93, 104, 100
    WAIT

    SPEED 12
    MOVE G6D, 102,  77, 145, 93, 100, 100
    MOVE G6A,90,  80, 140,  95, 107, 100
    WAIT

    SPEED 10
    MOVE G6D,95,  76, 145,  93, 102, 100
    MOVE G6A,95,  76, 145,  93, 102, 100
    WAIT

    SPEED 8
    GOSUB 벨브_기본자세
    GOSUB All_motor_mode3
    RETURN
'******************************************
집고왼쪽턴10:

    SPEED 5
    MOVE G6A,97,  86, 145,  75, 103, 100
    MOVE G6D,97,  66, 145,  95, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  86, 145,  75, 101, 100
    MOVE G6D,94,  66, 145,  95, 101, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  85, 98, 100
    MOVE G6D,101,  76, 146,  85, 98, 100
    WAIT

    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOTO RX_EXIT
    '**********************************************
집고오른쪽턴10:

    SPEED 5
    MOVE G6A,97,  66, 145,  95, 103, 100
    MOVE G6D,97,  86, 145,  75, 103, 100
    WAIT

    SPEED 12
    MOVE G6A,94,  66, 145,  95, 101, 100
    MOVE G6D,94,  86, 145,  75, 101, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  85, 98, 100
    MOVE G6D,101,  76, 146,  85, 98, 100
    WAIT

    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOTO RX_EXIT
    '**********************************************
    '**********************************************
집고왼쪽턴20:

    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  96, 145,  65, 105, 100
    MOVE G6D,95,  56, 145,  105, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  65, 105, 100
    MOVE G6D,93,  56, 145,  105, 105, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  85, 98, 100
    MOVE G6D,101,  76, 146,  85, 98, 100
    WAIT

    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
집고오른쪽턴20:

    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  56, 145,  105, 105, 100
    MOVE G6D,95,  96, 145,  65, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  56, 145,  105, 105, 100
    MOVE G6D,93,  96, 145,  65, 105, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  85, 98, 100
    MOVE G6D,101,  76, 146,  85, 98, 100
    WAIT

    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT

    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
    '********************************************
계단오른발내리기태린:  

    GOSUB All_motor_mode3

    SPEED 4 
    MOVE G6D, 88,  71, 152,  91, 110 '오른쪽발 안쪽으로
    MOVE G6A,108,  76, 145,  93,  94 '왼쪽다리
    MOVE G6B,100,40 '왼쪽팔
    MOVE G6C,100,40 '오른쪽팔
    WAIT

    SPEED 10 
    MOVE G6D, 90, 100, 115, 105, 114 '오른다리 들기
    MOVE G6A,113,  76, 145,  93,  94 '왼쪽발 바깥쪽으로
    WAIT

    GOSUB Leg_motor_mode2
    
    SPEED 12
    MOVE G6D,  80, 30, 155, 150, 114 '오른다리 내딛기
    MOVE G6A, 113,  75, 145,  90,  94 '
    WAIT


    SPEED 7
    MOVE G6A, 113,  100, 95,  120,  94 ' 왼쪽다리 굽히기
    MOVE G6D,  80, 30, 175, 150, 114, '오른쪽다리 더내딛기
    MOVE G6B,140,40
    MOVE G6C,70,40
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 5
    MOVE G6A,110, 130, 65,  120,94
    MOVE G6D,85, 20, 160, 150, 110
    MOVE G6C,100,50
    MOVE G6B,140,50
    WAIT
    
     SPEED 5
    MOVE G6A,110, 140, 75,  120,94
    MOVE G6D,90, 12, 170, 150, 110
    MOVE G6C,100,50
    MOVE G6B,140,50
    WAIT

    '****************************
    
   SPEED 8 '''발오른쪽으로 벌림
    MOVE G6D,100, 70, 125, 140, 115
    MOVE G6A,100, 155, 70,  100,100
    
  
    MOVE G6C,140,50
    MOVE G6B,100,40
    WAIT
 
 
    SPEED 10
    MOVE G6A,100,  130, 90,  100, 100
    MOVE G6D,75, 50, 140, 120, 110
    MOVE G6C,140,50
    MOVE G6B,100,40
    WAIT
    
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    
    SPEED 10
    MOVE G6D,95, 40, 140, 140, 110
    MOVE G6A,100,  130, 110,  100, 100
    MOVE G6C,140,50
    MOVE G6B,100,40
    WAIT
    
    SPEED 10
    MOVE G6D,85, 50, 140, 140, 110
    MOVE G6A,95,  100, 80,  150, 105
    MOVE G6C,140,50
    MOVE G6B,100,40
    WAIT
    
    SPEED 8
    MOVE G6A,95,  105, 100,  100, 105
    MOVE G6D,80, 60, 140, 120, 110
    MOVE G6C,140,50
    MOVE G6B,100,40
    WAIT
    
    SPEED 10
    MOVE G6D,95, 40, 140, 140, 110
    MOVE G6A,100,  110, 95,  120, 100
    MOVE G6C,140,50
    MOVE G6B,100,40
    WAIT
    
    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80,
    MOVE G6C,100,  30,  80,
    WAIT
    
    ' 왼쪽턴 20
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    SPEED 8
    MOVE G6A,95,  96, 145,  73, 105, 100
    MOVE G6D,95,  56, 145,  113, 105, 100
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    SPEED 12
    MOVE G6A,93,  96, 145,  73, 105, 100
    MOVE G6D,93,  56, 145,  113, 105, 100
    WAIT
    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100

    WAIT

    GOSUB 기본자세2
    
    ' 오른쪽턴 20
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    SPEED 8
    MOVE G6A,95,  56, 145,  113, 105, 100
    MOVE G6D,95,  96, 145,  73, 105, 100
    MOVE G6B,90
    MOVE G6C,110
    WAIT

    SPEED 12
    MOVE G6A,93,  56, 145,  113, 105, 100
    MOVE G6D,93,  96, 145,  73, 105, 100
    WAIT

    SPEED 6
    MOVE G6A,101,  76, 146,  93, 98, 100
    MOVE G6D,101,  76, 146,  93, 98, 100

    WAIT

    GOSUB 기본자세2
    
    
  	ETX 4800, 243
    mode = 0
     WAIT
    GOTO RX_EXIT
    '--------------------------------------------
집고왼쪽턴45:

    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  106, 145,  55, 105, 100
    MOVE G6D,95,  46, 145,  115, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,93,  106, 145,  55, 105, 100
    MOVE G6D,93,  46, 145,  115, 105, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT

    '**********************************************
집고오른쪽턴45:

    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A,95,  46, 145,  115, 105, 100
    MOVE G6D,95,  106, 145,  55, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,93,  46, 145,  115, 105, 100
    MOVE G6D,93,  106, 145,  55, 105, 100
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOSUB Leg_motor_mode1
    GOTO RX_EXIT
    '**********************************************
집고왼쪽턴60:

    SPEED 15
    MOVE G6A,95,  116, 145,  45, 105, 100
    MOVE G6D,95,  36, 145,  125, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  116, 145,  45, 105, 100
    MOVE G6D,90,  36, 145,  125, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOTO RX_EXIT

    '**********************************************
집고오른쪽턴60:

    SPEED 15
    MOVE G6A,95,  36, 145,  125, 105, 100
    MOVE G6D,95,  116, 145,  45, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  36, 145,  125, 105, 100
    MOVE G6D,90,  116, 145,  45, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,100,  76, 145,  85, 100
    MOVE G6D,100,  76, 145,  85, 100
    WAIT
    GOTO RX_EXIT

    '************************************************


    '************************************************
    '************************************************

    '************************************************
계단왼발오르기3cm:
    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,108,  76, 146,  93,  94
    MOVE G6B,100,40
    MOVE G6C,100,40
    WAIT

    SPEED 10
    MOVE G6A, 90, 100, 110, 100, 114
    MOVE G6D,113,  78, 146,  93,  94
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 15
    MOVE G6A, 90, 140, 35, 130, 114
    MOVE G6D,113,  73, 155,  90,  94
    WAIT


    SPEED 12
    MOVE G6A,  80, 40, 115, 160, 114,
    MOVE G6D,113,  70, 155,  90,  94
    WAIT

    GOSUB Leg_motor_mode3

    SPEED 7
    MOVE G6A, 105, 70, 100, 160, 100,
    MOVE G6D,80,  90, 165,  70, 100
    MOVE G6B,160,50
    MOVE G6C,160,40
    WAIT

    SPEED 6
    MOVE G6A, 113, 90, 80, 160,95,
    MOVE G6D,70,  95, 165,  65, 105
    MOVE G6B,180,50
    MOVE G6C,180,30
    WAIT

    '****************************
    GOSUB Leg_motor_mode2	
    SPEED 8
    MOVE G6A, 114, 90, 100, 150,95,
    MOVE G6D,75,  90, 165,  70, 105
    WAIT

    SPEED 12
    MOVE G6A, 114, 90, 100, 150,95,
    MOVE G6D,90,  120, 40,  140, 108
    WAIT

    SPEED 10
    MOVE G6A, 114, 90, 110, 130,95,
    MOVE G6D,90,  95, 90,  145, 108
    MOVE G6B,140,50
    MOVE G6C,140,30
    WAIT

    SPEED 10
    MOVE G6A, 110, 90, 110, 130,95,
    MOVE G6D,80,  85, 110,  135, 108
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 5
    MOVE G6D, 98, 90, 110, 125,99,
    MOVE G6A,98,  90, 110,  125, 99
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 6
    GOSUB 기본자세

    GOTO RX_EXIT
    '****************************************

계단오른발오르기3cm:
    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6D, 88,  71, 152,  91, 110
    MOVE G6A,108,  76, 146,  93,  94
    MOVE G6B,100,40
    MOVE G6C,100,40
    WAIT

    SPEED 10
    MOVE G6D, 90, 100, 110, 100, 114
    MOVE G6A,113,  78, 146,  93,  94
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 15
    MOVE G6D, 90, 140, 35, 130, 114
    MOVE G6A,113,  73, 155,  90,  94
    WAIT


    SPEED 12
    MOVE G6D,  80, 40, 115, 160, 114,
    MOVE G6A,113,  70, 155,  90,  94
    WAIT

    GOSUB Leg_motor_mode3

    SPEED 7
    MOVE G6D, 105, 70, 100, 160, 100,
    MOVE G6A,80,  90, 165,  70, 100
    MOVE G6C,160,50
    MOVE G6B,160,40
    WAIT

    SPEED 6
    MOVE G6D, 113, 90, 80, 160,95,
    MOVE G6A,70,  95, 165,  65, 105
    MOVE G6C,180,50
    MOVE G6B,180,30
    WAIT

    '****************************
    GOSUB Leg_motor_mode2	
    SPEED 8
    MOVE G6D, 114, 90, 100, 150,95,
    MOVE G6A,75,  90, 165,  70, 105
    WAIT

    SPEED 12
    MOVE G6D, 114, 90, 100, 150,95,
    MOVE G6A,90,  120, 40,  140, 108
    WAIT

    SPEED 10
    MOVE G6D, 114, 90, 110, 130,95,
    MOVE G6A,90,  95, 90,  145, 108
    MOVE G6C,140,50
    MOVE G6B,140,30
    WAIT

    SPEED 10
    MOVE G6D, 110, 90, 110, 130,95,
    MOVE G6A,80,  85, 110,  135, 108
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 5
    MOVE G6D, 98, 90, 110, 125,99,
    MOVE G6A,98,  90, 110,  125, 99
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 6
    GOSUB 기본자세

    GOTO RX_EXIT
    '********************************************	

    '************************************************
계단왼발내리기3cm:
    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,108,  76, 145,  93,  94
    MOVE G6B,100,40
    MOVE G6C,100,40
    WAIT

    SPEED 10
    MOVE G6A, 90, 100, 115, 105, 114
    MOVE G6D,113,  76, 145,  93,  94
    WAIT

    GOSUB Leg_motor_mode2


    SPEED 12
    MOVE G6A,  80, 30, 155, 150, 114,
    MOVE G6D,113,  65, 155,  90,  94
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 7
    MOVE G6A,  80, 30, 175, 150, 114,
    MOVE G6D,113,  115, 65,  140,  94
    MOVE G6B,70,50
    MOVE G6C,70,40
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 5
    MOVE G6A,90, 20, 150, 150, 110
    MOVE G6D,110,  155, 35,  120,94
    MOVE G6B,100,50
    MOVE G6C,140,40
    WAIT

    '****************************
'계단!!!
    SPEED 8
    MOVE G6A,100, 30, 150, 150, 100
    MOVE G6D,100,  155, 70,  100,100
    MOVE G6B,140,50
    MOVE G6C,100,40
    WAIT

    SPEED 10
    MOVE G6A,114, 70, 130, 150, 94
    MOVE G6D,80,  125, 140,  85,114
    MOVE G6B,170,50
    MOVE G6C,100,40
    WAIT

    GOSUB Leg_motor_mode2	
    SPEED 10
    MOVE G6A,114, 70, 130, 150, 94
    MOVE G6D,80,  125, 50,  150,114
    WAIT

    SPEED 9
    MOVE G6A,114, 75, 130, 120, 94
    MOVE G6D,80,  85, 90,  150,114
    WAIT

    SPEED 8
    MOVE G6A,112, 80, 130, 110, 94
    MOVE G6D,80,  75,130,  115,114
    MOVE G6B,130,50
    MOVE G6C,100,40
    WAIT

    SPEED 6
    MOVE G6D, 98, 80, 130, 105,99,
    MOVE G6A,98,  80, 130,  105, 99
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 4
    GOSUB 기본자세

    GOTO RX_EXIT
    '****************************************
    '************************************************
계단오른발내리기3cm:
    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6D, 88,  71, 152,  91, 110
    MOVE G6A,108,  76, 145,  93,  94
    MOVE G6B,100,40
    MOVE G6C,100,40
    WAIT

    SPEED 10
    MOVE G6D, 90, 100, 115, 105, 114
    MOVE G6A,113,  76, 145,  93,  94
    WAIT

    GOSUB Leg_motor_mode2


    SPEED 12
    MOVE G6D,  80, 30, 155, 150, 114,
    MOVE G6A,113,  65, 155,  90,  94
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 7
    MOVE G6D,  80, 30, 175, 150, 114,
    MOVE G6A,113,  115, 65,  140,  94
    MOVE G6B,70,50
    MOVE G6C,70,40
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 5
    MOVE G6D,90, 20, 150, 150, 110
    MOVE G6A,110,  155, 35,  120,94
    MOVE G6C,100,50
    MOVE G6B,140,40
    WAIT

    '****************************

    SPEED 8
    MOVE G6D,100, 30, 150, 150, 100
    MOVE G6A,100,  155, 70,  100,100
    MOVE G6C,140,50
    MOVE G6B,100,40
    WAIT

    SPEED 10
    MOVE G6D,114, 70, 130, 150, 94
    MOVE G6A,80,  125, 140,  85,114
    MOVE G6C,170,50
    MOVE G6B,100,40
    WAIT

    GOSUB Leg_motor_mode2	
    SPEED 10
    MOVE G6D,114, 70, 130, 150, 94
    MOVE G6A,80,  125, 50,  150,114
    WAIT

    SPEED 9
    MOVE G6D,114, 75, 130, 120, 94
    MOVE G6A,80,  85, 90,  150,114
    WAIT

    SPEED 8
    MOVE G6D,112, 80, 130, 110, 94
    MOVE G6A,80,  75,130,  115,114
    MOVE G6C,130,50
    MOVE G6B,100,40
    WAIT

    SPEED 6
    MOVE G6D, 98, 80, 130, 105,99,
    MOVE G6A,98,  80, 130,  105, 99
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 4
    GOSUB 기본자세

    GOTO RX_EXIT
    '************************************************

    '************************************************
계단왼발오르기1cm:
    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6A, 88,  71, 152,  91, 110
    MOVE G6D,108,  77, 146,  93,  94
    MOVE G6B,100,40
    MOVE G6C,100,40
    WAIT

    SPEED 8
    MOVE G6A, 90, 100, 110, 100, 114
    MOVE G6D,114,  78, 146,  93,  94
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 8
    MOVE G6A, 90, 140, 35, 130, 114
    MOVE G6D,114,  71, 155,  90,  94
    WAIT


    SPEED 12
    MOVE G6A,  80, 55, 130, 140, 114,
    MOVE G6D,114,  70, 155,  90,  94
    WAIT

    GOSUB Leg_motor_mode3

    SPEED 7
    MOVE G6A, 105, 75, 100, 155, 100,
    MOVE G6D,95,  90, 165,  70, 100
    MOVE G6B,160,50
    MOVE G6C,160,40
    WAIT

    SPEED 6
    MOVE G6A, 114, 90, 90, 155,100,
    MOVE G6D,95,  100, 165,  65, 105
    MOVE G6B,180,50
    MOVE G6C,180,30
    WAIT

    '****************************
    GOSUB Leg_motor_mode2	
    SPEED 8
    MOVE G6A, 114, 90, 100, 150,95,
    MOVE G6D,95,  90, 165,  70, 105
    WAIT

    SPEED 12
    MOVE G6A, 114, 90, 100, 150,95,
    MOVE G6D,90,  120, 40,  140, 108
    WAIT

    SPEED 10
    MOVE G6A, 114, 90, 110, 130,95,
    MOVE G6D,90,  95, 90,  145, 108
    MOVE G6B,140,50
    MOVE G6C,140,30
    WAIT

    SPEED 10
    MOVE G6A, 110, 90, 110, 130,95,
    MOVE G6D,80,  85, 110,  135, 108
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 5
    MOVE G6D, 98, 90, 110, 125,99,
    MOVE G6A,98,  90, 110,  125, 99
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 6
    MOVE G6A,100,  77, 145,  93, 100, 100
    MOVE G6D,100,  77, 145,  93, 100, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOTO RX_EXIT
    '****************************************

계단오른발오르기1cm:
    
    GOSUB All_motor_mode3
    GOSUB All_motor_mode3

    SPEED 4
    MOVE G6D, 88,  71, 152,  91, 110
    MOVE G6A,108,  77, 146,  93,  94
    MOVE G6B,100,40
    MOVE G6C,100,40
    WAIT

    SPEED 4
    MOVE G6A,115,  78, 146,  90,  94
    MOVE G6D, 90, 105, 110, 100, 120
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 4
    MOVE G6D, 100, 140, 35, 130, 117
    MOVE G6A,113,  71, 155,  84,  94
    WAIT


    SPEED 4
    MOVE G6D, 100, 40, 120, 160, 117
    MOVE G6A,113,  70, 154,  80,  94
    WAIT

    GOSUB Leg_motor_mode3

    SPEED 4
    MOVE G6D, 105, 75, 100, 155, 100,
    MOVE G6A,113,  70, 154,  80,  90
    MOVE G6C,160,50
    MOVE G6B,160,40
    WAIT

    SPEED 4
    MOVE G6D, 113, 90, 90, 155,100,
    MOVE G6A,95,  100, 165,  65, 105
    MOVE G6C,180,50
    MOVE G6B,180,30
    WAIT

    '****************************
    GOSUB Leg_motor_mode2	
    SPEED 4
    MOVE G6D, 114, 90, 100, 150,95,
    MOVE G6A,95,  90, 165,  70, 105
    WAIT

    SPEED 4
    MOVE G6D, 114, 90, 100, 150,95,
    MOVE G6A,90,  120, 40,  140, 108
    WAIT

    SPEED 4
    MOVE G6D, 114, 90, 110, 130,95,
    MOVE G6A,90,  95, 90,  145, 108
    MOVE G6C,140,50
    MOVE G6B,140,30
    WAIT

    SPEED 4
    MOVE G6D, 110, 90, 110, 130,95,
    MOVE G6A,80,  85, 110,  135, 108
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 4
    MOVE G6A, 98, 90, 110, 125,99,
    MOVE G6D,98,  90, 110,  125, 99
    MOVE G6B,110,40
    MOVE G6C,110,40
    WAIT

    SPEED 6
    MOVE G6A,100,  77, 145,  93, 100, 100
    MOVE G6D,100,  77, 145,  93, 100, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    GOTO RX_EXIT
    '********************************************	
계단오른발내리기1cm:  
	
	GOSUB All_motor_mode3

    SPEED 4 
    MOVE G6D, 88,  71, 152,  91, 110 '오른쪽발 안쪽으로
    MOVE G6A,108,  76, 145,  93,  94 '왼쪽다리
    MOVE G6B,100,40 '왼쪽팔
    MOVE G6C,100,40 '오른쪽팔
    WAIT

    SPEED 10 
    MOVE G6D, 90, 100, 115, 105, 114 '오른다리 들기
    MOVE G6A,113,  76, 145,  93,  94 '왼쪽발 바깥쪽으로
    WAIT

    GOSUB Leg_motor_mode2
    
    SPEED 12
    MOVE G6D,  80, 30, 155, 150, 114 '오른다리 내딛기
    MOVE G6A, 113,  75, 145,  90,  94 '
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 7
    MOVE G6A, 113,  100, 95,  120,  94 ' 왼쪽다리 굽히기
    MOVE G6D,  80, 30, 175, 150, 114, '오른쪽다리 더내딛기
    MOVE G6B,140,40
    MOVE G6C,70,40
    WAIT

    GOSUB Leg_motor_mode3
    SPEED 5
    MOVE G6A,110, 140, 65,  120,94
    MOVE G6D,85, 30, 140, 150, 110
    MOVE G6C,100,50
    MOVE G6B,140,50
    WAIT

    '****************************
	SPEED 8 '''발오른쪽으로 벌림
    MOVE G6D,75, 60, 125, 140, 115
    MOVE G6A,100, 155, 70,  100,100
    MOVE G6C,140,50
    MOVE G6B,100,40
    WAIT
 
 
    SPEED 10
    MOVE G6A,100,  130, 90,  100, 100
    MOVE G6D,75, 50, 140, 120, 110
    MOVE G6C,140,50
    MOVE G6B,100,40
    WAIT
    
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
    
    SPEED 10
    MOVE G6D,95, 40, 140, 140, 110
    MOVE G6A,100,  130, 110,  100, 100
    MOVE G6C,140,50
    MOVE G6B,100,40
    WAIT
    
    SPEED 10
    MOVE G6D,85, 50, 140, 140, 110
    MOVE G6A,95,  100, 80,  150, 105
    MOVE G6C,140,50
    MOVE G6B,100,40
    WAIT
    
    SPEED 8
    MOVE G6A,95,  105, 100,  100, 105
    MOVE G6D,80, 60, 140, 120, 110
    MOVE G6C,140,50
    MOVE G6B,100,40
    WAIT
    
    SPEED 10
    MOVE G6D,95, 40, 140, 140, 110
    MOVE G6A,100,  110, 95,  120, 100
    MOVE G6C,140,50
    MOVE G6B,100,40
    WAIT
    
    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80,
    MOVE G6C,100,  30,  80,
    WAIT
   
   
  
    mode = 0
  	WAIT
    GOTO RX_EXIT
'************************************************
왼손들기:
	SPEED 10
    MOVE G6B,190,20
    GOTO RX_EXIT
'******************************************
오른손들기:
	SPEED 10
    MOVE G6C,190,20
    GOTO RX_EXIT
    '************************************************

'******************************************
림보걸음:
    GOSUB All_motor_mode3
    
    SPEED 8
    MOVE G6A, 100, 163,  75,  15, 100, 100
    MOVE G6D, 100, 163,  75,  15, 100, 100
    MOVE G6B,90, 30, 80, 100, 100, 100
    MOVE G6C,90, 30, 80, 100, 100, 100
    WAIT
    
    SPEED 3
    MOVE G6A, 100, 167,  27,  33, 100, 100
    MOVE G6D, 100, 167,  27,  33, 100, 100
    MOVE G6B,90, 20, 85, 100, 100, 100
    MOVE G6C,90, 20, 85, 100, 100, 100
    WAIT
    
    SPEED 5	
    MOVE G6A, 110, 167,  27,  33, 100
    MOVE G6D, 90, 167,  27,  33, 100
    WAIT

FOR i = 0 TO 50
	HIGHSPEED SETON
    SPEED 8 '8
    MOVE G6A, 110, 167,  27,  40, 100
    MOVE G6D, 90, 135,  27,  53, 100
    WAIT

	SPEED 15 '10
    MOVE G6A, 90, 160,  27,  33, 100
    MOVE G6D, 110, 155,  27,  53, 100
    WAIT
    
	SPEED 5 '5
    MOVE G6D, 110, 167,  27,  37, 100
    MOVE G6A, 90, 135,  15,  43, 100
    WAIT
    
	SPEED 10
    MOVE G6D, 90, 160,  27,  33, 100
    MOVE G6A, 110, 155,  15,  43, 100
    WAIT
NEXT i

    HIGHSPEED SETOFF
    GOSUB 자이로ON 
    WAIT 
    단계 = 2
    
    RETURN
'**********************************************
장애물쳐내기:
	GOSUB All_motor_mode3
    SPEED 10
	GOSUB 자이로OFF
    MOVE G6A,105, 150,  28, 150,  96
    MOVE G6D, 95, 150,  28, 155, 110
    WAIT
    
    HIGHSPEED SETON
    SPEED 5
    MOVE G6C, 160, 100, 40
    WAIT
    
    SPEED 15
    MOVE G6C, 160, 10, 50
    WAIT
    
    SPEED 15
    MOVE G6C, 160, 10, 35
    WAIT
    
    DELAY 400
	HIGHSPEED SETOFF
	
	SPEED 5
    MOVE G6C, , 50, 100
    WAIT
    
    HIGHSPEED SETON
    SPEED 5
    MOVE G6B, 160, 100, 40
    WAIT
    
    SPEED 15
    MOVE G6B, 160, 10, 50
    WAIT
    
    SPEED 15
    MOVE G6B, 160, 10, 35
    WAIT
    
    DELAY 400
    HIGHSPEED SETOFF
    
    SPEED 5
    MOVE G6B, , 50, 100
    WAIT
  
    SPEED 10
    GOSUB 기본자세
    WAIT
    
    RETURN
    '**********************************************
전진앉아보행:
    GOSUB All_motor_mode3
    SPEED 7
	GOSUB 자이로OFF
    MOVE G6A,105, 150,  28, 150,  96
    MOVE G6D, 95, 150,  28, 155, 110
    WAIT
    
    HIGHSPEED SETON
    SPEED 15
    MOVE G6C, 160, 100, 40
    WAIT
    
    SPEED 15
    MOVE G6C, 160, 10, 50
    WAIT
	
	SPEED 15
    MOVE G6C, , 50, 100
    WAIT
    
    SPEED 15
    MOVE G6B, 160, 100, 40
    WAIT
    
    SPEED 15
    MOVE G6B, 160, 10, 50
    WAIT
    
    SPEED 15
    MOVE G6B, , 50, 100
    WAIT

    MOVE G6D,98, 126,  28, 160, 102, 100
    MOVE G6A,98, 160,  28, 125, 102, 100
    WAIT

    MOVE G6D,113, 143,  28, 142,  96, 100
    MOVE G6A, 87, 135,  28, 155, 110, 100
    WAIT

    MOVE G6A,98, 126,  28, 160, 102, 100
    MOVE G6D,98, 160,  28, 125, 102, 100
    WAIT
    
    MOVE G6A,114, 143,  28, 142,  96, 100
    MOVE G6D, 87, 135,  28, 155, 110, 100
    WAIT


    MOVE G6D,98, 126,  28, 160, 102, 100
    MOVE G6A,98, 160,  28, 125, 102, 100
    WAIT

    MOVE G6D,113, 143,  28, 142,  96, 100
    MOVE G6A, 87, 135,  28, 155, 110, 100
    WAIT

    MOVE G6A,98, 126,  28, 160, 102, 100
    MOVE G6D,98, 160,  28, 125, 102, 100
    WAIT
    MOVE G6A,114, 143,  28, 142,  96, 100
    MOVE G6D, 87, 135,  28, 155, 110, 100
    WAIT


    MOVE G6D,98, 126,  28, 160, 102, 100
    MOVE G6A,98, 160,  28, 125, 102, 100
    WAIT

    MOVE G6D,113, 143,  28, 142,  96, 100
    MOVE G6A, 87, 135,  28, 155, 110, 100
    WAIT

    MOVE G6A,98, 126,  28, 160, 102, 100
    MOVE G6D,98, 160,  28, 125, 102, 100
    WAIT

    SPEED 6
    GOSUB 앉은자세
    GOSUB 자이로ON
    GOSUB 기본자세
    GOSUB All_motor_Reset
    
    RETURN

    '*****************************

    '**********************************************
왼발차기:

    GOSUB Leg_motor_mode3
    SPEED 7

    MOVE G6D,110,  77, 145,  93,  92, 100	
    MOVE G6A, 85,  71, 152,  91, 114, 100
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,	
    WAIT

    SPEED 10
    MOVE G6D,116,  75, 145,  100,  95	
    MOVE G6A, 83,  85, 122,  105, 114
    WAIT

    GOSUB Leg_motor_mode1
    HIGHSPEED SETON

    SPEED 10
    MOVE G6D,116,  77, 145,  85,  95	
    MOVE G6A, 83,  20, 172,  155, 114
    MOVE G6B,50
    MOVE G6C,150
    WAIT


    DELAY 400
    HIGHSPEED SETOFF


    SPEED 10
    MOVE G6D,116,  72, 145,  97,  95
    MOVE G6A, 83,  58, 122,  130, 114
    MOVE G6B,100,  40,  80, , , ,
    MOVE G6C,100,  40,  80, , , ,	
    WAIT	

    SPEED 10
    MOVE G6D,113,  77, 145,  95,  95	
    MOVE G6A, 80,  80, 142,  95, 114
    MOVE G6B,100,  40,  80, , , ,
    MOVE G6C,100,  40,  80, , , ,
    WAIT	

    SPEED 10
    MOVE G6D,110,  77, 145,  93,  93, 100	
    MOVE G6A, 80,  71, 152,  91, 114, 100
    WAIT


    SPEED 7
    GOSUB 기본자세	
    GOSUB Leg_motor_mode1
    DELAY 400
	GOSUB Leg_motor_mode3
	
    SPEED 7
    MOVE G6A,110,  77, 145,  93,  92, 100	
    MOVE G6D, 85,  71, 152,  91, 114, 100
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,	
    WAIT

    SPEED 10
    MOVE G6A,113,  75, 145,  100,  95	
    MOVE G6D, 83,  85, 122,  105, 114
    WAIT

    GOSUB Leg_motor_mode1
    
    HIGHSPEED SETON

    SPEED 15
    MOVE G6A,113,  73, 145,  90,  95	
    MOVE G6D, 83,  20, 172,  155, 114
    MOVE G6C,50
    MOVE G6B,150
    WAIT


    DELAY 400
    HIGHSPEED SETOFF


    SPEED 10
    MOVE G6A,113,  72, 145,  97,  95
    MOVE G6D, 83,  58, 122,  130, 114
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,	
    WAIT	

    SPEED 10
    MOVE G6A,113,  77, 145,  95,  95	
    MOVE G6D, 80,  80, 142,  95, 114
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,
    WAIT	

    SPEED 10
    MOVE G6A,110,  77, 145,  93,  93, 100	
    MOVE G6D, 80,  71, 152,  91, 114, 100
    WAIT


    SPEED 7
    GOSUB 기본자세	
    GOSUB Leg_motor_mode1
    DELAY 400
    
	RETURN
    

    '******************************************
오른발차기:
    GOSUB Leg_motor_mode3
    SPEED 4

    MOVE G6A,110,  77, 145,  93,  92, 100	
    MOVE G6D, 85,  71, 152,  91, 114, 100
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,	
    WAIT

    SPEED 10
    MOVE G6A,113,  75, 145,  100,  95	
    MOVE G6D, 83,  85, 122,  105, 114
    WAIT

    GOSUB Leg_motor_mode1
    HIGHSPEED SETON

    SPEED 15
    MOVE G6A,113,  73, 145,  90,  95	
    MOVE G6D, 83,  20, 172,  155, 114
    MOVE G6C,50
    MOVE G6B,150
    WAIT


    DELAY 400
    HIGHSPEED SETOFF


    SPEED 10
    MOVE G6A,113,  72, 145,  97,  95
    MOVE G6D, 83,  58, 122,  130, 114
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,	
    WAIT	

    SPEED 8
    MOVE G6A,113,  77, 145,  95,  95	
    MOVE G6D, 80,  80, 142,  95, 114
    MOVE G6C,100,  40,  80, , , ,
    MOVE G6B,100,  40,  80, , , ,
    WAIT	

    SPEED 8
    MOVE G6A,110,  77, 145,  93,  93, 100	
    MOVE G6D, 80,  71, 152,  91, 114, 100
    WAIT


    SPEED 3
    GOSUB 기본자세	
    GOSUB Leg_motor_mode1
    DELAY 400

    RETURN
    '******************************************
계단오르자제발:
	SPEED 4
    MOVE G6D, 88,  74, 144,  95, 110
    MOVE G6A,108,  76, 146,  93,  96
    MOVE G6B,100,40
    MOVE G6C,100,50
    WAIT
    
    SPEED 15
    MOVE G6A,110,  76, 145,  96, 100
    MOVE G6D, 87, 135,  28, 155, 113
    MOVE G6B,100,40
    MOVE G6C,100,70
    WAIT

    SPEED 8
    MOVE G6D, 87, 45,  130, 165, 110
    MOVE G6A,111,  77, 145,  86, 97
    MOVE G6B, 150, 30
    MOVE G6C, 100, 30
    WAIT 
    
    SPEED 10
    MOVE G6A, 110, 76, 145,  80, 94
    MOVE G6D, 90, 39,  135, 161, 112
    MOVE G6B, 150, 30
    MOVE G6C, 100, 30
    WAIT 
    
    SPEED 2
    MOVE G6A, 112, 78, 145,  83, 94
    MOVE G6D, 102, 39,  135, 154, 112
    MOVE G6B, 130, 30
    MOVE G6C, 100, 30
    WAIT 
   	
   	SPEED 2
   	MOVE G6A, 112, 78, 145,  83, 93
   	MOVE G6D, 94, 38,  135, 150, 112
   	WAIT
   	
    SPEED 4
    MOVE G6A, 103, 97, 147,  80, 94
    MOVE G6B, 110, 79
    MOVE G6D, 94, 38,  135, 150, 112
    MOVE G6C, 100, 30
    WAIT 
    
    SPEED 6
    MOVE G6B, 100, 30
    MOVE G6C, 110, 79
    MOVE G6D, 100, 50,  135, 150, 100
    MOVE G6A, 103, 104, 147,  70, 95
    
    SPEED 7
    MOVE G6B, 100, 46
    MOVE G6C, 110, 30
    MOVE G6D, 105, 30,  144, 165, 105
    MOVE G6A, 87, 120, 125,  98, 90
    WAIT
    
    SPEED 5
    MOVE G6D, 105, 30,  144, 170, 105
    MOVE G6A, 100, 135, 125,  98, 92
    WAIT
    
    SPEED 8
    MOVE G6B, 100, 46
    MOVE G6C, 100, 30
    MOVE G6D,114, 143,  28, 155,  94
    MOVE G6A, 87, 135,  28, 180, 105
    WAIT
    
	SPEED 8
	MOVE G6B, 100, 46
    MOVE G6C, 100, 30
	MOVE G6D,100, 143,  28, 155,  94
    MOVE G6A, 87, 135,  28, 180, 105
    WAIT
    
    SPEED 10
    GOSUB 기본자세
    RETURN
    '******************************************
계단오르자제발2걸음: 
	SPEED 4
    MOVE G6D, 88,  74, 144,  95, 110
    MOVE G6A,108,  76, 146,  93,  96
    MOVE G6B,100,40
    MOVE G6C,100,50
    WAIT
    
    SPEED 15
    MOVE G6A,114,  76, 145,  92, 100
    MOVE G6D, 87, 135,  28, 155, 113
    MOVE G6B,100,80
    MOVE G6C,100,50
    WAIT

    SPEED 7
    MOVE G6D, 87, 45,  130, 165, 110
    MOVE G6A,113,  77, 145,  86, 97
    MOVE G6B, 150, 30
    MOVE G6C, 100, 30
    WAIT 
    
    SPEED 10
    MOVE G6A, 113, 76, 145,  85, 94
    MOVE G6D, 90, 39,  135, 161, 112
    MOVE G6B, 150, 30
    MOVE G6C, 100, 30
    WAIT 
    
    SPEED 2
    MOVE G6A, 112, 78, 145,  83, 94
    MOVE G6D, 102, 39,  135, 154, 112
    MOVE G6B, 130, 30
    MOVE G6C, 100, 30
    WAIT 
   	
   	SPEED 2
   	MOVE G6A, 112, 78, 145,  83, 93
   	MOVE G6D, 94, 38,  135, 150, 112
   	WAIT
   	
    SPEED 5
    MOVE G6A, 103, 97, 147,  80, 94
    MOVE G6B, 110, 79
    MOVE G6D, 94, 38,  135, 150, 112
    MOVE G6C, 100, 30
    WAIT 
    
    SPEED 5
    MOVE G6B, 100, 30
    MOVE G6C, 110, 79
    MOVE G6D, 110, 50,  135, 150, 100
    MOVE G6A, 103, 104, 147,  70, 95
    
    SPEED 5
    MOVE G6B, 100, 46
    MOVE G6C, 110, 30
    MOVE G6D, 105, 30,  144, 165, 105
    MOVE G6A, 87, 120, 125,  98, 90
    WAIT
    
    SPEED 7
    MOVE G6D, 105, 30,  144, 170, 105
    MOVE G6A, 100, 135, 125,  98, 92
    WAIT
    
    SPEED 10
    MOVE G6B, 100, 46
    MOVE G6C, 100, 30
    MOVE G6D,110, 143,  28, 155,  94
    MOVE G6A, 87, 135,  28, 150, 105
    WAIT

    SPEED 7
    GOSUB 기본자세
    GOSUB 계단한걸음전진 
    GOSUB 계단한걸음전진 
    RETURN
    '******************************************
계단한걸음전진1:									 
    보행COUNT = 0
    보행속도 = 13
    좌우속도 = 4
    넘어진확인 = 0
    
    GOSUB Leg_motor_mode3
	SPEED 4

    MOVE G6A, 88,  74, 144,  95, 110
    MOVE G6D,108,  76, 146,  93,  96
    MOVE G6B,100
    MOVE G6C,100
    WAIT

    SPEED 10

    MOVE G6A, 90, 90, 120, 105, 110,100
    MOVE G6D,110,  76, 147,  93,  96,100
    MOVE G6B,90
    MOVE G6C,110
    WAIT
    
    SPEED 보행속도

    MOVE G6A, 86,  56, 145, 115, 110
    MOVE G6D,108,  76, 147,  93,  96
    WAIT


    SPEED 좌우속도
    GOSUB Leg_motor_mode3

    MOVE G6A,110,  76, 147, 93,  96
    MOVE G6D,86, 100, 145,  69, 110
    WAIT
    
    SPEED 보행속도

    GOSUB 앞뒤기울기측정
    IF 넘어진확인 = 1 THEN
        넘어진확인 = 0
    ENDIF
    
    
    MOVE G6A,110,  76, 147,  93, 96,100
    MOVE G6D,90, 90, 120, 105, 110,100
    MOVE G6B,110
    MOVE G6C,90
    WAIT
    
    SPEED 3
    GOSUB 기본자세2

    RETURN
    '**********************************************
계단내려가자제발:  

    SPEED 4 
    MOVE G6D, 88,  71, 152,  91, 110 '오른쪽발 안쪽으로
    MOVE G6A,108,  76, 145,  93,  94 '왼쪽다리
    MOVE G6B,100,40 '왼쪽팔
    MOVE G6C,100,40 '오른쪽팔
    WAIT

    SPEED 10 
    MOVE G6D, 90, 100, 115, 105, 114 '오른다리 들기
    MOVE G6A,113,  76, 145,  93,  94 '왼쪽발 바깥쪽으로
    WAIT

    SPEED 12
    MOVE G6D,  80, 30, 155, 150, 114 '오른다리 내딛기
    MOVE G6A, 113,  75, 145,  90,  94 '
    WAIT

    SPEED 5
    MOVE G6A, 113,  100, 95,  120,  94 ' 왼쪽다리 굽히기
    MOVE G6D,  80, 30, 175, 150, 114, '오른쪽다리 더내딛기
    MOVE G6B,140,40
    MOVE G6C,70,40
    WAIT

    SPEED 5
    MOVE G6A,110, 130, 65,  125,94
    MOVE G6D,85, 20, 160, 150, 110
    MOVE G6C,100,50
    MOVE G6B,140,50
    WAIT
    
    SPEED 5
    MOVE G6A,103, 140, 75,  115,94
    MOVE G6D,95, 12, 170, 150, 110
    MOVE G6C,100,100
    MOVE G6B,140,50
    WAIT

    '****************************
    
    SPEED 5
    MOVE G6D, 105, 30,  144, 170, 105
    MOVE G6A, 100, 135, 125,  98, 95
    WAIT
    
    SPEED 5
    MOVE G6D, 108, 30,  144, 170, 105
    WAIT
    
    SPEED 7
    MOVE G6B, 100, 46
    MOVE G6C, 100, 30
    MOVE G6D,114, 143,  28, 155,  94
    MOVE G6A, 87, 135,  28, 180, 105
    WAIT
    
    
	SPEED 10
    GOSUB 기본자세
    
    mode = 0
    WAIT
    RETURN
   '***********************************
복고댄스:

    DIM w1 AS BYTE
    GOSUB Leg_motor_mode2
    GOSUB Arm_motor_mode3

    SPEED 3
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  40,  80
    WAIT

    SPEED 5
    MOVE G6A, 85,  80, 140, 95, 114, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6B,100,  40,  90
    MOVE G6C,100,  40,  90
    WAIT


    SPEED 5
    MOVE G6A, 80,  74, 146, 94, 116, 100
    MOVE G6D,108,  81, 137,  98, 98, 100
    MOVE G6B,100,  70,  90
    MOVE G6C,100,  70,  90	
    WAIT

    SPEED 5
    MOVE G6A,94,  76, 145,  93, 106, 100
    MOVE G6D,94,  76, 145,  93, 106, 100
    MOVE G6B,100,  100,  100
    MOVE G6C,100,  100,  100
    WAIT	



    SPEED 4
    MOVE G6A,94,  94, 145,  45, 106
    MOVE G6D,94,  94, 145,  45, 106
    WAIT	

    HIGHSPEED SETON


    FOR I= 1 TO 3
        SPEED 6
        FOR w1= 0 TO 2

            MOVE G6B,100,  150,  140,
            MOVE G6C,100,  100,  190,
            MOVE G6A, 95,  94, 145,  45, 107,
            MOVE G6D, 89,  94, 145,  45, 113,
            WAIT

            MOVE G6C,100,  150,  140,
            MOVE G6B,100,  100,  190,
            MOVE G6D, 95,  94, 145,  45, 107,
            MOVE G6A, 89,  94, 145,  45, 113,
            WAIT

        NEXT w1

        SPEED 12
        MOVE G6C,100,  100,  190,
        MOVE G6B,100,  75,  100,
        MOVE G6A, 95,  94, 145,  45, 107,
        MOVE G6D, 89,  94, 145,  45, 113,
        WAIT

        SPEED 12
        MOVE G6C,100,  150,  140,
        MOVE G6B,100,  100,  100,
        MOVE G6D, 95,  94, 145,  45, 107,
        MOVE G6A, 89,  94, 145,  45, 113,
        WAIT

        DELAY 200
        SPEED 6
        FOR w1= 0 TO 2


            MOVE G6B,100,  150,  140,
            MOVE G6C,100,  100,  190,
            MOVE G6A, 95,  94, 145,  45, 107,
            MOVE G6D, 89,  94, 145,  45, 113,
            WAIT

            MOVE G6C,100,  150,  140,
            MOVE G6B,100,  100,  190,
            MOVE G6D, 95,  94, 145,  45, 107,
            MOVE G6A, 89,  94, 145,  45, 113,
            WAIT

        NEXT w1

        SPEED 15
        MOVE G6B,100,  100,  190,
        MOVE G6C,100,  75,  100,
        MOVE G6D, 89,  94, 145,  45, 113,
        MOVE G6A, 95,  94, 145,  45, 107,
        WAIT

        SPEED 12
        MOVE G6B,100,  150,  140,
        MOVE G6C,100,  100,  100,
        MOVE G6D, 95,  94, 145,  45, 107,
        MOVE G6A, 89,  94, 145,  45, 113,
        WAIT

        DELAY 100
    NEXT I
    HIGHSPEED SETOFF

    GOSUB Arm_motor_mode3	
    GOSUB Leg_motor_mode1
    SPEED 15
    MOVE G6A,100,  76, 145,  93, 98, 100
    MOVE G6D,100,  76, 145,  93, 98, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT
    SPEED 5
    DELAY 50
    GOSUB 기본자세


    RETURN

    '************************************************
샹송백댄서2:

    GOSUB All_motor_mode3


    '오른쪽기울기2:
    SPEED 3
    MOVE G6A, 88,  71, 152,  91, 110, '60
    MOVE G6D,108,  76, 146,  93,  92, '60
    MOVE G6B,100,  40,  80, 100, 100, 100
    MOVE G6C,100,  40,  80, 100, 100, 100
    WAIT

    SPEED 5
    MOVE G6A, 85,  80, 140, 95, 114, 100
    MOVE G6D,112,  76, 146,  93, 98, 100
    MOVE G6B,100,  40,  90, 100, 100, 100
    MOVE G6C,100,  40,  90, 100, 100, 100
    WAIT


    SPEED 5
    MOVE G6A, 80,  74, 146, 94, 116, 100
    MOVE G6D,108,  81, 137,  98, 98, 100
    MOVE G6B,100,  70,  90, 100, 100, 100
    MOVE G6C,100,  70,  90, 100, 100, 100 	
    WAIT

    SPEED 4
    MOVE G6A,98,  76, 145,  93, 103, 100
    MOVE G6D,98,  76, 145,  93, 103, 100
    MOVE G6B,100,  100,  100, 100, 100, 100
    MOVE G6C,100,  100,  100, 100, 100, 100
    WAIT	



    '**** 노래시작자세******
    SPEED 3
    MOVE G6A,98,  76, 145,  93, 103, 100
    MOVE G6D,98,  76, 145,  93, 103, 100
    WAIT

    '**********************************
    FOR i = 0 TO 3
        SPEED 4
        MOVE G6A,108,  92, 119,  106, 99
        MOVE G6D,86,  76, 145,  94, 107
        WAIT

        SPEED 4
        MOVE G6A,102,  78, 139,  98, 84
        MOVE G6D,92,  90, 115,  110, 122
        WAIT

        SPEED 4
        MOVE G6D,108,  92, 119,  106, 99
        MOVE G6A,86,  76, 145,  94, 107
        WAIT

        SPEED 4
        MOVE G6D,102,  78, 139,  98, 84
        MOVE G6A,92,  90, 115,  110, 122
        WAIT

    NEXT i

    SPEED 3
    MOVE G6A,108,  92, 119,  106, 99
    MOVE G6D,86,  76, 145,  94, 107
    MOVE G6B,, , , , ,80
    WAIT

    GOSUB Leg_motor_mode1
    SPEED 4
    MOVE G6A,98,  76, 145,  93, 98, 100
    MOVE G6D,98,  76, 145,  93, 98, 100
    MOVE G6B,100,  100,  100, 100, 100, 100
    MOVE G6C,100,  100,  100, 100, 100, 100
    WAIT



    SPEED 6
    GOSUB 기본자세

    GOSUB All_motor_Reset


    RETURN
    '******************************************
환호성:
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode2
    SPEED 15
    MOVE G6A,100,  80, 145,  75, 100
    MOVE G6D,100,  80, 145,  75, 100
    MOVE G6B,100,  180,  120
    MOVE G6C,100,  180,  120
    WAIT	

    SPEED 10
    FOR i = 1 TO 2

        MOVE G6B,100,  145,  100
        MOVE G6C,100,  145,  100
        WAIT

        MOVE G6B,100,  180,  130
        MOVE G6C,100,  180,  130
        WAIT	
    NEXT i
    DELAY 200
    SPEED 8
    GOSUB 기본자세
    GOSUB All_motor_Reset
    RETURN
    ''************************************************
승리세레모니1:
    GOSUB Arm_motor_mode3
    GOSUB Leg_motor_mode2
    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  180,  120
    MOVE G6C,100,  180,  120
    WAIT	

    SPEED 10
    FOR i = 1 TO 3

        MOVE G6B,100,  145,  100
        MOVE G6C,100,  145,  100
        WAIT

        MOVE G6B,100,  180,  130
        MOVE G6C,100,  180,  130
        WAIT	
    NEXT i
    DELAY 200
    SPEED 8
    GOSUB 기본자세
    GOSUB All_motor_Reset
    RETURN
    ''************************************************
승리세레모니2:
    SPEED 10
    GOSUB 기본자세
    GOSUB All_motor_mode3

    SPEED 8

    MOVE G6A, 100, 163,  75,  15, 100
    MOVE G6D, 100, 163,  75,  15, 100
    MOVE G6B,185, 100, 90
    MOVE G6C,185, 100, 90
    WAIT

    SPEED 2

    MOVE G6A, 100, 165,  70,  10, 100, 100
    MOVE G6D, 100, 165,  70,  10, 100, 100
    MOVE G6B,185, 100, 90
    MOVE G6C,185, 100, 90
    WAIT

    DELAY 400
    SPEED 15
    FOR I = 1 TO 5

        MOVE G6B,185, 20, 50
        MOVE G6C,185, 20, 50
        WAIT

        MOVE G6B,185, 70, 80
        MOVE G6C,185, 70, 80
        WAIT

    NEXT I

    MOVE G6B,100, 70, 80
    MOVE G6C,100, 70, 80
    WAIT

    GOSUB Leg_motor_mode2
    SPEED 8
    MOVE G6A, 100, 145,  70,  80, 100, 100
    MOVE G6D, 100, 145,  70,  80, 100, 100
    MOVE G6B,100, 40, 90
    MOVE G6C,100, 40, 90
    WAIT

    SPEED 8
    MOVE G6A,100, 121,  80, 110, 101, 100
    MOVE G6D,100, 121,  80, 110, 101, 100
    MOVE G6B,100,  40,  80, , ,
    MOVE G6C,100,  40,  80, , ,
    WAIT

    SPEED 8
    GOSUB 기본자세
    GOSUB All_motor_Reset
    RETURN
    ''************************************************
    ''************************************************
승리세레모니3:
    GOSUB All_motor_mode3
    SPEED 15
    MOVE G6A,100,  76, 145,  93, 100
    MOVE G6D,100,  76, 145,  93, 100
    MOVE G6B,100,  40,  80
    MOVE G6C,100,  180,  120
    WAIT	

    SPEED 10
    FOR i = 1 TO 4

        MOVE G6C,100,  145,  100
        WAIT

        MOVE G6C,100,  180,  130
        WAIT	
    NEXT i
    DELAY 200
    SPEED 8
    GOSUB 기본자세
    GOSUB All_motor_Reset

    RETURN
    ''************************************************
인사1:

    GOSUB All_motor_mode3
    SPEED 6
    MOVE G6A,100,  70, 125, 150, 100
    MOVE G6D,100,  70, 125, 150, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    DELAY 1000
    SPEED 6
    GOSUB 기본자세
    GOSUB All_motor_Reset
    RETURN
    '************************************************
인사2:
    GOSUB All_motor_mode3
    SPEED 4
    MOVE G6A, 108,  76, 146,  93,  94
    MOVE G6D,  88,  71, 152,  91, 110
    MOVE G6B,110,  30,  80
    MOVE G6C,90,  30,  80
    WAIT

    SPEED 8
    MOVE G6D, 90, 95, 115, 105, 112
    MOVE G6A,113,  76, 146,  93,  94
    MOVE G6B,130,  30,  80
    MOVE G6C,75,  30,  80
    WAIT

    SPEED 8
    MOVE G6A,112,  86, 120, 120,  94
    MOVE G6D,90, 100, 155,  71, 112
    MOVE G6B,140,  30,  80
    MOVE G6C,70,  30,  80
    WAIT


    SPEED 10
    MOVE G6A,108,  85, 110, 140,  94
    MOVE G6D,85, 97, 145,  91, 112
    MOVE G6B,150,  20,  40
    MOVE G6C,60,  30,  80
    WAIT

    DELAY 1000
    '*******************
    GOSUB leg_motor_mode2
    SPEED 6
    MOVE G6D, 90, 95, 115, 105, 110
    MOVE G6A,114,  76, 146,  93,  96
    MOVE G6B,130,  30,  80
    MOVE G6C,75,  30,  80
    WAIT

    SPEED 8
    MOVE G6A, 108,  76, 146,  93,  94
    MOVE G6D,  88,  71, 152,  91, 110
    MOVE G6B,110,  30,  80
    MOVE G6C,90,  30,  80
    WAIT

    SPEED 3
    GOSUB 기본자세
    GOSUB All_motor_Reset
    RETURN
    '************************************************


인사3:
    GOSUB All_motor_mode3

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  70,  80
    MOVE G6B,160,  35,  80
    WAIT

    SPEED 10
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    '인사
    SPEED 8
    MOVE G6A,100,  55, 145,  145, 100, 100
    MOVE G6D,100,  55, 145,  145, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    DELAY 1000
    '일어나기
    SPEED 6
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    SPEED 8
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6C,100,  70,  80
    MOVE G6B,160,  40,  80
    WAIT

    SPEED 10
    GOSUB 기본자세
    GOSUB All_motor_Reset


    RETURN
    '************************************************ 
곡선전진종종걸음:
    곡선방향 = 2
    SPEED 10
    HIGHSPEED SETON
    GOSUB All_motor_mode3


    IF 보행순서 = 0 THEN
        보행순서 = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO 곡선전진종종걸음_1
    ELSE
        보행순서 = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO 곡선전진종종걸음_4
    ENDIF



    '**********************

곡선전진종종걸음_1:
    SPEED 8
    MOVE G6A,95,  95, 120, 100, 104
    MOVE G6D,104,  77, 146,  91,  102
    MOVE G6B, 85
    MOVE G6C,115
    WAIT


곡선전진종종걸음_3:
    SPEED 8
    MOVE G6A,103,   71, 140, 105,  100
    MOVE G6D, 95,  82, 146,  87, 102
    WAIT


    ERX 4800, A ,곡선전진종종걸음_4_0

    IF A = 20 THEN
        곡선방향 = 3
    ELSEIF A = 43 THEN
        곡선방향 = 1
    ELSEIF A = 11 THEN
        곡선방향 = 2
    ELSE  '정지
        GOTO 곡선전진종종걸음_3멈춤
    ENDIF

곡선전진종종걸음_4_0:

    IF  곡선방향 = 1 THEN'왼쪽

    ELSEIF  곡선방향 = 3 THEN'오른쪽
        HIGHSPEED SETOFF
        SPEED 8
        MOVE G6D,103,   71, 140, 105,  100
        MOVE G6A, 95,  82, 146,  87, 102
        WAIT
        HIGHSPEED SETON
        GOTO 곡선전진종종걸음_1

    ENDIF



    '*********************************

곡선전진종종걸음_4:
    SPEED 8
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 146,  91,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT


곡선전진종종걸음_6:
    SPEED 8
    MOVE G6D,103,   71, 140, 105,  100
    MOVE G6A, 95,  82, 146,  87, 102
    WAIT



    ERX 4800, A ,곡선전진종종걸음_1_0

    IF A = 20 THEN
        곡선방향 = 3
    ELSEIF A = 43 THEN
        곡선방향 = 1
    ELSEIF A = 11 THEN
        곡선방향 = 2
    ELSE  '정지
        GOTO 곡선전진종종걸음_6멈춤
    ENDIF

곡선전진종종걸음_1_0:

    IF  곡선방향 = 1 THEN'왼쪽
        HIGHSPEED SETOFF
        SPEED 8
        MOVE G6A,103,   71, 140, 105,  100
        MOVE G6D, 95,  82, 146,  87, 102
        WAIT
        HIGHSPEED SETON
        GOTO 곡선전진종종걸음_4
    ELSEIF 곡선방향 = 3 THEN'오른쪽


    ENDIF



    GOTO 곡선전진종종걸음_1
    '******************************************
    '******************************************
    '*********************************
곡선전진종종걸음_3멈춤:
    MOVE G6D,95,  90, 125, 95, 104
    MOVE G6A,104,  76, 145,  91,  102
    MOVE G6C, 100
    MOVE G6B,100
    WAIT
    HIGHSPEED SETOFF
    SPEED 15
    GOSUB 안정화자세
    SPEED 10
    GOSUB 기본자세
    GOTO MAIN	
    '******************************************
곡선전진종종걸음_6멈춤:
    MOVE G6A,95,  90, 125, 95, 104
    MOVE G6D,104,  76, 145,  91,  102
    MOVE G6B, 100
    MOVE G6C,100
    WAIT
    HIGHSPEED SETOFF
    SPEED 15
    GOSUB 안정화자세
    SPEED 10
    GOSUB 기본자세
    GOTO MAIN	
    '******************************************
    '******************************************************

	'----------------------------------------------------
터널지나기:

    GOSUB All_motor_mode3
    GOSUB 자이로OFF

    SERVO 16, 120

   	WAIT
    SPEED 5
    MOVE G6A, 100, 163,  75,  15, 100, 100
    MOVE G6D, 100, 163,  75,  15, 100, 100
    MOVE G6B,90, 30, 80, 100, 100, 100
    MOVE G6C,90, 30, 80, 100, 100, 100
    WAIT
    SPEED 15
    MOVE G6B,90, 150, 95, 100, 100, 100
    MOVE G6C,90, 150, 95, 100, 100, 100
    WAIT
    SPEED 15
    MOVE G6A, 100, 163,  75,  15, 100, 100
    MOVE G6D, 100, 163,  75,  15, 100, 100
    MOVE G6B,10, 10, 95, 100, 100, 100
    MOVE G6C,10, 10, 95, 100, 100, 100
    WAIT
    
FOR i = 0 TO 6
	SERVO 16, 120
    SPEED 15
    MOVE G6C,10,20, 105, 100, 100, 100
    MOVE G6B,10, 20, 105, 100, 100, 100
    MOVE G6A, 100, 167,  27,  33, 100, 100
    MOVE G6D, 100, 167,  27,  33, 100, 100

    WAIT
    
    SPEED 15
    MOVE G6B,40, 35, 105, 100, 100, 100
    MOVE G6C,40, 35, 105, 100, 100, 100
    MOVE G6A, 100, 167,  27,  33, 100, 100
    MOVE G6D, 100, 167,  27,  33, 100, 100
    
    WAIT
    
    SPEED 15
    MOVE G6C,20, 30, 105, 100, 100, 100
    MOVE G6B,20, 30, 105, 100, 100, 100
    MOVE G6A, 100, 167,  27,  33, 100, 100
    MOVE G6D, 100, 167,  27,  33, 100, 100    
    
    WAIT
    
    SPEED 15
    MOVE G6B,10, 20, 105, 100, 100, 100
    MOVE G6C,10,20, 105, 100, 100, 100
    MOVE G6A, 100, 167,  27,  33, 100, 100
    MOVE G6D, 100, 167,  27,  33, 100, 100

    WAIT
   
    SPEED 15
    MOVE G6C,40, 35, 105, 100, 100, 100
    MOVE G6B,40, 35, 105, 100, 100, 100
    MOVE G6A, 100, 167,  27,  33, 100, 100
    MOVE G6D, 100, 167,  27,  33, 100, 100
    
    WAIT
   
    SPEED 15
    MOVE G6B,20, 30, 105, 100, 100, 100
    MOVE G6C,20, 30, 105, 100, 100, 100
    MOVE G6A, 100, 167,  27,  33, 100, 100
    MOVE G6D, 100, 167,  27,  33, 100, 100  
    WAIT
    
    SERVO 16, 120
    SPEED 15
    MOVE G6C,10,20, 105, 100, 100, 100
    MOVE G6B,10, 20, 105, 100, 100, 100
    MOVE G6A, 100, 167,  27,  33, 100, 100
    MOVE G6D, 100, 167,  27,  33, 100, 100

    WAIT
    
    SPEED 15
    MOVE G6B,40, 35, 105, 100, 100, 100
    MOVE G6C,40, 35, 105, 100, 100, 100
    MOVE G6A, 100, 167,  27,  33, 100, 100
    MOVE G6D, 100, 167,  27,  33, 100, 100
    
    WAIT
    
    SPEED 15
    MOVE G6C,20, 30, 105, 100, 100, 100
    MOVE G6B,20, 30, 105, 100, 100, 100
    MOVE G6A, 100, 167,  27,  33, 100, 100
    MOVE G6D, 100, 167,  27,  33, 100, 100    
    
    WAIT
    
    SPEED 15
    MOVE G6B,10, 20, 105, 100, 100, 100
    MOVE G6C,10,20, 105, 100, 100, 100
    MOVE G6A, 100, 167,  27,  33, 100, 100
    MOVE G6D, 100, 167,  27,  33, 100, 100

    WAIT
   
    SPEED 15
    MOVE G6C,40, 35, 105, 100, 100, 100
    MOVE G6B,40, 35, 105, 100, 100, 100
    MOVE G6A, 100, 167,  27,  33, 100, 100
    MOVE G6D, 100, 167,  27,  33, 100, 100
    
    WAIT
   
    SPEED 15
    MOVE G6B,20, 30, 105, 100, 100, 100
    MOVE G6C,20, 30, 105, 100, 100, 100
    MOVE G6A, 100, 167,  27,  33, 100, 100
    MOVE G6D, 100, 167,  27,  33, 100, 100  
    WAIT
    '
    SPEED 15
    MOVE G6B,10, 20, 105, 100, 100, 100
    WAIT
    MOVE G6B,40, 35, 105, 100, 100, 100
    WAIT
    MOVE G6B,20, 30, 105, 100, 100, 100
    WAIT
NEXT i    
    HIGHSPEED SETOFF
    GOSUB 자이로ON
    
    단계= 2
    RETURN 
    '***********************************
MAIN: '라벨설정
	
MAIN_2:

    GOSUB 앞뒤기울기측정
    GOSUB 좌우기울기측정
	
    ERX 4800,A,MAIN_2	

    A_old = A

    '**** 입력된 A값이 0 이면 MAIN 라벨로 가고
    '**** 1이면 KEY1 라벨, 2이면 key2로... 가는문
    ON A GOTO MAIN,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18 ,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28 ,KEY29,KEY30,KEY31,KEY32

    IF A = 219 THEN
        SERVO 16, 100
        ETX 4800,219
        GOTO RX_EXIT
        '4단계 고개 들기

    ELSEIF A = 215 THEN
        SERVO 16, 25
        SERVO 11, 100
        GOSUB 한번후진 
        ETX 4800,215
        GOTO RX_EXIT
    ELSEIF A = 217 THEN
        SERVO 16, 20
        SERVO 11, 100
        WAIT
        GOSUB 오른쪽턴45
        WAIT
        ETX 4800,217
        GOTO RX_EXIT
    ELSEIF A = 218 THEN
        SERVO 16, 20
        SERVO 11, 100
        GOSUB 왼쪽턴45 
        ETX 4800,218
        GOTO RX_EXIT
	ELSEIF A = 220 THEN
        SERVO 16, 25
        SERVO 11, 100
        ETX 4800,220
        GOTO RX_EXIT
        '고개 들기
    ELSEIF A = 221 THEN
        SERVO 16, 15
        SERVO 11, 100
        ETX 4800,221
        GOTO RX_EXIT
        '고개 내리기
    ELSEIF A = 222 THEN
        SERVO 16, 20
        SERVO 11, 100
        GOSUB 횟수_전진종종걸음
        ETX 4800, 222
        GOTO RX_EXIT
    ELSEIF A = 223 THEN
    	SERVO 16, 50
    	SERVO 11, 100
    	GOSUB 머리왼쪽45도
    	ETX 4800, 223
    	GOTO RX_EXIT
    ELSEIF A = 224 THEN
    	SERVO 16,50
    	SERVO 11, 100
    	GOSUB 머리오른쪽45도
    	ETX 4800,224
    	GOTO RX_EXIT
    ELSEIF A = 225 THEN
    	SERVO 16,20
    	SERVO 11, 100
    	GOSUB 머리좌우중앙
    	ETX 4800, 225
    	GOTO RX_EXIT
    ELSEIF A = 226 THEN
    	SERVO 16,70
    	SERVO 11, 100
    	GOSUB 머리왼쪽60도
    	ETX 4800, 226
    	GOTO RX_EXIT
    ELSEIF A = 227 THEN
    	SERVO 16,70
    	SERVO 11, 100
    	GOSUB 머리오른쪽60도
    	ETX 4800, 227
    	GOTO RX_EXIT
    ELSEIF A = 228 THEN
    	SERVO 16, 20
    	SERVO 11, 100
    	GOSUB 적외선거리센서확인
    	GOTO RX_EXIT
    ELSEIF A = 229 THEN
    	SERVO 16,20
    	SERVO 11, 100
    	GOSUB 왼발차기
    	ETX 4800, 229
    	GOTO RX_EXIT
   '-------------------------------------------
   	ELSEIF A = 231 THEN
        SERVO 16, 20
        SERVO 11, 100
        GOSUB 오른쪽옆으로70
        ETX 4800,231
        GOTO RX_EXIT
   	ELSEIF A = 232 THEN
        SERVO 16, 20
        SERVO 11, 100
        GOSUB 가뿌자  
        ETX 4800, 232
        GOTO RX_EXIT
    ELSEIF A = 233 THEN
        SERVO 16, 20
        SERVO 11, 100
        GOSUB 왼쪽옆으로70
        ETX 4800,233
        GOTO RX_EXIT
    ELSEIF A = 234 THEN
    	SERVO 11, 100
        SERVO 16, 20
        GOSUB 기본자세
        WAIT
        ETX 4800, 234
        GOTO RX_EXIT
    ELSEIF A = 235 THEN
        SERVO 16, 20
        SERVO 11, 100
        GOSUB 왼쪽턴20
        ETX 4800, 235
        GOTO RX_EXIT
    ELSEIF A = 236 THEN
        SERVO 16, 20
        SERVO 11, 100
        GOSUB 오른쪽턴20
        ETX 4800, 236
        GOTO RX_EXIT
	ELSEIF A = 237 THEN
        SERVO 16, 15
        SERVO 11, 100
        GOSUB 계단오르자제발
        ETX 4800, 237
        GOTO RX_EXIT
    ELSEIF A = 238 THEN
        SERVO 16, 15
        SERVO 11, 100
        GOSUB 계단오르자제발2걸음
        ETX 4800, 238
        GOTO RX_EXIT
    ELSEIF A = 239 THEN
        GOSUB 터널지나기 
        SERVO 11, 100
        ETX 4800,239
        GOTO RX_EXIT
'---------------------------------------------
    ELSEIF A = 240 THEN
        GOSUB 전진앉아보행
        ETX 4800,240
        GOTO RX_EXIT
	ELSEIF A = 241 THEN
		SERVO 16, 20
		SERVO 11, 100
		GOSUB 문열어뿌자 
		ETX 4800, 241
		GOTO RX_EXIT
	ELSEIF A = 242 THEN
		SERVO 11, 100
		GOSUB 벨브 
		ETX 4800,242
		GOTO RX_EXIT
	ELSEIF A = 243 THEN
		SERVO 16, 20
		SERVO 11, 100
		GOSUB 계단내려가자제발
		ETX 4800, 243
		GOTO RX_EXIT
	ELSEIF A = 246 THEN
		GOSUB 왼쪽옆으로20 
		SERVO 11, 100
		ETX 4800,246
		GOTO RX_EXIT
	ELSEIF A = 247 THEN
		GOSUB 오른쪽옆으로20 
		SERVO 11, 100
		ETX 4800,247
		GOTO RX_EXIT
	ELSEIF A = 248 THEN
		GOSUB 한걸음전진 
		SERVO 11, 100
		ETX 4800,248
		GOTO RX_EXIT	
	ELSEIF A = 249 THEN
		GOSUB 전진달리기fast
		SERVO 11, 100
		ETX 4800,249
		GOTO RX_EXIT
	'******************************************8
	ELSEIF A = 250 THEN
		GOSUB 왼쪽턴60
		SERVO 11, 100
		ETX 4800,250
		GOTO RX_EXIT
	ELSEIF A = 251 THEN
		GOSUB 오른쪽턴60 
		SERVO 11, 100
		ETX 4800,251
		GOTO RX_EXIT
	ELSEIF A = 252 THEN
		GOSUB 코너인식3
		SERVO 11, 100
		ETX 4800,252
		GOTO RX_EXIT	
	ELSEIF A = 253 THEN
		GOSUB 코너인식2  
		SERVO 11, 100
		ETX 4800,253
		GOTO RX_EXIT	
	ELSEIF A = 254 THEN
		GOSUB 전진달리기slow
		SERVO 11, 100
		ETX 4800,254
		GOTO RX_EXIT
	ENDIF
	
	' 림보걸음 , 전진앉아걷기 는 타임.슬립 주기 !!!

    GOTO MAIN	
    '*******************************************
    '		MAIN 라벨로 가기
    '*******************************************

KEY1:
	GOSUB 벨브 
    GOTO RX_EXIT
    '***************	
KEY2:
	GOSUB 문열어뿌자 
    GOTO RX_EXIT
    '***************
KEY3:
    GOSUB 한번후진 
    GOTO RX_EXIT
    '***************
KEY4: 
	GOSUB 한걸음전진  
    GOTO RX_EXIT
    '***************
KEY5:

	GOSUB 가뿌자
	
   

    GOTO RX_EXIT
    '***************
KEY6:
  
    GOSUB 계단오르자제발 

    GOTO RX_EXIT
    '***************
KEY7:
 	GOSUB 전진달리기slow

    GOTO RX_EXIT
    '***************
KEY8:

    GOSUB 왼쪽턴20

    GOTO RX_EXIT
    '***************
KEY9:

  


    GOTO RX_EXIT
    '***************
KEY10: '0

    GOTO 터널지나기 

    GOTO RX_EXIT
    '***************
KEY11: ' ▲
 

    GOTO 계단내려가자제발 

    GOTO RX_EXIT
    '***************
KEY12: ' ▼
 
    GOTO 연속후진

    GOTO RX_EXIT
    '***************
KEY13: '▶
   
    GOTO 오른쪽옆으로70


    GOTO RX_EXIT
    '***************
KEY14: ' ◀
   
    GOTO 왼쪽옆으로70


    GOTO RX_EXIT
    '***************
KEY15: ' A
  
    GOTO 왼쪽옆으로20


    GOTO RX_EXIT
    '***************
KEY16: ' POWER
   
    GOSUB Leg_motor_mode3
    IF MODE = 0 THEN
        SPEED 10
        MOVE G6A,100, 140,  37, 145, 100, 100
        MOVE G6D,100, 140,  37, 145, 100, 100
        WAIT
    ENDIF
    SPEED 4
    GOSUB 앉은자세	
    GOSUB 종료음

    GOSUB GOSUB_RX_EXIT
KEY16_1:

    IF 모터ONOFF = 1  THEN
        OUT 52,1
        DELAY 200
        OUT 52,0
        DELAY 200
    ENDIF
    ERX 4800,A,KEY16_1
    ETX  4800,A
    IF  A = 16 THEN 	'다시 파워버튼을 눌러야만 복귀
        SPEED 10
        MOVE G6A,100, 140,  37, 145, 100, 100
        MOVE G6D,100, 140,  37, 145, 100, 100
        WAIT
        GOSUB Leg_motor_mode2
        GOSUB 기본자세2
        GOSUB 자이로ON
        GOSUB All_motor_mode3
        GOTO RX_EXIT
    ENDIF

    GOSUB GOSUB_RX_EXIT
    GOTO KEY16_1



    GOTO RX_EXIT
    '***************
KEY17: ' C
    ETX  4800,17
    GOTO 머리왼쪽90도


    GOTO RX_EXIT
    '***************
KEY18: ' E
    ETX  4800,18	

    GOSUB 자이로OFF
    GOSUB 에러음
KEY18_wait:

    ERX 4800,A,KEY18_wait	

    IF  A = 26 THEN
        GOSUB 시작음
        GOSUB 자이로ON
        GOTO RX_EXIT
    ENDIF

    GOTO KEY18_wait


    GOTO RX_EXIT
    '***************
KEY19: ' P2
    ETX  4800,19
    GOTO 오른쪽턴60

    GOTO RX_EXIT
    '***************
KEY20: ' B	
    ETX  4800,20
    GOTO 오른쪽옆으로20


    GOTO RX_EXIT
    '***************
KEY21: ' △
    ETX  4800,21
    GOTO 머리좌우중앙

    GOTO RX_EXIT
    '***************
KEY22: ' *	
    ETX  4800,22
    GOTO 왼쪽턴45

    GOTO RX_EXIT
    '***************
KEY23: ' G
    ETX  4800,23
    GOSUB 에러음
    GOSUB All_motor_mode2
KEY23_wait:


    ERX 4800,A,KEY23_wait	

    IF  A = 26 THEN
        GOSUB 시작음
        GOSUB All_motor_mode3
        GOTO RX_EXIT
    ENDIF

    GOTO KEY23_wait


    GOTO RX_EXIT
    '***************
KEY24: ' #
    ETX  4800,24
    GOTO 오른쪽턴45

    GOTO RX_EXIT
    '***************
KEY25: ' P1
    ETX  4800,25
    GOTO 왼쪽턴60

    GOTO RX_EXIT
    '***************
KEY26: ' ■
    ETX  4800,26

    SPEED 5
    GOSUB 기본자세2	
    TEMPO 220
    MUSIC "ff"
    GOSUB 기본자세
    GOTO RX_EXIT
    '***************
KEY27: ' D
    ETX  4800,27
    GOTO 머리오른쪽90도


    GOTO RX_EXIT
    '***************
KEY28: ' ◁
    ETX  4800,28
    GOTO 머리왼쪽45도


    GOTO RX_EXIT
    '***************
KEY29: ' □
    ETX  4800,29

    GOSUB 전방하향80도

    GOTO RX_EXIT
    '***************
KEY30: ' ▷
    ETX  4800,30
    GOTO 머리오른쪽45도

    GOTO RX_EXIT
    '***************
KEY31: ' ▽
    ETX  4800,31
    GOSUB 전방하향60도

    GOTO RX_EXIT
    '***************

KEY32: ' F
    ETX  4800,32
    GOTO 후진종종걸음
    GOTO RX_EXIT
    '***************
