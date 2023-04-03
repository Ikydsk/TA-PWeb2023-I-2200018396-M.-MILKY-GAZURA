.MODEL SMALL

STACK SEGMENT PARA STACK 
   DB 2048 DUP(" ")

STACK ENDS

.DATA
    ;LEBAR GAME
    GAME_WIDTH DW 140H

    ;DATA DINOSAURUS
    DINO_Y DW 90H
    DINO_X DW 20H
    DINO_X_SIZE DW 8H
    DINO_Y_SIZE DW ?

    ;DATA CACTUS
    CACTUS_X DW 140H
    CACTUS_Y DW 90H
    CACTUS_X_SIZE DW 8H
    CACTUS_Y_SIZE DW 16H
    CACTUS_SPEED DW 05H

    ;DATA BURUNG 
    BIRD_X DW 200H
    BIRD_Y DW 85H
    BIRD_X_SIZE DW 16H
    BIRD_Y_SIZE DW 6H 
    
    ;VARIABEL WAKTU
    TIME_VAR DB 05H
    
    ;FLAGS
    FLAG1 DW 0H
    FLAG2 DW 0H
    EXIT_FLAG DW 0H
    
    ;VARIABEL SCORE
    SCORE_TIME DW 0H
    SCORE1 DB 0H
    SCORE2 DB 0H
    SCORE3 DB 0H
    SCORE4 DB 0H


    ;STRING UNTUK DIPRINT
    DISPLAY_TEXT1 DB '0','$'
    DISPLAY_TEXT2 DB '0','$'
    DISPLAY_TEXT3 DB '0','$'
    DISPLAY_TEXT4 DB '0','$'
    DISPLAY_TEXTH1 DB '0','$'
    DISPLAY_TEXTH2 DB '0','$'
    DISPLAY_TEXTH3 DB '0','$'
    DISPLAY_TEXTH4 DB '0','$'
    GAMEOVER_TEXT DB 'GAMEOVER','$'


.CODE

;MACRO KETIKA GAMEOVER UNTUK MENGEPRINT KATA GAMEOVER
GAMEOVER_GAM MACRO
    ;MENGGERAKKAN CURSOR UNTUK MENGEPRINT PADA LOKASI TERTENTU
    MOV AH,02H
    MOV BH,00H
    MOV DH,01H
    MOV DL,01H
    INT 10H
    ;MENGEPRINT TEXT
    MOV AH,09H
    LEA DX,GAMEOVER_TEXT
    INT 21H
    ;MEMINTA INPUT
    MOV AH,00H
    INT 16H

    CMP AL,77h
    JNE EXITS
    CALL RESET_GAME
    JMP GAMEON

ENDM

main PROC near 

    CALL CLEAR_SCREEN
    TIME_CHECK:
        ;CEK WAKTU SISTEM
        MOV AH,2CH
        INT 21H
        ;APAKAH ADA PERUBAHAN WAKTU
        CMP DL,TIME_VAR
        JE TIME_CHECK
        ;APAKAH ADA PERUBAHAN WAKTU SEBESAR 20ms
        INC SCORE_TIME
        CMP SCORE_TIME,5H
        JNE NO_SCORE
        MOV SCORE_TIME,00H
        ;APABILA TIDAK ADA PERMAINAN SCORE MENGECEK APAKAH ADA TABRAKAN ANTARA DINO DAN OBJEK LAINNYA
        NO_SCORE:
        CALL COLLISION_CHECK
        CMP EXIT_FLAG,00H
        JNE GAMEOVER
        JMP GAMEON
        ;KETIKA COLLISION CHECK BENAR MAKA AKAN MENJALANKAN GAMEOVER
        GAMEOVER:
            GAMEOVER_GAM
        ;PROSES KETIKA GAME MASIH DIMAINKAN MENGEPRINT OBJEK KE LAYAR
        GAMEON:
        CALL CACTUS_MOVE
        CALL BIRD_MOVE
        MOV TIME_VAR,DL
        CALL CLEAR_SCREEN
        CALL GROUND_DRAW
        CALL DINO_MOVE
        CMP FLAG2,1H
        JE NUNDUK
        CALL DINO_DRAW_STAND
        JMP EXIT3
        ;KETIKA ADA INPUT 's'MAKA POSISI DINO AKAN MENUNDUK
        NUNDUK:
        CALL DINO_DRAW_CROUCH
        MOV FLAG2,00H
        ;KETIKA TIDAK MENUNDUK
        EXIT3:
        CALL CACTUS_DRAW
        CALL BIRD_DRAW
        JMP TIME_CHECK
    EXITS:
    RET

main ENDP
;DIGUNAKAN UNTUK MENGGAMBAR TANAH
GROUND_DRAW PROC near
    MOV DL,00H
    CHAR1_LOOP:
        MOV AH,02h
        MOV BH,00H
        MOV DH,12H
        INT 10H
        MOV AH,09H
        MOV AL,12H
        MOV BH,00H
        MOV BL,0FH
        MOV CX,01H
        INT 10H
        INC DL
    CHAR2_LOOP:
        MOV AH,02h
        MOV BH,00H
        MOV DH,12H
        INT 10H
        MOV AH,09H
        MOV AL,13H
        MOV BH,00H
        MOV BL,0FH
        MOV CX,01H
        INT 10H
        INC DL
        CMP DL,28H
        JNE CHAR1_LOOP

    RET
GROUND_DRAW ENDP

;MENGGAMBAR DINO KETIKA BERDIRI
DINO_DRAW_STAND PROC near
    MOV DINO_Y_SIZE, 16H
    MOV CX,DINO_X
    MOV DX,DINO_Y
    SUB CX,DINO_X_SIZE
    SUB DX,DINO_Y_SIZE
    DINO_DRAWB_H:
        MOV AH,0CH
        MOV AL,0FH
        MOV BH,00H
        INT 10H
        INC CX
        CMP CX,DINO_X
        JNE DINO_DRAWB_H
    DINO_DRAWB_V:
        MOV CX,DINO_X
        SUB CX,DINO_X_SIZE
        INC DX
        CMP DX,DINO_Y
        JNE DINO_DRAWB_H

    RET

DINO_DRAW_STAND ENDP

;MENGGAMBAR DINO KETIKA MENUNDUK
DINO_DRAW_CROUCH PROC near
    MOV DINO_Y_SIZE, 8H
    MOV CX,DINO_X
    MOV DX,DINO_Y
    SUB CX,DINO_X_SIZE
    SUB DX,DINO_Y_SIZE
    DINO_DRAWBC_H:
        MOV AH,0CH
        MOV AL,0FH
        MOV BH,00H
        INT 10H
        INC CX
        CMP CX,DINO_X
        JNE DINO_DRAWBC_H
    DINO_DRAWBC_V:
        MOV CX,DINO_X
        SUB CX,DINO_X_SIZE
        INC DX
        CMP DX,DINO_Y
        JNE DINO_DRAWBC_H
    MOV CX,DINO_X
    MOV DX,DINO_Y
    SUB DX,8H
    ADD CX,06H
    DINO_DRAWH_HEAD:
        MOV AH,0CH
        MOV AL,0FH
        MOV BH,00H
        INT 10H
        DEC CX
        CMP CX,DINO_X
        JNE DINO_DRAWH_HEAD
    DINO_DRAWV_HEAD:
        MOV CX,DINO_X
        ADD CX,06H
        INC DX
        MOV BX,DINO_Y
        SUB BX,5H
        CMP DX,BX
        MOV BX,00H
        JNE DINO_DRAWH_HEAD
    RET

    DINO_DRAW_CROUCH ENDP

    ;MENGGERAKKAN DINO
    DINO_MOVE PROC NEAR

        ;CEK APAKAH KEY TERTEKAN
        CMP DINO_Y,90H
        JNE MOVE_DINO_UP

        MOV AH, 01
        INT 16H
        JZ EXIT_KEY

        ;CEK KEY MANA YANG TERTEKAN (INPUT DISIMPAN KE AL)
        MOV AH,00H
        INT 16H

        CMP AL,77h  ;APAKAH W TERTEKAN
        JE MOVE_DINO_UP

        CMP AL,73H  ;APAKAH S TERTEKAN
        JE MOVE_DINO_DOWN

        JNE EXIT_KEY

        ;PROSES KETIKA DINO LONCAT
        MOVE_DINO_UP:
            MOV AH, 01
            INT 16H
            JZ MOVEUP1

            ;CEK KEY MANA YANG TERTEKAN (INPUT DISIMPAN KE AL)
            MOV AH,00H
            INT 16H

            CMP AL,73h   ;APAKAH W TERTEKAN
            JE MOVE_DINO_DOWN
            MOVEUP1:
            MOV FLAG2,00H
            MOV AX,FLAG1
            CMP AX,01H
            JE MOVEDOWN
            ;PROSES KETIKA DINO BERGERAK KE ATAS
            MOVEUP:
                 SUB DINO_Y,05H
                 MOV BX,DINO_Y
                 CMP DINO_Y,40H
                 JNL EXIT_KEY
                 INC AX
                 MOV FLAG1,AX
            ;PROSES KETIKA DINO BERGERAK KE BAWAH (GRAVITASI)
            MOVEDOWN:
                ADD DINO_Y,05H
                CMP DINO_Y,90H
                JNG EXIT_KEY
                MOV DINO_Y,90H
                MOV AX,FLAG1
                DEC AX
                MOV FLAG1,AX
                JMP EXIT_KEY
            ;PROSES KETIKA DINO MENUNDUK
            MOVE_DINO_DOWN:
                MOV FLAG2,01H
                MOV DINO_Y,90H
                JMP EXIT_KEY

            EXIT_KEY:

            RET

        DINO_MOVE ENDP

        ;PROSES MENGGAMBAR KAKTUS
        CACTUS_DRAW PROC near
            MOV CX,CACTUS_X
            MOV DX,CACTUS_Y
            SUB DX,CACTUS_Y_SIZE
            SUB CX,CACTUS_X_SIZE
            CACTUS_DRAW_H:
                MOV AH,0CH
                MOV AL,0AH
                MOV BH,00H
                INT 10H
                INC CX
                CMP CX,CACTUS_X
                JNE CACTUS_DRAW_H
            CACTUS_DRAW_V:
                MOV CX,CACTUS_X
                SUB CX,CACTUS_X_SIZE
                INC DX
                CMP DX,CACTUS_Y
                JNE CACTUS_DRAW_H

            RET
        CACTUS_DRAW ENDP

        ;PROSES MENGGERAKKAN CACTUS
        CACTUS_MOVE PROC near
            ;MENGECEK APAKAH KAKTUS SUDAH DIUJUNG SEBELAH KIRI
            CMP CACTUS_X,08H
            JNG RESET
            ;MENGGERAKKAN KAKTUS DENGAN KECEPATAN TERTENTU
            MOV AX, CACTUS_SPEED
            SUB CACTUS_X,AX
            JMP LANJUT
            RESET:
            MOV AX,GAME_WIDTH
            MOV CACTUS_X,AX
            LANJUT:
            RET
        CACTUS_MOVE ENDP

        ;MENGGAMBAR BURUNG
        BIRD_DRAW PROC near
            MOV CX,BIRD_X
            CMP CX,140H
            JG EXIT1
            MOV DX,BIRD_Y
            SUB DX,BIRD_Y_SIZE
            SUB CX,BIRD_X_SIZE
            BIRD_DRAW_H:
                MOV AH,0CH
                MOV AL,06H
                MOV BH,00H
                INT 10H
                INC CX
                CMP CX,BIRD_X
                JNE BIRD_DRAW_H
            BIRD_DRAW_V:
                MOV CX,BIRD_X
                SUB CX,BIRD_X_SIZE
                INC DX
                CMP DX,BIRD_Y
                JNE BIRD_DRAW_H
            EXIT1:
            RET
        BIRD_DRAW ENDP

        ;MENGGERAKKAN BURUNG
        BIRD_MOVE PROC near
            ;MENGECEK APAKAH BURUNG SUDAH DIPOJOK KIRI
            CMP BIRD_X,08H
            JNG RESET1
            ;MENGGERAKKAN BURUNG DENGAN KECEPATAN SAMA DENGAN KAKTUS
            MOV AX, CACTUS_SPEED
            SUB BIRD_X,AX
            JMP LANJUT2
            RESET1:
            MOV AX,GAME_WIDTH
            MOV BIRD_X,AX
            LANJUT2:
            RET
        BIRD_MOVE ENDP

        COLLISION_CHECK PROC near
            ;CEK DINO CACTUS X
            MOV AX,CACTUS_X
            SUB AX,CACTUS_X_SIZE
            CMP DINO_X,AX
            JNGE BIRD_CHECK
            MOV AX, DINO_X
            SUB AX,DINO_X_SIZE
            CMP CACTUS_X,AX
            JNGE BIRD_CHECK
            ;CEK DINO-CACTUS Y
            MOV AX,CACTUS_Y
            SUB AX,CACTUS_Y_SIZE
            CMP DINO_Y,AX
            JL BIRD_CHECK

            INC EXIT_FLAG
            JMP EXIT4

            BIRD_CHECK:
            ;CEK DINO-BIRD X
            MOV AX,BIRD_X
            SUB AX,BIRD_X_SIZE
            CMP DINO_X,AX
            JNGE EXIT4
            MOV AX,DINO_X
            SUB AX,DINO_X_SIZE
            CMP BIRD_X,AX
            JNGE EXIT4
            ;CEK DINO-BIRD Y
            MOV AX,BIRD_Y
            SUB AX,BIRD_Y_SIZE
            CMP DINO_Y,AX
            JL EXIT4

            MOV AX, DINO_Y
            SUB AX, DINO_Y_SIZE
            CMP AX, BIRD_Y
            JG EXIT4

            INC EXIT_FLAG
            EXIT4:

            RET

        COLLISION_CHECK ENDP


        ;MENGATUR ULANG SEMUA PARAMETER KE KONDISI AWAL
        RESET_GAME PROC NEAR
            MOV DINO_Y, 90H
            MOV DINO_X, 20H

            MOV CACTUS_X,140H
            MOV CACTUS_Y, 90H

            MOV BIRD_X, 200H
            MOV BIRD_Y, 85H

            MOV FLAG1, 0H
            MOV FLAG2, 0H
            MOV EXIT_FLAG, 0H

            MOV SCORE_TIME, 0H

            MOV SCORE1 ,0H
            MOV SCORE2 ,0H
            MOV SCORE3 ,0H
            MOV SCORE4 ,0H
            MOV DISPLAY_TEXT1, 30H
            MOV DISPLAY_TEXT2, 30H
            MOV DISPLAY_TEXT3, 30H
            MOV DISPLAY_TEXT4, 30H

            MOV AX,00H
            MOV DX,00H
            MOV CX,00H
            MOV BX,00H

            RET
        RESET_GAME ENDP


        ;MENGATUR SCREEN DENGAN BACKGROUND HITAM (DIGUNAKAN UNTUK MEMBENTUK EFEK PENGHAPUSAN OBJEK DILAYAR)
        CLEAR_SCREEN PROC near
            MOV AH,00h
            MOV AL,13h
            INT 10h

            MOV AH,0BH
            MOV BH,00H
            MOV BL,00H
            INT 10h

            RET
        CLEAR_SCREEN ENDP

        .STARTUP
          call main
        END





































