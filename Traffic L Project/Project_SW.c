//ones B0 B1 B2 B3, Tens B4 B5
// South tl : R = D0 , G  = D2, Y = D1
// west tl : R = D3 , G = D5, Y = D4
// inputs of transestors C0, C1, C2, C3
// AUTOMATIC & MANUAL SW -> c4
// MANUAL SW -> c5

// Pin Definitions
#define SOUTH_RED   PORTD.b0
#define SOUTH_GREEN PORTD.b2
#define SOUTH_YELLOW PORTD.b1
#define WEST_RED    PORTD.b3
#define WEST_GREEN  PORTD.b5
#define WEST_YELLOW PORTD.b4

// Input Pins
#define AUTO_MANU_SW PORTC.B4
#define MANUAL_SW     PORTC.B5

void Auto();
void manual();
char can_ = 1;
char change = 0;
char c_ = 16;
char tens = 0;
char j = 0;
char i = 0;
char tmp;
void clear(){
   WEST_GREEN = 0;
   SOUTH_RED = 0;
   WEST_RED = 0;
   SOUTH_YELLOW = 0;
   SOUTH_GREEN = 0;
   WEST_YELLOW = 0;
}
void main() {
     trisb = 0b00000000;
     trisD = 0b00000000;
     trisc = 0b00110000;
     portC = 15;
     portB = 0;
     portD = 0;

     while(1){
        if (AUTO_MANU_SW == 1) {
            Clear();
            can_ = 1;
            Auto();
        }else {
            Manual();
        }
     }
}
void manual(){
     if(can_ == 1){
           can_ = 0;
           change = MANUAL_SW;
           if(MANUAL_SW == 1){
               SOUTH_YELLOW = 0;
               SOUTH_GREEN = 0;
               WEST_RED = 0;
               SOUTH_RED = 1;
               WEST_YELLOW = 1;
               for(i = 1; i <= 3; i++){
                      portB = i;
                      if(change  != MANUAL_SW || AUTO_MANU_SW == 1) break;
                      Delay_ms(1000);
               }
               portB = 0;
               WEST_YELLOW = 0;
               WEST_GREEN = 1;
           }else{
               WEST_GREEN = 0;
               WEST_YELLOW = 0;
               SOUTH_RED = 0;
               WEST_RED = 1;
               SOUTH_YELLOW = 1;
               for(i = 1; i <= 3; i++){
                      portB = i;
                      if(change  != MANUAL_SW || AUTO_MANU_SW == 1) break;
                      Delay_ms(1000);
               }
               portB = 0;
               SOUTH_YELLOW = 0;
               SOUTH_GREEN = 1;
           }
     }
     if(change  != MANUAL_SW) {can_ = 1;}
}
void Auto(){
     WEST_GREEN = 0;
     SOUTH_RED = 1;
     WEST_RED = 0;
     SOUTH_YELLOW = 0;
     SOUTH_GREEN = 0;
     WEST_YELLOW = 1;
     j = 0;
     tens = 0;
     for(i = 0; i < 38; i++){
            if(AUTO_MANU_SW == 0) {
               portB = 0;
               clear();
               break;
            }
            j++;
            PORTB = j + tens;
            Delay_ms(1000);
            tmp = (tens / 16 )* 10;
            if(j + tmp == 3){
               WEST_YELLOW = 0;
               WEST_GREEN = 1;
            }else if(j + tmp == 23){
                WEST_GREEN = 0;
                WEST_RED = 1;
                SOUTH_RED = 0;
                SOUTH_YELLOW = 1;
            }else if(j + tmp == 26){
                SOUTH_YELLOW = 0;
                SOUTH_GREEN = 1;
            }
            if(j == 9){
                 tens += c_;
                 j = 0;
                 PORTB = j + tens;
                 Delay_ms(1000);
                 i++;
            }
     }
     clear();
}