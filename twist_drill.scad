///test 
twist_drill(10);

twist_drill_param=[
/*
[d,     b,      f,      K,      q],
*/
[9.9,   5.8,    0.95,   1.45,   9.1],
[10,    5.9,    1,      1.5,    9.2],
[10.5,  6.0,    1,      1.5,    9.3],
];

module twist_drill(d){
    for(id=twist_drill_param)
        if(id[0]==d){
            K=id[3];
            echo(K);
            difference(){
            circle($fn=100, d = d);
                for(i=[-1,1]){
                    translate([i*(K/2+d/4),i*d/4,0])
                        square([d/2,d/2],center=true);
                    translate([i*(K/4+d/4),0,0])                       circle($fn=100, d = d/2-K/2);
                }
    }
}
}