#line 1 "F:/College/Communication_Year_2/Traning/Embeded/Traffic L Project/Project_SW.c"
#line 20 "F:/College/Communication_Year_2/Traning/Embeded/Traffic L Project/Project_SW.c"
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
  PORTD.b5  = 0;
  PORTD.b0  = 0;
  PORTD.b3  = 0;
  PORTD.b1  = 0;
  PORTD.b2  = 0;
  PORTD.b4  = 0;
}
void main() {
 trisb = 0b00000000;
 trisD = 0b00000000;
 trisc = 0b00110000;
 portC = 15;
 portB = 0;
 portD = 0;

 while(1){
 if ( PORTC.B4  == 1) {
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
 change =  PORTC.B5 ;
 if( PORTC.B5  == 1){
  PORTD.b1  = 0;
  PORTD.b2  = 0;
  PORTD.b3  = 0;
  PORTD.b0  = 1;
  PORTD.b4  = 1;
 for(i = 1; i <= 3; i++){
 portB = i;
 if(change !=  PORTC.B5  ||  PORTC.B4  == 1) break;
 Delay_ms(1000);
 }
 portB = 0;
  PORTD.b4  = 0;
  PORTD.b5  = 1;
 }else{
  PORTD.b5  = 0;
  PORTD.b4  = 0;
  PORTD.b0  = 0;
  PORTD.b3  = 1;
  PORTD.b1  = 1;
 for(i = 1; i <= 3; i++){
 portB = i;
 if(change !=  PORTC.B5  ||  PORTC.B4  == 1) break;
 Delay_ms(1000);
 }
 portB = 0;
  PORTD.b1  = 0;
  PORTD.b2  = 1;
 }
 }
 if(change !=  PORTC.B5 ) {can_ = 1;}
}
void Auto(){
  PORTD.b5  = 0;
  PORTD.b0  = 1;
  PORTD.b3  = 0;
  PORTD.b1  = 0;
  PORTD.b2  = 0;
  PORTD.b4  = 1;
 j = 0;
 tens = 0;
 for(i = 0; i < 38; i++){
 if( PORTC.B4  == 0) {
 portB = 0;
 clear();
 break;
 }
 j++;
 PORTB = j + tens;
 Delay_ms(1000);
 tmp = (tens / 16 )* 10;
 if(j + tmp == 3){
  PORTD.b4  = 0;
  PORTD.b5  = 1;
 }else if(j + tmp == 23){
  PORTD.b5  = 0;
  PORTD.b3  = 1;
  PORTD.b0  = 0;
  PORTD.b1  = 1;
 }else if(j + tmp == 26){
  PORTD.b1  = 0;
  PORTD.b2  = 1;
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
