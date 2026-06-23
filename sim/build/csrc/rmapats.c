// file = 0; split type = patterns; threshold = 100000; total count = 0.
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "rmapats.h"

void  schedNewEvent (struct dummyq_struct * I1466, EBLK  * I1461, U  I627);
void  schedNewEvent (struct dummyq_struct * I1466, EBLK  * I1461, U  I627)
{
    U  I1756;
    U  I1757;
    U  I1758;
    struct futq * I1759;
    struct dummyq_struct * pQ = I1466;
    I1756 = ((U )vcs_clocks) + I627;
    I1758 = I1756 & ((1 << fHashTableSize) - 1);
    I1461->I673 = (EBLK  *)(-1);
    I1461->I674 = I1756;
    if (0 && rmaProfEvtProp) {
        vcs_simpSetEBlkEvtID(I1461);
    }
    if (I1756 < (U )vcs_clocks) {
        I1757 = ((U  *)&vcs_clocks)[1];
        sched_millenium(pQ, I1461, I1757 + 1, I1756);
    }
    else if ((peblkFutQ1Head != ((void *)0)) && (I627 == 1)) {
        I1461->I676 = (struct eblk *)peblkFutQ1Tail;
        peblkFutQ1Tail->I673 = I1461;
        peblkFutQ1Tail = I1461;
    }
    else if ((I1759 = pQ->I1367[I1758].I696)) {
        I1461->I676 = (struct eblk *)I1759->I694;
        I1759->I694->I673 = (RP )I1461;
        I1759->I694 = (RmaEblk  *)I1461;
    }
    else {
        sched_hsopt(pQ, I1461, I1756);
    }
}
#ifdef __cplusplus
extern "C" {
#endif
void SinitHsimPats(void);
#ifdef __cplusplus
}
#endif
