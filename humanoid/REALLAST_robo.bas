'******** 2�� ����κ� �ʱ� ���� ���α׷� ********

DIM I AS BYTE
DIM J AS BYTE
DIM MODE AS BYTE
DIM A AS BYTE
DIM A_old AS BYTE
DIM B AS BYTE
DIM C AS BYTE
DIM ����ӵ� AS BYTE
DIM �¿�ӵ� AS BYTE
DIM �¿�ӵ�2 AS BYTE
DIM ������� AS BYTE
DIM �������� AS BYTE
DIM ����üũ AS BYTE
DIM ����ONOFF AS BYTE
DIM ���̷�ONOFF AS BYTE
DIM ����յ� AS INTEGER
DIM �����¿� AS INTEGER
DIM �ڼ� AS BYTE
DIM ����� AS BYTE
DIM �н�Ʈ�߼��� AS BYTE
DIM ���ο�߼��� AS BYTE
DIM �߼��� AS BYTE
DIM �Ѿ���Ȯ�� AS BYTE
DIM ����Ȯ��Ƚ�� AS BYTE
DIM ����Ƚ�� AS BYTE
DIM ����COUNT AS BYTE
DIM �ܰ� AS BYTE
DIM ���ܼ��Ÿ���  AS BYTE
DIM �¿� AS BYTE

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

'**** ���⼾����Ʈ ���� ****
CONST �յڱ���AD��Ʈ = 0
CONST �¿����AD��Ʈ = 1
CONST ����Ȯ�νð� = 20  'ms


CONST min = 61	'�ڷγѾ�������
CONST max = 107	'�����γѾ�������
CONST COUNT_MAX = 3


CONST �Ӹ��̵��ӵ� = 10
'************************************************



PTP SETON 				'�����׷캰 ���������� ����
PTP ALLON				'��ü���� ������ ���� ����

DIR G6A,1,0,0,1,0,0		'����0~5��
DIR G6D,0,1,1,0,1,1		'����18~23��
DIR G6B,1,1,1,1,1,1		'����6~11��
DIR G6C,0,0,0,0,1,0		'����12~17��

'************************************************

OUT 52,0	'�Ӹ� LED �ѱ�
'***** �ʱ⼱�� '************************************************

������� = 0
����üũ = 0
����Ȯ��Ƚ�� = 0
����Ƚ�� = 1
����ONOFF = 0
�ܰ� = 0
�¿� = 0
���ο�߼���= 0 
�н�Ʈ�߼���= 0
�߼���= 0
'****�ʱ���ġ �ǵ��*****************************


TEMPO 230
MUSIC "cdefg"



SPEED 5
GOSUB MOTOR_ON

S11 = MOTORIN(11)
S16 = MOTORIN(16)

SERVO 11, 100
SERVO 16, S16



GOSUB �����ʱ��ڼ�
GOSUB �⺻�ڼ�


GOSUB ���̷�INIT
GOSUB ���̷�MID
GOSUB ���̷�ON



PRINT "VOLUME 200 !"
PRINT "SOUND 12 !" '�ȳ��ϼ���

GOSUB All_motor_mode3



GOTO MAIN	'�ø��� ���� ��ƾ���� ����

'************************************************

'*********************************************
' Infrared_Distance = 60 ' About 20cm
' Infrared_Distance = 50 ' About 25cm
' Infrared_Distance = 30 ' About 45cm
' Infrared_Distance = 20 ' About 65cm
' Infrared_Distance = 10 ' About 95cm
'*********************************************
'************************************************
������:
    TEMPO 220
    MUSIC "O23EAB7EA>3#C"
    RETURN
    '************************************************
������:
    TEMPO 220
    MUSIC "O38GD<BGD<BG"
    RETURN
    '************************************************
������:
    TEMPO 250
    MUSIC "FFF"
    RETURN
    '************************************************
    '************************************************
MOTOR_ON: '����Ʈ�������ͻ�뼳��

    GOSUB MOTOR_GET

    MOTOR G6B
    DELAY 50
    MOTOR G6C
    DELAY 50
    MOTOR G6A
    DELAY 50
    MOTOR G6D

    ����ONOFF = 0
    GOSUB ������			
    RETURN

    '************************************************
    '����Ʈ�������ͻ�뼳��
MOTOR_OFF:

    MOTOROFF G6B
    MOTOROFF G6C
    MOTOROFF G6A
    MOTOROFF G6D
    ����ONOFF = 1	
    GOSUB MOTOR_GET	
    GOSUB ������	
    RETURN
    '************************************************
    '��ġ���ǵ��
MOTOR_GET:
    GETMOTORSET G6A,1,1,1,1,1,0
    GETMOTORSET G6B,1,1,1,0,0,1
    GETMOTORSET G6C,1,1,1,0,1,0
    GETMOTORSET G6D,1,1,1,1,1,0
    RETURN

    '************************************************
    '��ġ���ǵ��
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
    '**** ���̷ΰ��� ���� ****
���̷�INIT:

    GYRODIR G6A, 0, 0, 1, 0,0
    GYRODIR G6D, 1, 0, 1, 0,0

    GYROSENSE G6A,200,150,30,150,0
    GYROSENSE G6D,200,150,30,150,0

    RETURN
    '***********************************************
    '**** ���̷ΰ��� ���� ****
���̷�MAX:

    GYROSENSE G6A,250,180,30,180,0
    GYROSENSE G6D,250,180,30,180,0

    RETURN
    '***********************************************
���̷�MID:

    GYROSENSE G6A,200,150,30,150,0
    GYROSENSE G6D,200,150,30,150,0

    RETURN
    '***********************************************
���̷�MIN:

    GYROSENSE G6A,200,100,30,100,0
    GYROSENSE G6D,200,100,30,100,0
    RETURN
    '***********************************************
���̷�ON:


    GYROSET G6A, 4, 3, 3, 3, 0
    GYROSET G6D, 4, 3, 3, 3, 0


    ���̷�ONOFF = 1

    RETURN
    '***********************************************
���̷�OFF:

    GYROSET G6A, 0, 0, 0, 0, 0
    GYROSET G6D, 0, 0, 0, 0, 0


    ���̷�ONOFF = 0
    RETURN

    '************************************************
�����ʱ��ڼ�:
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  35,  90,
    MOVE G6C,100,  35,  90
    WAIT
    mode = 0
    RETURN
    '************************************************
����ȭ�ڼ�:
    MOVE G6A,98,  76, 145,  93, 101, 100
    MOVE G6D,98,  76, 145,  93, 101, 100
    MOVE G6B,100,  35,  90,
    MOVE G6C,100,  35,  90
    WAIT
    mode = 0

    RETURN
    '******************************************	


    '************************************************
�⺻�ڼ�:


    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80,
    MOVE G6C,100,  30,  80,
    WAIT
    mode = 0

    RETURN
    '******************************************	
���⺻�ڼ�:

	SPEED 9
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80,
    WAIT
    mode = 0

    RETURN
    '******************************************	
�⺻�ڼ�2:
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    MOVE G6B,100,  30,  80,
    MOVE G6C,100,  30,  80
    WAIT

    mode = 0
    RETURN
    '******************************************	
�����ڼ�:
    MOVE G6A,100, 56, 182, 76, 100, 100
    MOVE G6D,100, 56, 182, 76, 100, 100
    MOVE G6B,100,  30,  80,
    MOVE G6C,100,  30,  80
    WAIT
    mode = 2
    RETURN
    '******************************************
�����ڼ�:
    GOSUB ���̷�OFF
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
��ܳ��������ȯ:
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
    
    'GOSUB ��ܿ�������
    WAIT
    
    GOTO RX_EXIT
    '**********************************************
�ڳ��ν�3:
	GOSUB ������ 
	WAIT
	GOSUB ������60
	WAIT
	GOSUB �����޸���fast
	WAIT
	GOSUB �����޸���fast
	WAIT
	
	GOSUB �⺻�ڼ�
	WAIT
	
	RETURN
    '**********************************************
�ڳ��ν�2:
	GOSUB ������45
	WAIT
	GOSUB �����޸���fast
	WAIT
	GOSUB �����޸���fast
	WAIT
	GOSUB �����޸���fast
	WAIT
	GOSUB ������45
	WAIT
	
	GOSUB �⺻�ڼ�
	WAIT
	
	RETURN
    '**********************************************
����Ѱ�������:
	����COUNT = 0
    ����ӵ� = 13
    �¿�ӵ� = 4
    �Ѿ���Ȯ�� = 0
    
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
    
    SPEED ����ӵ�

    MOVE G6A, 86,  56, 145, 115, 110
    MOVE G6D,108,  76, 147,  93,  96
    WAIT


    SPEED �¿�ӵ�
    GOSUB Leg_motor_mode3

    MOVE G6A,110,  76, 147, 93,  96
    MOVE G6D,86, 100, 145,  69, 110
    WAIT
    
    SPEED ����ӵ�

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
    ENDIF
    
    
    MOVE G6A,110,  76, 147,  93, 96,100
    MOVE G6D,90, 90, 120, 105, 110,100
    MOVE G6B,110
    MOVE G6C,90
    WAIT
    
    SPEED 3
    GOSUB �⺻�ڼ�
    
    RETURN
    '**********************************************
�Ѱ�������:
	����COUNT = 0
    ����ӵ� = 13
    �¿�ӵ� = 4
    �Ѿ���Ȯ�� = 0
	
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
    
    SPEED ����ӵ�

    MOVE G6A, 86,  56, 145, 115, 110
    MOVE G6D,108,  76, 147,  96,  96
    WAIT


    SPEED �¿�ӵ�
    GOSUB Leg_motor_mode3

    MOVE G6A,110,  76, 147, 93,  96
    MOVE G6D,86, 100, 145,  69, 110
    WAIT


    SPEED ����ӵ�

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        
    ENDIF
    
    SPEED 6

    MOVE G6D,  88,  74, 144,  95, 110
    MOVE G6A, 108,  76, 146,  93,  96
    MOVE G6C, 100
    MOVE G6B, 100
    WAIT
	    
	SPEED 2
	GOSUB �⺻�ڼ� 
	
	RETURN 
	'*************************************

�������:										' �Ѱ����� �����ϵ���! 
	����COUNT = 0
    ����ӵ� = 13
    �¿�ӵ� = 4
    �Ѿ���Ȯ�� = 0

    GOSUB Leg_motor_mode3

    IF ������� = 0 THEN
        ������� = 1

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


        GOTO ��������_1	
    ELSE
        ������� = 0

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


        GOTO ��������_2	

    ENDIF


    '*******************************


��������_1:

    'ETX 4800,11 '�����ڵ带 ����
    SPEED ����ӵ�

    MOVE G6A, 86,  56, 145, 115, 110
    MOVE G6D,108,  76, 147,  93,  96
    WAIT


    SPEED �¿�ӵ�
    GOSUB Leg_motor_mode3

    MOVE G6A,110,  76, 147, 93,  96
    MOVE G6D,86, 100, 145,  69, 110
    WAIT


    SPEED ����ӵ�

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        
    ENDIF

    ERX 4800,A, ��������_2
    IF A = 10 THEN
        GOTO ��������_2
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
        GOSUB �⺻�ڼ�2

        GOTO RX_EXIT
    ENDIF
    '**********

��������_2:

    MOVE G6A,110,  76, 147,  93, 96
    MOVE G6D,90, 90, 120, 105, 110
    MOVE G6B,110
    MOVE G6C,90
    WAIT

��������_3:
    'ETX 4800,11 '�����ڵ带 ����

    SPEED ����ӵ�

    MOVE G6D, 86,  56, 145, 115, 110
    MOVE G6A,108,  76, 147,  93,  96
    WAIT

    SPEED �¿�ӵ�
    MOVE G6D,110,  76, 147, 93,  96
    MOVE G6A,86, 100, 145,  69, 110
    WAIT

    SPEED ����ӵ�

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        
    ENDIF

    ERX 4800,A, ��������_4
    IF A = 11 THEN
        GOTO ��������_4
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
        GOSUB �⺻�ڼ�2

        GOTO RX_EXIT
    ENDIF

��������_4:
    '�޹ߵ��10
    MOVE G6A,90, 90, 120, 105, 110,100
    MOVE G6D,110,  76, 146,  93,  96,100
    MOVE G6B, 90
    MOVE G6C,110
    WAIT

    GOTO ��������_1
    '**********************************************
������:    
    ����COUNT = 0
    ����ӵ� = 12
    �¿�ӵ� = 4
    �Ѿ���Ȯ�� = 0
    GOSUB Leg_motor_mode3
    IF �߼���= 0 THEN
    	�߼���= 1
	    SPEED 4
	
	    MOVE G6A, 88,  74, 144,  95, 110
	    MOVE G6D,108,  76, 146,  93,  96
	    MOVE G6B,100
	    MOVE G6C,100
	    WAIT
	
	    SPEED 10
	
	    MOVE G6A, 90, 90, 120, 105, 110,100
	    MOVE G6D,107,  76, 147,  93,  96,100 ' ù��°�� 110
	    MOVE G6B,90
	    MOVE G6C,110
	    WAIT
	        
	    SPEED ����ӵ�
	
	    MOVE G6A, 86,  56, 145, 115, 110
	    MOVE G6D,108,  76, 147,  93,  96
	    WAIT
	
	
	    SPEED �¿�ӵ�
	    GOSUB Leg_motor_mode3
	
	    MOVE G6A,107,  76, 147, 93,  96
	    MOVE G6D,86, 100, 145,  69, 110
	    WAIT
	
	
	    SPEED ����ӵ�
	
	    GOSUB �յڱ�������
	    
	    MOVE G6A,110,  76, 147,  93, 96,100
	    MOVE G6D,90, 90, 120, 105, 110,100
	    MOVE G6B,110
	    MOVE G6C,90
	    WAIT
	    
	    SPEED ����ӵ�
	
	    MOVE G6D, 86,  56, 145, 115, 110
	    MOVE G6A,108,  76, 147,  93,  96
	    WAIT
	
	    SPEED �¿�ӵ�
	    MOVE G6D,110,  76, 147, 93,  96
	    MOVE G6A,86, 100, 145,  69, 110
	    WAIT
	
	    SPEED ����ӵ�
	
	    GOSUB �յڱ�������
	    
	    MOVE G6A,90, 90, 120, 105, 110,100
	    MOVE G6D,110,  76, 146,  93,  96,100
	    MOVE G6B, 90
	    MOVE G6C,110
	    WAIT 
    ELSEIF �߼���=1 THEN
    	�߼���=0
    	SPEED 4
	
	    MOVE G6D, 88,  77, 144,  100, 110
	    MOVE G6A,108,  76, 146,  93,  96
	    MOVE G6C,100
	    MOVE G6B,100
	    WAIT
	
	    SPEED 10
	
	    MOVE G6D, 90, 90, 120, 105, 110,100
	    MOVE G6A,107,  76, 147,  93,  96,100 ' ù��°�� 110
	    MOVE G6C,90
	    MOVE G6B,110
	    WAIT
	        
	    SPEED ����ӵ�
	
	    MOVE G6D, 86,  56, 145, 115, 110
	    MOVE G6A,108,  76, 147,  93,  96
	    WAIT
	
	
	    SPEED �¿�ӵ�
	    GOSUB Leg_motor_mode3
	
	    MOVE G6D,107,  76, 147, 93,  96
	    MOVE G6A,86, 100, 145,  69, 110
	    WAIT
	
	
	    SPEED ����ӵ�
	
	    GOSUB �յڱ�������
	    
	    MOVE G6D,110,  76, 147,  93, 96,100
	    MOVE G6A,90, 90, 120, 105, 110,100
	    MOVE G6C,110
	    MOVE G6B,90
	    WAIT
	    
	    SPEED ����ӵ�
	
	    MOVE G6A, 86,  56, 145, 115, 110
	    MOVE G6D,108,  76, 147,  93,  96
	    WAIT
	
	    SPEED �¿�ӵ�
	    MOVE G6A,110,  76, 147, 93,  96
	    MOVE G6D,86, 100, 145,  69, 110
	    WAIT
	
	    SPEED ����ӵ�
	
	    GOSUB �յڱ�������
	    
	    MOVE G6D,90, 90, 120, 105, 110,100
	    MOVE G6A,110,  76, 146,  93,  96,100
	    MOVE G6C, 90
	    MOVE G6B,110
	    WAIT 
	ENDIF
    SPEED 3
    GOSUB �⺻�ڼ�
    RETURN
    '**********************************************

    '*******************************
����������:
    ����COUNT = 0
    ����ӵ� = 13
    �¿�ӵ� = 4
    �Ѿ���Ȯ�� = 0

    GOSUB Leg_motor_mode3

    IF ������� = 0 THEN
        ������� = 1

        SPEED 6

        MOVE G6A, 88,  74, 144,  95, 110
        MOVE G6D,108,  76, 146,  93,  96
        WAIT

        SPEED 10'

        MOVE G6A, 90, 90, 120, 105, 110,100
        MOVE G6D,110,  76, 147,  93,  96,100
        WAIT


        GOTO ����������_1	
    ELSE
        ������� = 0

        SPEED 6

        MOVE G6D,  88,  74, 144,  95, 110
        MOVE G6A, 108,  76, 146,  93,  96
        WAIT

        SPEED 10

        MOVE G6D, 90, 90, 120, 105, 110,100
        MOVE G6A,110,  76, 147,  93,  96,100
        WAIT


        GOTO ����������_2	

    ENDIF


    '*******************************


����������_1:

    'ETX 4800,11 '�����ڵ带 ����
    SPEED ����ӵ�

    MOVE G6A, 86,  56, 145, 115, 110
    MOVE G6D,108,  76, 147,  93,  96
    WAIT


    SPEED �¿�ӵ�
    GOSUB Leg_motor_mode3

    MOVE G6A,110,  76, 147, 93,  96
    MOVE G6D,86, 100, 145,  69, 110
    WAIT


    SPEED ����ӵ�

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        
    ENDIF

    ERX 4800,A, ����������_2
    IF A = 11 THEN
        GOTO ����������_2
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
        GOSUB �⺻�ڼ�2

        GOTO RX_EXIT
    ENDIF
    '**********

����������_2:

    MOVE G6A,110,  76, 147,  93, 96,100
    MOVE G6D,90, 90, 120, 105, 110,100
    WAIT

����������_3:
    'ETX 4800,11 '�����ڵ带 ����

    SPEED ����ӵ�

    MOVE G6D, 86,  56, 145, 115, 110
    MOVE G6A,108,  76, 147,  93,  96
    WAIT

    SPEED �¿�ӵ�
    MOVE G6D,110,  76, 147, 93,  96
    MOVE G6A,86, 100, 145,  69, 110
    WAIT

    SPEED ����ӵ�

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        
    ENDIF

    ERX 4800,A, ����������_4
    IF A = 11 THEN
        GOTO ����������_4
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
        GOSUB �⺻�ڼ�2

        GOTO RX_EXIT
    ENDIF

����������_4:
    '�޹ߵ��10
    MOVE G6A,90, 90, 120, 105, 110,100
    MOVE G6D,110,  76, 146,  93,  96,100
    WAIT

    RETURN
    '*******************************
�ѹ�����:
	�Ѿ���Ȯ�� = 0
    ����ӵ� = 12
    �¿�ӵ� = 4
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
    
    SPEED ����ӵ�

    MOVE G6D,110,  76, 145, 93,  96
    MOVE G6A,90, 98, 145,  69, 110
    WAIT

    SPEED �¿�ӵ�
    MOVE G6D, 90,  60, 137, 120, 110
    MOVE G6A,107,  85, 137,  93,  96
    WAIT


    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        
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
    GOSUB �⺻�ڼ�
    RETURN
    '************************************************
��������:
    �Ѿ���Ȯ�� = 0
    ����ӵ� = 12
    �¿�ӵ� = 4
    GOSUB Leg_motor_mode3



    IF ������� = 0 THEN
        ������� = 1

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

        GOTO ��������_1	
    ELSE
        ������� = 0

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


        GOTO ��������_2

    ENDIF


��������_1:
    ETX 4800,12 '�����ڵ带 ����
    SPEED ����ӵ�

    MOVE G6D,110,  76, 145, 93,  96
    MOVE G6A,90, 98, 145,  69, 110
    WAIT

    SPEED �¿�ӵ�
    MOVE G6D, 90,  60, 137, 120, 110
    MOVE G6A,107,  85, 137,  93,  96
    WAIT


    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        
    ENDIF


    SPEED 11

    MOVE G6D,90, 90, 120, 105, 110
    MOVE G6A,112,  76, 146,  93, 96
    MOVE G6B,110
    MOVE G6C,90
    WAIT

    ERX 4800,A, ��������_2
    IF A <> A_old THEN
��������_1_EXIT:
        HIGHSPEED SETOFF
        SPEED 5

        MOVE G6A, 106,  76, 145,  93,  96		
        MOVE G6D,  85,  72, 148,  91, 106
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT	

        SPEED 3
        GOSUB �⺻�ڼ�2
        GOTO RX_EXIT
    ENDIF
    '**********

��������_2:
    ETX 4800,12 '�����ڵ带 ����
    SPEED ����ӵ�
    MOVE G6A,110,  76, 145, 93,  96
    MOVE G6D,90, 98, 145,  69, 110
    WAIT


    SPEED �¿�ӵ�
    MOVE G6A, 90,  60, 137, 120, 110
    MOVE G6D,107  85, 137,  93,  96
    WAIT


    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        
    ENDIF


    SPEED 11
    MOVE G6A,90, 90, 120, 105, 110
    MOVE G6D,112,  76, 146,  93,  96
    MOVE G6B, 90
    MOVE G6C,110
    WAIT


    ERX 4800,A, ��������_1
    IF A <> A_old THEN
��������_2_EXIT:
        HIGHSPEED SETOFF
        SPEED 5

        MOVE G6D, 106,  76, 145,  93,  96		
        MOVE G6A,  85,  72, 148,  91, 106
        MOVE G6B, 100
        MOVE G6C, 100
        WAIT	

        SPEED 3
        GOSUB �⺻�ڼ�2
        GOTO RX_EXIT
    ENDIF  	

    GOTO ��������_1
    '**********************************************

    '******************************************
Ƚ��_������������:
    GOSUB All_motor_mode3
    ����COUNT = 0
    SPEED 11
    HIGHSPEED SETON


    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO Ƚ��_������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO Ƚ��_������������_4
    ENDIF


    '**********************

Ƚ��_������������_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
    MOVE G6B, 85
    MOVE G6C,115
    WAIT


Ƚ��_������������_2:

    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
		RETURN
    ENDIF

    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO Ƚ��_������������_2_stop

    ERX 4800,A, Ƚ��_������������_4
    IF A <> A_old THEN
Ƚ��_������������_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        MOVE G6C, 100
        MOVE G6B,100
        WAIT
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        SPEED 5
        GOSUB �⺻�ڼ�2

        'DELAY 400
        RETURN
    ENDIF

    '*********************************

Ƚ��_������������_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT


Ƚ��_������������_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT


    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        RETURN
    ENDIF

    ����COUNT = ����COUNT + 1
    IF ����COUNT > ����Ƚ�� THEN  GOTO Ƚ��_������������_5_stop

    ERX 4800,A, Ƚ��_������������_1
    IF A <> A_old THEN
Ƚ��_������������_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        SPEED 5
        GOSUB �⺻�ڼ�2

        'DELAY 400
        RETURN
    ENDIF

    '*************************************

    '*********************************

    GOTO Ƚ��_������������_1

    '******************************************

    '******************************************
������������:
    GOSUB All_motor_mode3
    ����COUNT = 0
    SPEED 7
    HIGHSPEED SETON


    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 147,  93, 101
        MOVE G6D,101,  76, 147,  93, 98
        'MOVE G6B,100
        'MOVE G6C,100
        WAIT

        GOTO ������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 147,  93, 101
        MOVE G6A,101,  76, 147,  93, 98
        'MOVE G6B,100
        'MOVE G6C,100
        WAIT

        GOTO ������������_4
    ENDIF


    '**********************

������������_1:
    MOVE G6A,95,  90, 125, 100, 104
    MOVE G6D,104,  77, 147,  93,  102
    'MOVE G6B, 85
    'MOVE G6C,115
    WAIT


������������_2:

    MOVE G6A,103,   73, 140, 103,  100
    MOVE G6D, 95,  85, 147,  85, 102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0

        GOTO RX_EXIT
    ENDIF

    ' ����COUNT = ����COUNT + 1
    'IF ����COUNT > ����Ƚ�� THEN  GOTO ������������_2_stop

    ERX 4800,A, ������������_4
    IF A <> A_old THEN
������������_2_stop:
        MOVE G6D,95,  90, 125, 95, 104
        MOVE G6A,104,  76, 145,  91,  102
        'MOVE G6C, 100
        'MOVE G6B,100
        WAIT
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        SPEED 5
        GOSUB �⺻�ڼ�2

        'DELAY 400
        GOTO RX_EXIT
    ENDIF

    '*********************************

������������_4:
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 147,  93,  102
    'MOVE G6C, 85
    'MOVE G6B,115
    WAIT


������������_5:
    MOVE G6D,103,    73, 140, 103,  100
    MOVE G6A, 95,  85, 147,  85, 102
    WAIT


    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO RX_EXIT
    ENDIF

    ' ����COUNT = ����COUNT + 1
    ' IF ����COUNT > ����Ƚ�� THEN  GOTO ������������_5_stop

    ERX 4800,A, ������������_1
    IF A <> A_old THEN
������������_5_stop:
        MOVE G6A,95,  90, 125, 95, 104
        MOVE G6D,104,  76, 145,  91,  102
        'MOVE G6B, 100
        'MOVE G6C,100
        WAIT
        HIGHSPEED SETOFF
        SPEED 15
        GOSUB ����ȭ�ڼ�
        SPEED 5
        GOSUB �⺻�ڼ�2

        'DELAY 400
        GOTO RX_EXIT
    ENDIF

    '*************************************

    '*********************************

    GOTO ������������_1

    '******************************************
    '******************************************
    '******************************************

������������:
    GOSUB All_motor_mode3
    �Ѿ���Ȯ�� = 0
    ����COUNT = 0
    SPEED 7
    HIGHSPEED SETON


    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  76, 145,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO ������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  76, 145,  93, 98
        MOVE G6B,100
        MOVE G6C,100
        WAIT

        GOTO ������������_4
    ENDIF


    '**********************

������������_1:
    MOVE G6D,104,  76, 147,  93,  102
    MOVE G6A,95,  95, 120, 95, 104
    MOVE G6B,115
    MOVE G6C,85
    WAIT



������������_3:
    MOVE G6A, 103,  79, 147,  89, 100
    MOVE G6D,95,   65, 147, 103,  102
    WAIT

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO RX_EXIT
    ENDIF
    ' ����COUNT = ����COUNT + 1
    ' IF ����COUNT > ����Ƚ�� THEN  GOTO ������������_3_stop
    ERX 4800,A, ������������_4
    IF A <> A_old THEN
������������_3_stop:
        MOVE G6D,95,  85, 130, 100, 104
        MOVE G6A,104,  77, 146,  93,  102
        MOVE G6C, 100
        MOVE G6B,100
        WAIT

        'SPEED 15
        GOSUB ����ȭ�ڼ�
        HIGHSPEED SETOFF
        SPEED 5
        GOSUB �⺻�ڼ�2

        'DELAY 400
        GOTO RX_EXIT
    ENDIF
    '*********************************

������������_4:
    MOVE G6A,104,  76, 147,  93,  102
    MOVE G6D,95,  95, 120, 95, 104
    MOVE G6C,115
    MOVE G6B,85
    WAIT


������������_6:
    MOVE G6D, 103,  79, 147,  89, 100
    MOVE G6A,95,   65, 147, 103,  102
    WAIT
    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
        GOTO RX_EXIT
    ENDIF

    ' ����COUNT = ����COUNT + 1
    'IF ����COUNT > ����Ƚ�� THEN  GOTO ������������_6_stop

    ERX 4800,A, ������������_1
    IF A <> A_old THEN  'GOTO ������������_����
������������_6_stop:
        MOVE G6A,95,  85, 130, 100, 104
        MOVE G6D,104,  77, 146,  93,  102
        MOVE G6B, 100
        MOVE G6C,100
        WAIT

        'SPEED 15
        GOSUB ����ȭ�ڼ�
        HIGHSPEED SETOFF
        SPEED 5
        GOSUB �⺻�ڼ�2

        'DELAY 400
        GOTO RX_EXIT
    ENDIF

    GOTO ������������_1




    '******************************************

    '******************************************
�����޸���slow:
    �Ѿ���Ȯ�� = 0
    GOSUB All_motor_mode3
    ����COUNT = 0
    SPEED 9
    
	HIGHSPEED SETON
	
	IF ���ο�߼��� = 0 THEN
		���ο�߼���= 1
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
        
    ELSEIF ���ο�߼��� = 1 THEN
    	���ο�߼���= 0
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
    GOSUB �⺻�ڼ�
	WAIT
	
    RETURN
    '******************************************
�����޸���fast:
    �Ѿ���Ȯ�� = 0
    GOSUB All_motor_mode3
    ����COUNT = 0
    SPEED 12
    
	HIGHSPEED SETON
	
	IF �н�Ʈ�߼��� = 0 THEN
		�н�Ʈ�߼���= 1
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
        
    ELSEIF �н�Ʈ�߼��� = 1 THEN
    	�н�Ʈ�߼���= 0
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
    GOSUB �⺻�ڼ�
	WAIT
	
    RETURN
    '******************************************



    '************************************************
�����ʿ�����20: '****
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
    GOSUB �⺻�ڼ�
    GOSUB All_motor_mode3
    
    RETURN
    '*************


���ʿ�����20: '****
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
    GOSUB �⺻�ڼ�
    GOSUB All_motor_mode3
    
    
    RETURN

    '**********************************************
���ʿ�����4_20: '****
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
    GOSUB �⺻�ڼ�
    GOSUB All_motor_mode3
    
    ETX 4800, 247
    GOTO RX_EXIT

    '**********************************************
���ʿ�����20���: '****
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
    GOSUB �⺻�ڼ�
    GOSUB All_motor_mode3
    RETURN 
    'GOTO RX_EXIT
    '******************************************
�����ʿ�����70:
	
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


    '  ERX 4800, A ,�����ʿ�����70����_loop
    '    IF A = A_OLD THEN  GOTO �����ʿ�����70����_loop
    '�����ʿ�����70����_stop:
    
    GOSUB �⺻�ڼ�
	RETURN
    '**********************************************

���ʿ�����70:
	
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

    '   ERX 4800, A ,���ʿ�����70����_loop	
    '    IF A = A_OLD THEN  GOTO ���ʿ�����70����_loop
    '���ʿ�����70����_stop:

    GOSUB �⺻�ڼ�

    RETURN

    '**********************************************
    '************************************************
    '*********************************************

������3:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
������3_LOOP:

    IF ������� = 0 THEN
        ������� = 1
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
        ������� = 0
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
    GOSUB �⺻�ڼ�


    GOTO RX_EXIT

    '**********************************************
��������3:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2

��������3_LOOP:

    IF ������� = 0 THEN
        ������� = 1
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
        ������� = 0
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
    GOSUB �⺻�ڼ�2

    GOTO RX_EXIT

    '******************************************************
    '**********************************************
������10:
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

    GOSUB �⺻�ڼ�2
    GOTO RX_EXIT
    '**********************************************
��������10:
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

    GOSUB �⺻�ڼ�2
	GOTO RX_EXIT
  
    '**********************************************
    '**********************************************
������20:
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

    GOSUB �⺻�ڼ�
    
	RETURN
    '**********************************************

    '**********************************************
��������20:
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

    GOSUB �⺻�ڼ�
    
	RETURN
    '**********************************************

    '**********************************************

    '**********************************************	


    '**********************************************
������45:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
������45_LOOP:

    SPEED 10
    MOVE G6A,95,  106, 145,  63, 105, 100
    MOVE G6D,95,  46, 145,  123, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  106, 145,  63, 105, 100
    MOVE G6D,93,  46, 145,  123, 105, 100
    WAIT

    SPEED 8
    GOSUB �⺻�ڼ�
    'DELAY 50
    '    GOSUB �յڱ�������
    '    IF �Ѿ���Ȯ�� = 1 THEN
    '        �Ѿ���Ȯ�� = 0
    '        GOTO RX_EXIT
    '    ENDIF
    '
    '    ERX 4800,A,������45_LOOP
    '    IF A_old = A THEN GOTO ������45_LOOP
    '
    RETURN

    '**********************************************
��������45:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
��������45_LOOP:

    SPEED 10
    MOVE G6A,95,  46, 145,  123, 105, 100
    MOVE G6D,95,  106, 145,  63, 105, 100
    WAIT

    SPEED 12
    MOVE G6A,93,  46, 145,  123, 105, 100
    MOVE G6D,93,  106, 145,  63, 105, 100
    WAIT

    SPEED 8
    GOSUB �⺻�ڼ�
    ' DELAY 50
    '    GOSUB �յڱ�������
    '    IF �Ѿ���Ȯ�� = 1 THEN
    '        �Ѿ���Ȯ�� = 0
    '        GOTO RX_EXIT
    '    ENDIF
    '
    '    ERX 4800,A,��������45_LOOP
    '    IF A_old = A THEN GOTO ��������45_LOOP
    '
    RETURN
    '**********************************************
��ܿ�������:
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
    GOSUB �⺻�ڼ�2
   
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
    GOSUB �⺻�ڼ�2
    
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
    GOSUB �⺻�ڼ�2
    
    RETURN
    '**********************************************
������60:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
������60_LOOP:

    SPEED 10
    MOVE G6A,95,  116, 145,  53, 105, 100
    MOVE G6D,95,  36, 145,  133, 105, 100
    WAIT

    SPEED 10
    MOVE G6A,90,  116, 145,  53, 105, 100
    MOVE G6D,90,  36, 145,  133, 105, 100
    WAIT

    SPEED 8
    GOSUB �⺻�ڼ�
    '  DELAY 50
    '    GOSUB �յڱ�������
    '    IF �Ѿ���Ȯ�� = 1 THEN
    '        �Ѿ���Ȯ�� = 0
    '        GOTO RX_EXIT
    '    ENDIF
    '    ERX 4800,A,������60_LOOP
    '    IF A_old = A THEN GOTO ������60_LOOP

    RETURN

    '**********************************************
��������60:
    MOTORMODE G6A,3,3,3,3,2
    MOTORMODE G6D,3,3,3,3,2
��������60_LOOP:

    SPEED 15
    MOVE G6A,95,  36, 145,  133, 105, 100
    MOVE G6D,95,  116, 145,  53, 105, 100
    WAIT

    SPEED 15
    MOVE G6A,90,  36, 145,  133, 105, 100
    MOVE G6D,90,  116, 145,  53, 105, 100

    WAIT

    SPEED 10
    GOSUB �⺻�ڼ�
    ' DELAY 50
    '    GOSUB �յڱ�������
    '    IF �Ѿ���Ȯ�� = 1 THEN
    '        �Ѿ���Ȯ�� = 0
    '        GOTO RX_EXIT
    '    ENDIF
    '    ERX 4800,A,��������60_LOOP
    '    IF A_old = A THEN GOTO ��������60_LOOP
    RETURN
    '****************************************
    '************************************************
    '**********************************************


    '************************************************

    ''************************************************
    '************************************************
    '************************************************
�ڷ��Ͼ��:

    HIGHSPEED SETOFF
    PTP SETON 				
    PTP ALLON		

    GOSUB ���̷�OFF

    GOSUB All_motor_Reset

    SPEED 15
    GOSUB �⺻�ڼ�

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
    GOSUB �⺻�ڼ�

    �Ѿ���Ȯ�� = 1

    DELAY 200
    GOSUB ���̷�ON
	ETX 4800, A_old
    RETURN


    '**********************************************
�������Ͼ��:


    HIGHSPEED SETOFF
    PTP SETON 				
    PTP ALLON

    GOSUB ���̷�OFF

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
    GOSUB �⺻�ڼ�
    �Ѿ���Ȯ�� = 1

    '******************************
    DELAY 200
    GOSUB ���̷�ON
    ETX 4800, A_old
    RETURN

    '******************************************
    '******************************************
    '******************************************
    '**************************************************

    '******************************************
    '******************************************	
    '**********************************************

�Ӹ�����30��:
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,70
    GOTO MAIN

�Ӹ�����45��:
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,55
    RETURN

�Ӹ�����60��:
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,40
    RETURN

�Ӹ�����90��:
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,10
    GOTO MAIN

�Ӹ�������30��:
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,130
    GOTO MAIN

�Ӹ�������45��:
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,145
    RETURN

�Ӹ�������60��:
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,160
    RETURN

�Ӹ�������90��:
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,190
    GOTO MAIN

�Ӹ��¿��߾�:
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,100
    RETURN

�Ӹ���������:
    SPEED �Ӹ��̵��ӵ�
    SERVO 11,100	
    SPEED 5
    GOSUB �⺻�ڼ�
    GOTO MAIN

    '******************************************
��������80��:

    SPEED 3
    SERVO 16, 80
    ETX 4800,35
    RETURN
    '******************************************
��������60��:

    SPEED 3
    SERVO 16, 65
    ETX 4800,36
    RETURN

    '******************************************
    '******************************************
�յڱ�������:
    FOR i = 0 TO COUNT_MAX
        A = AD(�յڱ���AD��Ʈ)	'���� �յ�
        IF A > 250 OR A < 5 THEN RETURN
        IF A > MIN AND A < MAX THEN RETURN
        DELAY ����Ȯ�νð�
    NEXT i

    IF A < MIN THEN
        GOSUB �����
        
    ELSEIF A > MAX THEN
        GOSUB �����
        
    ENDIF
    RETURN
    '**************************************************
�����:
    A = AD(�յڱ���AD��Ʈ)
    'IF A < MIN THEN GOSUB �������Ͼ��
    IF A < MIN THEN
        GOSUB �ڷ��Ͼ��

   	ENDIF
    RETURN

�����:
    A = AD(�յڱ���AD��Ʈ)
    'IF A > MAX THEN GOSUB �ڷ��Ͼ��
    IF A > MAX THEN
        GOSUB �������Ͼ��
    ENDIF
    RETURN
    '**************************************************
�¿��������:
    FOR i = 0 TO COUNT_MAX
        B = AD(�¿����AD��Ʈ)	'���� �¿�
        IF B > 250 OR B < 5 THEN RETURN
        IF B > MIN AND B < MAX THEN RETURN
        DELAY ����Ȯ�νð�
    NEXT i

    IF B < MIN OR B > MAX THEN
        SPEED 8
        MOVE G6B,140,  40,  80
        MOVE G6C,140,  40,  80
        WAIT
        GOSUB �⺻�ڼ�
    
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
Number_Play: '  BUTTON_NO = ���ڴ���


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
���ܼ��Ÿ�����Ȯ��:

    ���ܼ��Ÿ���= AD(5)

    IF ���ܼ��Ÿ���> 135 AND �ܰ�=0 THEN '������ 
    	MUSIC "C"
		ETX 4800, 77
	ELSEIF ���ܼ��Ÿ���> 100 AND �ܰ� = 1 THEN 
		MUSIC "C"
		ETX 4800, 78
	ELSEIF ���ܼ��Ÿ���> 75 AND �ܰ� = 2 THEN
		MUSIC "C"
		ETX 4800, 79
		
    ENDIF

    RETURN
    '******************************************
�������ʿ�����:
	' �����ʿ����� 70 1�� 
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
    
    GOSUB �⺻�ڼ�
    WAIT
    
    RETURN
	' �����ʿ����� 70 ��
    'GOSUB ������
        'GOSUB ����������
        'GOSUB ���⺻�ڼ�
        'GOSUB ����������
        'GOSUB ���⺻�ڼ�
        'GOSUB ����������
        'GOSUB ���⺻��
        '*************************************
���������:
	����COUNT = 0
   	����ӵ� = 13
   	�¿�ӵ� = 4
    �Ѿ���Ȯ�� = 0
 	MUSIC "C"
	
	GOSUB ������60
	WAIT
	
	GOSUB �⺻�ڼ�
	WAIT
	
    GOSUB ������60
	WAIT
	
	GOSUB �⺻�ڼ�
	WAIT

	GOSUB Ƚ��_������������
	WAIT
	
	GOSUB �⺻�ڼ�
	WAIT
	
	GOSUB �ѹ�����
	WAIT
	
	GOSUB �⺻�ڼ�
	WAIT
	
	GOSUB �������ʿ�����
	WAIT
	GOSUB �⺻�ڼ�
	WAIT
	GOSUB �������ʿ�����
	WAIT
	GOSUB �⺻�ڼ�
	WAIT
	GOSUB �������ʿ�����
	WAIT
	GOSUB �⺻�ڼ�
	WAIT
	GOSUB �������ʿ�����
	WAIT
	GOSUB �⺻�ڼ�
	WAIT
	GOSUB �������ʿ�����
	WAIT
	GOSUB �⺻�ڼ�
	WAIT
	GOSUB �������ʿ�����
	WAIT
	GOSUB �⺻�ڼ�
	WAIT
	GOSUB �������ʿ�����
	WAIT
	GOSUB �⺻�ڼ�
	WAIT
	GOSUB �������ʿ�����
	WAIT
	GOSUB �⺻�ڼ�
	WAIT
	GOSUB �������ʿ�����
	WAIT
	GOSUB �⺻�ڼ�
	WAIT
	GOSUB �����޸���fast
	WAIT
	GOSUB �⺻�ڼ�
	WAIT
	GOSUB �����޸���fast
	WAIT
	GOSUB �⺻�ڼ�
	WAIT
	�ܰ� = 1
	RETURN
	'********************************************      
������:
	SPEED 12
    MOVE G6B,190,20
    WAIT
    MOVE G6C,190,20
    WAIT
    
    RETURN
    '**********************************************
����:
   '�����ʿ����� 1��
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
    
    GOSUB ��������20
    WAIT
    
    '������ױ� 
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
    
    
    '���ʿ����� 4��
    
    
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
    
    '������ 1��
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
    '�ȴ�������
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
    '������ 1��
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
    '������ 1�� 
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
    
    '������ 1�� 
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
    '�ɱ�    
    GOSUB ���̷�OFF
    MOVE G6A,100, 145,  28, 145, 100, 100
    MOVE G6D,100, 145,  28, 145, 100, 100
    
    WAIT
    
    GOSUB ȯȣ��
    WAIT
    
    �ܰ� = 2
	
    RETURN
'******************************************
����_�⺻�ڼ�:
	SPEED 5
    MOVE G6A,100,  76, 145,  93, 100, 100
    MOVE G6D,100,  76, 145,  93, 100, 100
    WAIT

    mode = 0
    RETURN
'******************************************
����_�����ʿ�����: 
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
    GOSUB ����_�⺻�ڼ�
    GOSUB All_motor_mode3
    RETURN
'******************************************
���������10:

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
�����������10:

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
���������20:

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
�����������20:

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
��ܿ����߳������¸�:  

    GOSUB All_motor_mode3

    SPEED 4 
    MOVE G6D, 88,  71, 152,  91, 110 '�����ʹ� ��������
    MOVE G6A,108,  76, 145,  93,  94 '���ʴٸ�
    MOVE G6B,100,40 '������
    MOVE G6C,100,40 '��������
    WAIT

    SPEED 10 
    MOVE G6D, 90, 100, 115, 105, 114 '�����ٸ� ���
    MOVE G6A,113,  76, 145,  93,  94 '���ʹ� �ٱ�������
    WAIT

    GOSUB Leg_motor_mode2
    
    SPEED 12
    MOVE G6D,  80, 30, 155, 150, 114 '�����ٸ� �����
    MOVE G6A, 113,  75, 145,  90,  94 '
    WAIT


    SPEED 7
    MOVE G6A, 113,  100, 95,  120,  94 ' ���ʴٸ� ������
    MOVE G6D,  80, 30, 175, 150, 114, '�����ʴٸ� �������
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
    
   SPEED 8 '''�߿��������� ����
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
    
    ' ������ 20
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

    GOSUB �⺻�ڼ�2
    
    ' �������� 20
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

    GOSUB �⺻�ڼ�2
    
    
  	ETX 4800, 243
    mode = 0
     WAIT
    GOTO RX_EXIT
    '--------------------------------------------
���������45:

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
�����������45:

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
���������60:

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
�����������60:

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
��ܿ޹߿�����3cm:
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
    GOSUB �⺻�ڼ�

    GOTO RX_EXIT
    '****************************************

��ܿ����߿�����3cm:
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
    GOSUB �⺻�ڼ�

    GOTO RX_EXIT
    '********************************************	

    '************************************************
��ܿ޹߳�����3cm:
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
'���!!!
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
    GOSUB �⺻�ڼ�

    GOTO RX_EXIT
    '****************************************
    '************************************************
��ܿ����߳�����3cm:
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
    GOSUB �⺻�ڼ�

    GOTO RX_EXIT
    '************************************************

    '************************************************
��ܿ޹߿�����1cm:
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

��ܿ����߿�����1cm:
    
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
��ܿ����߳�����1cm:  
	
	GOSUB All_motor_mode3

    SPEED 4 
    MOVE G6D, 88,  71, 152,  91, 110 '�����ʹ� ��������
    MOVE G6A,108,  76, 145,  93,  94 '���ʴٸ�
    MOVE G6B,100,40 '������
    MOVE G6C,100,40 '��������
    WAIT

    SPEED 10 
    MOVE G6D, 90, 100, 115, 105, 114 '�����ٸ� ���
    MOVE G6A,113,  76, 145,  93,  94 '���ʹ� �ٱ�������
    WAIT

    GOSUB Leg_motor_mode2
    
    SPEED 12
    MOVE G6D,  80, 30, 155, 150, 114 '�����ٸ� �����
    MOVE G6A, 113,  75, 145,  90,  94 '
    WAIT

    GOSUB Leg_motor_mode2

    SPEED 7
    MOVE G6A, 113,  100, 95,  120,  94 ' ���ʴٸ� ������
    MOVE G6D,  80, 30, 175, 150, 114, '�����ʴٸ� �������
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
	SPEED 8 '''�߿��������� ����
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
�޼յ��:
	SPEED 10
    MOVE G6B,190,20
    GOTO RX_EXIT
'******************************************
�����յ��:
	SPEED 10
    MOVE G6C,190,20
    GOTO RX_EXIT
    '************************************************

'******************************************
��������:
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
    GOSUB ���̷�ON 
    WAIT 
    �ܰ� = 2
    
    RETURN
'**********************************************
��ֹ��ĳ���:
	GOSUB All_motor_mode3
    SPEED 10
	GOSUB ���̷�OFF
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
    GOSUB �⺻�ڼ�
    WAIT
    
    RETURN
    '**********************************************
�����ɾƺ���:
    GOSUB All_motor_mode3
    SPEED 7
	GOSUB ���̷�OFF
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
    GOSUB �����ڼ�
    GOSUB ���̷�ON
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    
    RETURN

    '*****************************

    '**********************************************
�޹�����:

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
    GOSUB �⺻�ڼ�	
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
    GOSUB �⺻�ڼ�	
    GOSUB Leg_motor_mode1
    DELAY 400
    
	RETURN
    

    '******************************************
����������:
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
    GOSUB �⺻�ڼ�	
    GOSUB Leg_motor_mode1
    DELAY 400

    RETURN
    '******************************************
��ܿ���������:
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
    GOSUB �⺻�ڼ�
    RETURN
    '******************************************
��ܿ���������2����: 
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
    GOSUB �⺻�ڼ�
    GOSUB ����Ѱ������� 
    GOSUB ����Ѱ������� 
    RETURN
    '******************************************
����Ѱ�������1:									 
    ����COUNT = 0
    ����ӵ� = 13
    �¿�ӵ� = 4
    �Ѿ���Ȯ�� = 0
    
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
    
    SPEED ����ӵ�

    MOVE G6A, 86,  56, 145, 115, 110
    MOVE G6D,108,  76, 147,  93,  96
    WAIT


    SPEED �¿�ӵ�
    GOSUB Leg_motor_mode3

    MOVE G6A,110,  76, 147, 93,  96
    MOVE G6D,86, 100, 145,  69, 110
    WAIT
    
    SPEED ����ӵ�

    GOSUB �յڱ�������
    IF �Ѿ���Ȯ�� = 1 THEN
        �Ѿ���Ȯ�� = 0
    ENDIF
    
    
    MOVE G6A,110,  76, 147,  93, 96,100
    MOVE G6D,90, 90, 120, 105, 110,100
    MOVE G6B,110
    MOVE G6C,90
    WAIT
    
    SPEED 3
    GOSUB �⺻�ڼ�2

    RETURN
    '**********************************************
��ܳ�����������:  

    SPEED 4 
    MOVE G6D, 88,  71, 152,  91, 110 '�����ʹ� ��������
    MOVE G6A,108,  76, 145,  93,  94 '���ʴٸ�
    MOVE G6B,100,40 '������
    MOVE G6C,100,40 '��������
    WAIT

    SPEED 10 
    MOVE G6D, 90, 100, 115, 105, 114 '�����ٸ� ���
    MOVE G6A,113,  76, 145,  93,  94 '���ʹ� �ٱ�������
    WAIT

    SPEED 12
    MOVE G6D,  80, 30, 155, 150, 114 '�����ٸ� �����
    MOVE G6A, 113,  75, 145,  90,  94 '
    WAIT

    SPEED 5
    MOVE G6A, 113,  100, 95,  120,  94 ' ���ʴٸ� ������
    MOVE G6D,  80, 30, 175, 150, 114, '�����ʴٸ� �������
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
    GOSUB �⺻�ڼ�
    
    mode = 0
    WAIT
    RETURN
   '***********************************
�����:

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
    GOSUB �⺻�ڼ�


    RETURN

    '************************************************
���۹��2:

    GOSUB All_motor_mode3


    '�����ʱ���2:
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



    '**** �뷡�����ڼ�******
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
    GOSUB �⺻�ڼ�

    GOSUB All_motor_Reset


    RETURN
    '******************************************
ȯȣ��:
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
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    RETURN
    ''************************************************
�¸��������1:
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
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    RETURN
    ''************************************************
�¸��������2:
    SPEED 10
    GOSUB �⺻�ڼ�
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
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    RETURN
    ''************************************************
    ''************************************************
�¸��������3:
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
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset

    RETURN
    ''************************************************
�λ�1:

    GOSUB All_motor_mode3
    SPEED 6
    MOVE G6A,100,  70, 125, 150, 100
    MOVE G6D,100,  70, 125, 150, 100
    MOVE G6B,100,  30,  80
    MOVE G6C,100,  30,  80
    WAIT

    DELAY 1000
    SPEED 6
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    RETURN
    '************************************************
�λ�2:
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
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset
    RETURN
    '************************************************


�λ�3:
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

    '�λ�
    SPEED 8
    MOVE G6A,100,  55, 145,  145, 100, 100
    MOVE G6D,100,  55, 145,  145, 100, 100
    MOVE G6C,100,  80,  80
    MOVE G6B,175,  15,  15
    WAIT

    DELAY 1000
    '�Ͼ��
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
    GOSUB �⺻�ڼ�
    GOSUB All_motor_Reset


    RETURN
    '************************************************ 
�������������:
    ����� = 2
    SPEED 10
    HIGHSPEED SETON
    GOSUB All_motor_mode3


    IF ������� = 0 THEN
        ������� = 1
        MOVE G6A,95,  76, 145,  93, 101
        MOVE G6D,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO �������������_1
    ELSE
        ������� = 0
        MOVE G6D,95,  76, 145,  93, 101
        MOVE G6A,101,  77, 145,  93, 98
        MOVE G6B,100,  35
        MOVE G6C,100,  35
        WAIT

        GOTO �������������_4
    ENDIF



    '**********************

�������������_1:
    SPEED 8
    MOVE G6A,95,  95, 120, 100, 104
    MOVE G6D,104,  77, 146,  91,  102
    MOVE G6B, 85
    MOVE G6C,115
    WAIT


�������������_3:
    SPEED 8
    MOVE G6A,103,   71, 140, 105,  100
    MOVE G6D, 95,  82, 146,  87, 102
    WAIT


    ERX 4800, A ,�������������_4_0

    IF A = 20 THEN
        ����� = 3
    ELSEIF A = 43 THEN
        ����� = 1
    ELSEIF A = 11 THEN
        ����� = 2
    ELSE  '����
        GOTO �������������_3����
    ENDIF

�������������_4_0:

    IF  ����� = 1 THEN'����

    ELSEIF  ����� = 3 THEN'������
        HIGHSPEED SETOFF
        SPEED 8
        MOVE G6D,103,   71, 140, 105,  100
        MOVE G6A, 95,  82, 146,  87, 102
        WAIT
        HIGHSPEED SETON
        GOTO �������������_1

    ENDIF



    '*********************************

�������������_4:
    SPEED 8
    MOVE G6D,95,  95, 120, 100, 104
    MOVE G6A,104,  77, 146,  91,  102
    MOVE G6C, 85
    MOVE G6B,115
    WAIT


�������������_6:
    SPEED 8
    MOVE G6D,103,   71, 140, 105,  100
    MOVE G6A, 95,  82, 146,  87, 102
    WAIT



    ERX 4800, A ,�������������_1_0

    IF A = 20 THEN
        ����� = 3
    ELSEIF A = 43 THEN
        ����� = 1
    ELSEIF A = 11 THEN
        ����� = 2
    ELSE  '����
        GOTO �������������_6����
    ENDIF

�������������_1_0:

    IF  ����� = 1 THEN'����
        HIGHSPEED SETOFF
        SPEED 8
        MOVE G6A,103,   71, 140, 105,  100
        MOVE G6D, 95,  82, 146,  87, 102
        WAIT
        HIGHSPEED SETON
        GOTO �������������_4
    ELSEIF ����� = 3 THEN'������


    ENDIF



    GOTO �������������_1
    '******************************************
    '******************************************
    '*********************************
�������������_3����:
    MOVE G6D,95,  90, 125, 95, 104
    MOVE G6A,104,  76, 145,  91,  102
    MOVE G6C, 100
    MOVE G6B,100
    WAIT
    HIGHSPEED SETOFF
    SPEED 15
    GOSUB ����ȭ�ڼ�
    SPEED 10
    GOSUB �⺻�ڼ�
    GOTO MAIN	
    '******************************************
�������������_6����:
    MOVE G6A,95,  90, 125, 95, 104
    MOVE G6D,104,  76, 145,  91,  102
    MOVE G6B, 100
    MOVE G6C,100
    WAIT
    HIGHSPEED SETOFF
    SPEED 15
    GOSUB ����ȭ�ڼ�
    SPEED 10
    GOSUB �⺻�ڼ�
    GOTO MAIN	
    '******************************************
    '******************************************************

	'----------------------------------------------------
�ͳ�������:

    GOSUB All_motor_mode3
    GOSUB ���̷�OFF

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
    GOSUB ���̷�ON
    
    �ܰ�= 2
    RETURN 
    '***********************************
MAIN: '�󺧼���
	
MAIN_2:

    GOSUB �յڱ�������
    GOSUB �¿��������
	
    ERX 4800,A,MAIN_2	

    A_old = A

    '**** �Էµ� A���� 0 �̸� MAIN �󺧷� ����
    '**** 1�̸� KEY1 ��, 2�̸� key2��... ���¹�
    ON A GOTO MAIN,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,KEY11,KEY12,KEY13,KEY14,KEY15,KEY16,KEY17,KEY18 ,KEY19,KEY20,KEY21,KEY22,KEY23,KEY24,KEY25,KEY26,KEY27,KEY28 ,KEY29,KEY30,KEY31,KEY32

    IF A = 219 THEN
        SERVO 16, 100
        ETX 4800,219
        GOTO RX_EXIT
        '4�ܰ� �� ���

    ELSEIF A = 215 THEN
        SERVO 16, 25
        SERVO 11, 100
        GOSUB �ѹ����� 
        ETX 4800,215
        GOTO RX_EXIT
    ELSEIF A = 217 THEN
        SERVO 16, 20
        SERVO 11, 100
        WAIT
        GOSUB ��������45
        WAIT
        ETX 4800,217
        GOTO RX_EXIT
    ELSEIF A = 218 THEN
        SERVO 16, 20
        SERVO 11, 100
        GOSUB ������45 
        ETX 4800,218
        GOTO RX_EXIT
	ELSEIF A = 220 THEN
        SERVO 16, 25
        SERVO 11, 100
        ETX 4800,220
        GOTO RX_EXIT
        '�� ���
    ELSEIF A = 221 THEN
        SERVO 16, 15
        SERVO 11, 100
        ETX 4800,221
        GOTO RX_EXIT
        '�� ������
    ELSEIF A = 222 THEN
        SERVO 16, 20
        SERVO 11, 100
        GOSUB Ƚ��_������������
        ETX 4800, 222
        GOTO RX_EXIT
    ELSEIF A = 223 THEN
    	SERVO 16, 50
    	SERVO 11, 100
    	GOSUB �Ӹ�����45��
    	ETX 4800, 223
    	GOTO RX_EXIT
    ELSEIF A = 224 THEN
    	SERVO 16,50
    	SERVO 11, 100
    	GOSUB �Ӹ�������45��
    	ETX 4800,224
    	GOTO RX_EXIT
    ELSEIF A = 225 THEN
    	SERVO 16,20
    	SERVO 11, 100
    	GOSUB �Ӹ��¿��߾�
    	ETX 4800, 225
    	GOTO RX_EXIT
    ELSEIF A = 226 THEN
    	SERVO 16,70
    	SERVO 11, 100
    	GOSUB �Ӹ�����60��
    	ETX 4800, 226
    	GOTO RX_EXIT
    ELSEIF A = 227 THEN
    	SERVO 16,70
    	SERVO 11, 100
    	GOSUB �Ӹ�������60��
    	ETX 4800, 227
    	GOTO RX_EXIT
    ELSEIF A = 228 THEN
    	SERVO 16, 20
    	SERVO 11, 100
    	GOSUB ���ܼ��Ÿ�����Ȯ��
    	GOTO RX_EXIT
    ELSEIF A = 229 THEN
    	SERVO 16,20
    	SERVO 11, 100
    	GOSUB �޹�����
    	ETX 4800, 229
    	GOTO RX_EXIT
   '-------------------------------------------
   	ELSEIF A = 231 THEN
        SERVO 16, 20
        SERVO 11, 100
        GOSUB �����ʿ�����70
        ETX 4800,231
        GOTO RX_EXIT
   	ELSEIF A = 232 THEN
        SERVO 16, 20
        SERVO 11, 100
        GOSUB ������  
        ETX 4800, 232
        GOTO RX_EXIT
    ELSEIF A = 233 THEN
        SERVO 16, 20
        SERVO 11, 100
        GOSUB ���ʿ�����70
        ETX 4800,233
        GOTO RX_EXIT
    ELSEIF A = 234 THEN
    	SERVO 11, 100
        SERVO 16, 20
        GOSUB �⺻�ڼ�
        WAIT
        ETX 4800, 234
        GOTO RX_EXIT
    ELSEIF A = 235 THEN
        SERVO 16, 20
        SERVO 11, 100
        GOSUB ������20
        ETX 4800, 235
        GOTO RX_EXIT
    ELSEIF A = 236 THEN
        SERVO 16, 20
        SERVO 11, 100
        GOSUB ��������20
        ETX 4800, 236
        GOTO RX_EXIT
	ELSEIF A = 237 THEN
        SERVO 16, 15
        SERVO 11, 100
        GOSUB ��ܿ���������
        ETX 4800, 237
        GOTO RX_EXIT
    ELSEIF A = 238 THEN
        SERVO 16, 15
        SERVO 11, 100
        GOSUB ��ܿ���������2����
        ETX 4800, 238
        GOTO RX_EXIT
    ELSEIF A = 239 THEN
        GOSUB �ͳ������� 
        SERVO 11, 100
        ETX 4800,239
        GOTO RX_EXIT
'---------------------------------------------
    ELSEIF A = 240 THEN
        GOSUB �����ɾƺ���
        ETX 4800,240
        GOTO RX_EXIT
	ELSEIF A = 241 THEN
		SERVO 16, 20
		SERVO 11, 100
		GOSUB ��������� 
		ETX 4800, 241
		GOTO RX_EXIT
	ELSEIF A = 242 THEN
		SERVO 11, 100
		GOSUB ���� 
		ETX 4800,242
		GOTO RX_EXIT
	ELSEIF A = 243 THEN
		SERVO 16, 20
		SERVO 11, 100
		GOSUB ��ܳ�����������
		ETX 4800, 243
		GOTO RX_EXIT
	ELSEIF A = 246 THEN
		GOSUB ���ʿ�����20 
		SERVO 11, 100
		ETX 4800,246
		GOTO RX_EXIT
	ELSEIF A = 247 THEN
		GOSUB �����ʿ�����20 
		SERVO 11, 100
		ETX 4800,247
		GOTO RX_EXIT
	ELSEIF A = 248 THEN
		GOSUB �Ѱ������� 
		SERVO 11, 100
		ETX 4800,248
		GOTO RX_EXIT	
	ELSEIF A = 249 THEN
		GOSUB �����޸���fast
		SERVO 11, 100
		ETX 4800,249
		GOTO RX_EXIT
	'******************************************8
	ELSEIF A = 250 THEN
		GOSUB ������60
		SERVO 11, 100
		ETX 4800,250
		GOTO RX_EXIT
	ELSEIF A = 251 THEN
		GOSUB ��������60 
		SERVO 11, 100
		ETX 4800,251
		GOTO RX_EXIT
	ELSEIF A = 252 THEN
		GOSUB �ڳ��ν�3
		SERVO 11, 100
		ETX 4800,252
		GOTO RX_EXIT	
	ELSEIF A = 253 THEN
		GOSUB �ڳ��ν�2  
		SERVO 11, 100
		ETX 4800,253
		GOTO RX_EXIT	
	ELSEIF A = 254 THEN
		GOSUB �����޸���slow
		SERVO 11, 100
		ETX 4800,254
		GOTO RX_EXIT
	ENDIF
	
	' �������� , �����ɾưȱ� �� Ÿ��.���� �ֱ� !!!

    GOTO MAIN	
    '*******************************************
    '		MAIN �󺧷� ����
    '*******************************************

KEY1:
	GOSUB ���� 
    GOTO RX_EXIT
    '***************	
KEY2:
	GOSUB ��������� 
    GOTO RX_EXIT
    '***************
KEY3:
    GOSUB �ѹ����� 
    GOTO RX_EXIT
    '***************
KEY4: 
	GOSUB �Ѱ�������  
    GOTO RX_EXIT
    '***************
KEY5:

	GOSUB ������
	
   

    GOTO RX_EXIT
    '***************
KEY6:
  
    GOSUB ��ܿ��������� 

    GOTO RX_EXIT
    '***************
KEY7:
 	GOSUB �����޸���slow

    GOTO RX_EXIT
    '***************
KEY8:

    GOSUB ������20

    GOTO RX_EXIT
    '***************
KEY9:

  


    GOTO RX_EXIT
    '***************
KEY10: '0

    GOTO �ͳ������� 

    GOTO RX_EXIT
    '***************
KEY11: ' ��
 

    GOTO ��ܳ����������� 

    GOTO RX_EXIT
    '***************
KEY12: ' ��
 
    GOTO ��������

    GOTO RX_EXIT
    '***************
KEY13: '��
   
    GOTO �����ʿ�����70


    GOTO RX_EXIT
    '***************
KEY14: ' ��
   
    GOTO ���ʿ�����70


    GOTO RX_EXIT
    '***************
KEY15: ' A
  
    GOTO ���ʿ�����20


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
    GOSUB �����ڼ�	
    GOSUB ������

    GOSUB GOSUB_RX_EXIT
KEY16_1:

    IF ����ONOFF = 1  THEN
        OUT 52,1
        DELAY 200
        OUT 52,0
        DELAY 200
    ENDIF
    ERX 4800,A,KEY16_1
    ETX  4800,A
    IF  A = 16 THEN 	'�ٽ� �Ŀ���ư�� �����߸� ����
        SPEED 10
        MOVE G6A,100, 140,  37, 145, 100, 100
        MOVE G6D,100, 140,  37, 145, 100, 100
        WAIT
        GOSUB Leg_motor_mode2
        GOSUB �⺻�ڼ�2
        GOSUB ���̷�ON
        GOSUB All_motor_mode3
        GOTO RX_EXIT
    ENDIF

    GOSUB GOSUB_RX_EXIT
    GOTO KEY16_1



    GOTO RX_EXIT
    '***************
KEY17: ' C
    ETX  4800,17
    GOTO �Ӹ�����90��


    GOTO RX_EXIT
    '***************
KEY18: ' E
    ETX  4800,18	

    GOSUB ���̷�OFF
    GOSUB ������
KEY18_wait:

    ERX 4800,A,KEY18_wait	

    IF  A = 26 THEN
        GOSUB ������
        GOSUB ���̷�ON
        GOTO RX_EXIT
    ENDIF

    GOTO KEY18_wait


    GOTO RX_EXIT
    '***************
KEY19: ' P2
    ETX  4800,19
    GOTO ��������60

    GOTO RX_EXIT
    '***************
KEY20: ' B	
    ETX  4800,20
    GOTO �����ʿ�����20


    GOTO RX_EXIT
    '***************
KEY21: ' ��
    ETX  4800,21
    GOTO �Ӹ��¿��߾�

    GOTO RX_EXIT
    '***************
KEY22: ' *	
    ETX  4800,22
    GOTO ������45

    GOTO RX_EXIT
    '***************
KEY23: ' G
    ETX  4800,23
    GOSUB ������
    GOSUB All_motor_mode2
KEY23_wait:


    ERX 4800,A,KEY23_wait	

    IF  A = 26 THEN
        GOSUB ������
        GOSUB All_motor_mode3
        GOTO RX_EXIT
    ENDIF

    GOTO KEY23_wait


    GOTO RX_EXIT
    '***************
KEY24: ' #
    ETX  4800,24
    GOTO ��������45

    GOTO RX_EXIT
    '***************
KEY25: ' P1
    ETX  4800,25
    GOTO ������60

    GOTO RX_EXIT
    '***************
KEY26: ' ��
    ETX  4800,26

    SPEED 5
    GOSUB �⺻�ڼ�2	
    TEMPO 220
    MUSIC "ff"
    GOSUB �⺻�ڼ�
    GOTO RX_EXIT
    '***************
KEY27: ' D
    ETX  4800,27
    GOTO �Ӹ�������90��


    GOTO RX_EXIT
    '***************
KEY28: ' ��
    ETX  4800,28
    GOTO �Ӹ�����45��


    GOTO RX_EXIT
    '***************
KEY29: ' ��
    ETX  4800,29

    GOSUB ��������80��

    GOTO RX_EXIT
    '***************
KEY30: ' ��
    ETX  4800,30
    GOTO �Ӹ�������45��

    GOTO RX_EXIT
    '***************
KEY31: ' ��
    ETX  4800,31
    GOSUB ��������60��

    GOTO RX_EXIT
    '***************

KEY32: ' F
    ETX  4800,32
    GOTO ������������
    GOTO RX_EXIT
    '***************
