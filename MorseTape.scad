// Morse tape module
// It is licensed under the Creative Commons - GNU GPL license.
// © 2015 by Petr Mironkin neharon@ya.ru
// If you like this holder you can donate, please use
// https://www.paypal.me/mirok

tolerance=0.01;
//Morse Tape Params (plan: https://upload.wikimedia.org/wikipedia/commons/9/99/Morse_Taper.png) 
MT_Params=[
//0 MT№,   1 ctg(a),    2 D,       	3 D1, 	4 d, 	5 d1, 	6 d2, 	7 d3max,8 d4max,9 d5,   10 l1max,   11 l2 max,  12 l3 max, 	13 l4 max, 	14 l5 min, 	15 l6,  16 e max,   17 R,   18 b,          
[0,        19.212, 	    9.045, 	    9.2, 	6.4, 	0,  	6.1, 	6,   	6,  	6.7, 	50, 	    53, 	    56.3,   	59.5,   	52,     	49,     10.5,       4,      3.9,],
[1,        20.047, 	    12.065, 	12.2, 	9.4,	6, 	    9, 	    8.7, 	9, 	    9.7, 	53.5, 	    57, 	    62, 	    65.5, 	    56,     	52,     13.5,       5,      5.2,],
[2,        20.020, 	    17.780, 	18,	    14.6, 	10, 	14,	    13.5, 	14, 	14.9, 	64, 	    69, 	    75, 	    80,     	67,     	62,     16,         6,      6.3,],
[3,        19.922, 	    23.825, 	24.1, 	19.8, 	12, 	19.1, 	18.5, 	19, 	20.2, 	80.1, 	    86, 	    94, 	    99,     	84,     	78,     20,         7,      7.9,],
[4,        19.254, 	    31.267, 	31.6, 	25.9, 	16, 	25.2, 	24.5, 	24, 	26.5, 	102.5, 	    109, 	    117.5,   	124,    	107,    	98,     24,         8,      11.9,],
[5,        19.002, 	    44.399, 	44.7, 	37.6, 	20, 	36.5, 	35.7, 	35.7, 	38.2, 	129.5, 	    136, 	    149.5,   	156,    	135,    	125,    29,         10,     15.9,],
[6,        19.180, 	    63.348, 	63.8, 	53.9, 	24, 	52.4, 	50, 	51, 	54.6, 	182, 	    190, 	    210,    	218,    	188,    	177,    40,         13,     19,],
[7,        19.231, 	    83.058,     0,      0,      0,      0,      0,      0,      0,      0,          0,          0,           0,         0,         0] 													
];

//test code
for(n=[0:6]){
    translate([(MT_Params[n][3]+40)*n,0,0])
        mt(n);
}

//build morse tape number N
module mt(N){
    translate([0,0,-MT_Params[N][13]])
    difference(){
        union(){
    d1=MT_Params[N][6]-MT_Params[N][17]/MT_Params[N][1];
    translate([0,0,MT_Params[N][16]-MT_Params[N][17]])
        cylinder($tn = 100, h = MT_Params[N][13]-MT_Params[N][16]+MT_Params[N][17],d1=d1,d2=MT_Params[N][3]);
        cylinder($tn = 100, h = MT_Params[N][16]-MT_Params[N][17],d=MT_Params[N][7]);
        }
        union(){
            for(i=[1,-1]){
                translate([i*MT_Params[N][18]/2+(i-1)*MT_Params[N][16]/2,-MT_Params[N][3]/2,-tolerance])
                    cube([MT_Params[N][16],MT_Params[N][3],MT_Params[N][16]-MT_Params[N][17]]);
                translate([i*MT_Params[N][18]/2+MT_Params[N][17]+(i-1)*MT_Params[N][17],MT_Params[N][3]/2,,MT_Params[N][16]-MT_Params[N][17]])
                    rotate([90,0,0])
                        cylinder($tn = 100, h =MT_Params[N][3],r=MT_Params[N][17]);
                translate([0,0,,-MT_Params[N][7]/2])   
                    rotate([i*8.2,0,0])
                        cube([MT_Params[N][18]+tolerance,MT_Params[N][7]*1.2,MT_Params[N][7]],center = true);
            }
        }
    }
   }