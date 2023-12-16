pragma circom 2.1.5;

include "../../circuits/escalarmul/escalarmul.circom";
include "../../circuits/tags-managing.circom";

template Main() {
    signal input in[256];
    signal output out[2];
    
    signal {binary} aux_in[256] <== BinaryCheckArray(256)(in);
    var i;

    var base[2] = [5299619240641551281634865583518297030282874472190772894086521144482721001553, 16950150798460657717958625567821834550301663161624707787222815936182638968203];

    component escalarMul = EscalarMul(256, base);

    escalarMul.inp[0] <== 0;
    escalarMul.inp[1] <== 1;

    for  (i=0; i<256; i++) {
        aux_in[i] ==> escalarMul.in[i];
    }

    escalarMul.out[0] ==> out[0];
    escalarMul.out[1] ==> out[1];
}

component main = Main();
