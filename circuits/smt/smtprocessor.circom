/***************************************************************************************************

Insert to an empty leaf
=======================

  STATE                 OLD STATE                                       NEW STATE
  =====                 =========                                       =========

                         oldRoot                                          newRoot
                            ▲                                               ▲
                            │                                               │
          ┌───────┐     ┏━━━┻━━━┓                         ┌───────┐     ┏━━━┻━━━┓
   top    │Sibling├────▶┃ Hash  ┃◀─┐                      │Sibling├────▶┃ Hash  ┃◀─┐
          └───────┘     ┗━━━━━━━┛  │                      └───────┘     ┗━━━━━━━┛  │
                                   │                                               │
                                   │                                               │
                               ┏━━━┻━━━┓   ┌───────┐                           ┏━━━┻━━━┓   ┌───────┐
   top                  ┌─────▶┃ Hash  ┃◀──┤Sibling│                    ┌─────▶┃ Hash  ┃◀──┤Sibling│
                        │      ┗━━━━━━━┛   └───────┘                    │      ┗━━━━━━━┛   └───────┘
                        │                                               │
                        │                                               │
        ┌───────┐   ┏━━━┻━━━┓                           ┌───────┐   ┏━━━┻━━━┓
   top  │Sibling├──▶┃ Hash  ┃◀─────┐                    │Sibling├──▶┃ Hash  ┃◀─────┐
        └───────┘   ┗━━━━━━━┛      │                    └───────┘   ┗━━━━━━━┛      │
                                   │                                               │
                                   │                                               │
                              ┌────┴────┐                                     ┌────┴────┐
  old0                        │    0    │                                     │New1Leaf │
                              └─────────┘                                     └─────────┘


                     ┏━━━━━━━┓                                      ┏━━━━━━━┓
   na                ┃ Hash  ┃                                      ┃ Hash  ┃
                     ┗━━━━━━━┛                                      ┗━━━━━━━┛


                     ┏━━━━━━━┓                                      ┏━━━━━━━┓
   na                ┃ Hash  ┃                                      ┃ Hash  ┃
                     ┗━━━━━━━┛                                      ┗━━━━━━━┛



Insert to a used leaf.
=====================

  STATE                 OLD STATE                                       NEW STATE
  =====                 =========                                       =========


                         oldRoot                                          newRoot
                            ▲                                               ▲
                            │                                               │
          ┌───────┐     ┏━━━┻━━━┓                         ┌───────┐     ┏━━━┻━━━┓
   top    │Sibling├────▶┃ Hash  ┃◀─┐                      │Sibling├────▶┃ Hash  ┃◀─┐
          └───────┘     ┗━━━━━━━┛  │                      └───────┘     ┗━━━━━━━┛  │
                                   │                                               │
                                   │                                               │
                               ┏━━━┻━━━┓   ┌───────┐                           ┏━━━┻━━━┓   ┌───────┐
   top                  ┌─────▶┃ Hash  ┃◀──┤Sibling│                    ┌─────▶┃ Hash  ┃◀──┤Sibling│
                        │      ┗━━━━━━━┛   └───────┘                    │      ┗━━━━━━━┛   └───────┘
                        │                                               │
                        │                                               │
        ┌───────┐   ┏━━━┻━━━┓                           ┌───────┐   ┏━━━┻━━━┓
   top  │Sibling├──▶┃ Hash  ┃◀─────┐                    │Sibling├──▶┃ Hash  ┃◀─────┐
        └───────┘   ┗━━━━━━━┛      │                    └───────┘   ┗━━━━━━━┛      │
                                   │                                               │
                                   │                                               │
                              ┌────┴────┐                                      ┏━━━┻━━━┓   ┌───────┐
   bot                        │Old1Leaf │                               ┌─────▶┃ Hash  ┃◀──┼─  0   │
                              └─────────┘                               │      ┗━━━━━━━┛   └───────┘
                                                                        │
                                                                        │
                     ┏━━━━━━━┓                          ┌───────┐   ┏━━━┻━━━┓
   bot               ┃ Hash  ┃                          │   0  ─┼──▶┃ Hash  ┃◀─────┐
                     ┗━━━━━━━┛                          └───────┘   ┗━━━━━━━┛      │
                                                                                   │
                                                                                   │
                     ┏━━━━━━━┓                                                 ┏━━━┻━━━┓   ┌───────┐
   bot               ┃ Hash  ┃                                          ┌─────▶┃ Hash  ┃◀──│   0   │
                     ┗━━━━━━━┛                                          │      ┗━━━━━━━┛   └───────┘
                                                                        │
                                                                        │
                     ┏━━━━━━━┓                        ┌─────────┐   ┏━━━┻━━━┓   ┌─────────┐
  new1               ┃ Hash  ┃                        │Old1Leaf ├──▶┃ Hash  ┃◀──│New1Leaf │
                     ┗━━━━━━━┛                        └─────────┘   ┗━━━━━━━┛   └─────────┘


                     ┏━━━━━━━┓                                      ┏━━━━━━━┓
   na                ┃ Hash  ┃                                      ┃ Hash  ┃
                     ┗━━━━━━━┛                                      ┗━━━━━━━┛


                     ┏━━━━━━━┓                                      ┏━━━━━━━┓
   na                ┃ Hash  ┃                                      ┃ Hash  ┃
                     ┗━━━━━━━┛                                      ┗━━━━━━━┛


Fnction
fnc[0]  fnc[1]
0       0             NOP
0       1             UPDATE
1       0             INSERT
1       1             DELETE


***************************************************************************************************/

include "../gates.circom";
include "../bitify.circom";
include "../comparators.circom";
include "../switcher.circom";
include "smtlevins.circom";
include "smtprocessorlevel.circom";
include "smtprocessorsm.circom";
include "smthash.circom";

template SMTProcessor(nLevels) {
    signal input oldRoot;
    signal input newRoot;
    signal input siblings[nLevels];
    signal input oldKey;
    signal input oldValue;
    signal input isOld0;
    signal input newKey;
    signal input newValue;
    signal input fnc[2];

    signal enabled;

    enabled <== fnc[0] + fnc[1] - fnc[0]*fnc[1]

    component hash1Old = SMTHash1();
    hash1Old.key <== oldKey;
    hash1Old.value <== oldValue;

    component hash1New = SMTHash1();
    hash1New.key <== newKey;
    hash1New.value <== newValue;

    component n2bOld = Num2Bits_strict();
    component n2bNew = Num2Bits_strict();

    n2bOld.in <== oldKey;
    n2bNew.in <== newKey;

    component smtLevIns = SMTLevIns(nLevels);
    for (var i=0; i<nLevels; i++) smtLevIns.siblings[i] <== siblings[i];
    smtLevIns.enabled <== enabled;

    component xors[nLevels];
    for (var i=0; i<nLevels; i++) {
        xors[i] = XOR();
        xors[i].a <== n2bOld.out[i];
        xors[i].b <== n2bNew.out[i];
    }

    component sm[nLevels];
    for (var i=0; i<nLevels; i++) {
        sm[i] = SMTProcessorSM();
        if (i==0) {
            sm[i].prev_top <== enabled;
            sm[i].prev_old0 <== 0;
            sm[i].prev_bot <== 0;
            sm[i].prev_new1 <== 0;
            sm[i].prev_na <== 1-enabled;
            sm[i].prev_upd <== 0;
        } else {
            sm[i].prev_top <== sm[i-1].st_top;
            sm[i].prev_old0 <== sm[i-1].st_old0;
            sm[i].prev_bot <== sm[i-1].st_bot;
            sm[i].prev_new1 <== sm[i-1].st_new1;
            sm[i].prev_na <== sm[i-1].st_na;
            sm[i].prev_upd <== sm[i-1].st_upd;
        }
        sm[i].is0 <== isOld0;
        sm[i].xor <== xors[i].out;
        sm[i].fnc[0] <== fnc[0];
        sm[i].fnc[1] <== fnc[1];
        sm[i].levIns <== smtLevIns.levIns[i];
    }
    sm[nLevels-1].st_na === 1;

    component levels[nLevels];
    for (var i=nLevels-1; i != -1; i--) {
        levels[i] = SMTProcessorLevel();

        levels[i].st_top <== sm[i].st_top;
        levels[i].st_old0 <== sm[i].st_old0;
        levels[i].st_bot <== sm[i].st_bot;
        levels[i].st_new1 <== sm[i].st_new1;
        levels[i].st_na <== sm[i].st_na;
        levels[i].st_upd <== sm[i].st_upd;

        levels[i].sibling <== siblings[i];
        levels[i].old1leaf <== hash1Old.out;
        levels[i].new1leaf <== hash1New.out;

        levels[i].newlrbit <== n2bNew.out[i];
        if (i==nLevels-1) {
            levels[i].oldChild <== 0;
            levels[i].newChild <== 0;
        } else {
            levels[i].oldChild <== levels[i+1].oldRoot;
            levels[i].newChild <== levels[i+1].newRoot;
        }
    }

    component topSwitcher = Switcher();

    topSwitcher.sel <== fnc[0]*fnc[1];
    topSwitcher.L <== levels[0].oldRoot;
    topSwitcher.R <== levels[0].newRoot;

    topSwitcher.outL === oldRoot*enabled;
    topSwitcher.outR === newRoot*enabled;
}