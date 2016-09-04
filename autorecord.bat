

HInit -S traindat -M hmmlist\hmm0 -l TK -H hmmlist\hmmproto\TK TK
HInit -S traindat -M hmmlist\hmm0 -l SR -H hmmlist\hmmproto\SR SR
HInit -S traindat -M hmmlist\hmm0 -l HE -H hmmlist\hmmproto\HE HE
HInit -S traindat -M hmmlist\hmm0 -l HAU -H hmmlist\hmmproto\HAU HAU
HInit -S traindat -M hmmlist\hmm0 -l GM -H hmmlist\hmmproto\GM GM
HInit -S traindat -M hmmlist\hmm0 -l GA -H hmmlist\hmmproto\GA GA
HInit -S traindat -M hmmlist\hmm0 -l GN -H hmmlist\hmmproto\GN GN
HInit -S traindat -M hmmlist\hmm0 -l ssil -H hmmlist\hmmproto\ssil ssil
HInit -S traindat -M hmmlist\hmm0 -l sp -H hmmlist\hmmproto\sp sp

findstr /V "VECSIZE"  E:\matlabhtk\hmmlist\hmm0\GM > E:\matlabhtk\hmmlist\hmm0\GMnew
findstr /V "STREAMINFO"  E:\matlabhtk\hmmlist\hmm0\GMnew > E:\matlabhtk\hmmlist\hmm0\GMnew2
findstr /V "~o"  E:\matlabhtk\hmmlist\hmm0\GMnew > E:\matlabhtk\hmmlist\hmm0\GMnew3

findstr /V "VECSIZE"  E:\matlabhtk\hmmlist\hmm0\GN > E:\matlabhtk\hmmlist\hmm0\GNnew
findstr /V "STREAMINFO"  E:\matlabhtk\hmmlist\hmm0\GNnew > E:\matlabhtk\hmmlist\hmm0\GNnew2
findstr /V "~o"  E:\matlabhtk\hmmlist\hmm0\GNnew > E:\matlabhtk\hmmlist\hmm0\GNnew3

findstr /V "VECSIZE"  E:\matlabhtk\hmmlist\hmm0\HAU > E:\matlabhtk\hmmlist\hmm0\HAUnew
findstr /V "STREAMINFO"  E:\matlabhtk\hmmlist\hmm0\HAUnew > E:\matlabhtk\hmmlist\hmm0\HAUnew2
findstr /V "~o"  E:\matlabhtk\hmmlist\hmm0\HAUnew > E:\matlabhtk\hmmlist\hmm0\HAUnew3

findstr /V "VECSIZE"  E:\matlabhtk\hmmlist\hmm0\HE > E:\matlabhtk\hmmlist\hmm0\HEnew
findstr /V "STREAMINFO"  E:\matlabhtk\hmmlist\hmm0\HEnew > E:\matlabhtk\hmmlist\hmm0\HEnew2
findstr /V "~o"  E:\matlabhtk\hmmlist\hmm0\HEnew > E:\matlabhtk\hmmlist\hmm0\HEnew3

findstr /V "VECSIZE"  E:\matlabhtk\hmmlist\hmm0\sp > E:\matlabhtk\hmmlist\hmm0\spnew
findstr /V "STREAMINFO"  E:\matlabhtk\hmmlist\hmm0\spnew > E:\matlabhtk\hmmlist\hmm0\spnew2
findstr /V "~o"  E:\matlabhtk\hmmlist\hmm0\spnew > E:\matlabhtk\hmmlist\hmm0\spnew3

findstr /V "VECSIZE"  E:\matlabhtk\hmmlist\hmm0\SR > E:\matlabhtk\hmmlist\hmm0\SRnew
findstr /V "STREAMINFO"  E:\matlabhtk\hmmlist\hmm0\SRnew > E:\matlabhtk\hmmlist\hmm0\SRnew2
findstr /V "~o"  E:\matlabhtk\hmmlist\hmm0\SRnew > E:\matlabhtk\hmmlist\hmm0\SRnew3

findstr /V "VECSIZE"  E:\matlabhtk\hmmlist\hmm0\ssil > E:\matlabhtk\hmmlist\hmm0\ssilnew
findstr /V "STREAMINFO"  E:\matlabhtk\hmmlist\hmm0\ssilnew > E:\matlabhtk\hmmlist\hmm0\ssilnew2
findstr /V "~o"  E:\matlabhtk\hmmlist\hmm0\ssilnew > E:\matlabhtk\hmmlist\hmm0\ssilnew3

findstr /V "VECSIZE"  E:\matlabhtk\hmmlist\hmm0\TK > E:\matlabhtk\hmmlist\hmm0\TKnew
findstr /V "STREAMINFO"  E:\matlabhtk\hmmlist\hmm0\TKnew > E:\matlabhtk\hmmlist\hmm0\TKnew2
findstr /V "~o"  E:\matlabhtk\hmmlist\hmm0\TKnew > E:\matlabhtk\hmmlist\hmm0\TKnew3

copy  GA + GMnew3 + GNnew3 + HAUnew3 + HEnew3 + spnew3 + SRnew3 + ssilnew3 + TKnew3 hmmall

HParse word_grammar.txt wordnet

HCompV –S traindat -M hmmlist\hmm0 -H hmmlist\hmmproto\GN -f 0.01 GN

HERest -S traindat -H hmmlist\hmm0\hmmall –H hmmlist\hmm0\macros  -M hmmlist\hmm1 word_list

if not exist "E:\matlabhtk\hmmlist\hmm0" mkdir "E:\matlabhtk\hmmlist\hmm0"

echo MU 32 {*.state[2-7].mix} > E:\matlabhtk\GMMlist\GMM32

HERest -S traindat -H hmmlist\hmm0\hmmall -H hmmlist\hmm0\macros  -M hmmlist\hmm1 word_list
HHEd -H hmmlist\hmm1\hmmall -H hmmlist\hmm1\macros -M hmmlist\hmm2 GMMlist\GMM2 word_list
HERest -S traindat -H hmmlist\hmm2\hmmall -H hmmlist\hmm2\macros  -M hmmlist\hmm3 word_list
pause

HVite -H hmmlist\hmm3\macros -H hmmlist\hmm3\hmmall -S testdat -w wordnet -i result.mlf word_dict word_list
HResults -f -e "???" ssil -e "???" sp word_list result.mlf >> final

copy /y htkdata traindatahtk\traindatahtk11

HERest -S traindat -H hmmlist\hmm0\hmmall -H hmmlist\hmm0\macros  -M hmmlist\hmm1 word_list
HHEd -H hmmlist\hmm1\hmmall -H hmmlist\hmm1\macros -M hmmlist\hmm2 GMMlist\GMM2 word_list

HERest -S traindat -H hmmlist\hmm2\hmmall -H hmmlist\hmm2\macros  -M hmmlist\hmm3 word_list
HHEd -H hmmlist\hmm3\hmmall -H hmmlist\hmm3\macros -M hmmlist\hmm4 GMMlist\GMM3 word_list

HERest -S traindat -H hmmlist\hmm4\hmmall -H hmmlist\hmm4\macros  -M hmmlist\hmm5 word_list
HHEd -H hmmlist\hmm5\hmmall -H hmmlist\hmm5\macros -M hmmlist\hmm6 GMMlist\GMM4 word_list

HERest -S traindat -H hmmlist\hmm6\hmmall -H hmmlist\hmm6\macros  -M hmmlist\hmm7 word_list
HHEd -H hmmlist\hmm7\hmmall -H hmmlist\hmm7\macros -M hmmlist\hmm8 GMMlist\GMM5 word_list

HERest -S traindat -H hmmlist\hmm8\hmmall -H hmmlist\hmm8\macros  -M hmmlist\hmm9 word_list
HHEd -H hmmlist\hmm9\hmmall -H hmmlist\hmm9\macros -M hmmlist\hmm10 GMMlist\GMM6 word_list

HERest -S traindat -H hmmlist\hmm10\hmmall -H hmmlist\hmm10\macros  -M hmmlist\hmm11 word_list
HHEd -H hmmlist\hmm11\hmmall -H hmmlist\hmm11\macros -M hmmlist\hmm12 GMMlist\GMM7 word_list

HERest -S traindat -H hmmlist\hmm12\hmmall -H hmmlist\hmm12\macros  -M hmmlist\hmm13 word_list
HHEd -H hmmlist\hmm13\hmmall -H hmmlist\hmm13\macros -M hmmlist\hmm14 GMMlist\GMM8 word_list

HERest -S traindat -H hmmlist\hmm14\hmmall -H hmmlist\hmm14\macros  -M hmmlist\hmm15 word_list
HHEd -H hmmlist\hmm15\hmmall -H hmmlist\hmm15\macros -M hmmlist\hmm16 GMMlist\GMM9 word_list

HERest -S traindat -H hmmlist\hmm16\hmmall -H hmmlist\hmm16\macros  -M hmmlist\hmm17 word_list
HHEd -H hmmlist\hmm17\hmmall -H hmmlist\hmm17\macros -M hmmlist\hmm18 GMMlist\GMM10 word_list

HERest -S traindat -H hmmlist\hmm18\hmmall -H hmmlist\hmm18\macros  -M hmmlist\hmm19 word_list
HHEd -H hmmlist\hmm19\hmmall -H hmmlist\hmm19\macros -M hmmlist\hmm20 GMMlist\GMM11 word_list

HERest -S traindat -H hmmlist\hmm20\hmmall -H hmmlist\hmm20\macros  -M hmmlist\hmm21 word_list
HHEd -H hmmlist\hmm21\hmmall -H hmmlist\hmm21\macros -M hmmlist\hmm22 GMMlist\GMM12 word_list

HERest -S traindat -H hmmlist\hmm22\hmmall -H hmmlist\hmm22\macros  -M hmmlist\hmm23 word_list
HHEd -H hmmlist\hmm23\hmmall -H hmmlist\hmm23\macros -M hmmlist\hmm24 GMMlist\GMM13 word_list

HERest -S traindat -H hmmlist\hmm24\hmmall -H hmmlist\hmm24\macros  -M hmmlist\hmm25 word_list
HHEd -H hmmlist\hmm25\hmmall -H hmmlist\hmm25\macros -M hmmlist\hmm26 GMMlist\GMM14 word_list

HERest -S traindat -H hmmlist\hmm26\hmmall -H hmmlist\hmm26\macros  -M hmmlist\hmm27 word_list
HHEd -H hmmlist\hmm27\hmmall -H hmmlist\hmm27\macros -M hmmlist\hmm28 GMMlist\GMM15 word_list

HERest -S traindat -H hmmlist\hmm28\hmmall -H hmmlist\hmm28\macros  -M hmmlist\hmm29 word_list
HHEd -H hmmlist\hmm29\hmmall -H hmmlist\hmm29\macros -M hmmlist\hmm30 GMMlist\GMM16 word_list

HERest -S traindat -H hmmlist\hmm30\hmmall -H hmmlist\hmm30\macros  -M hmmlist\hmm31 word_list
HHEd -H hmmlist\hmm31\hmmall -H hmmlist\hmm31\macros -M hmmlist\hmm32 GMMlist\GMM17 word_list

HERest -S traindat -H hmmlist\hmm32\hmmall -H hmmlist\hmm32\macros  -M hmmlist\hmm33 word_list
HHEd -H hmmlist\hmm33\hmmall -H hmmlist\hmm33\macros -M hmmlist\hmm34 GMMlist\GMM18 word_list

HERest -S traindat -H hmmlist\hmm34\hmmall -H hmmlist\hmm34\macros  -M hmmlist\hmm35 word_list
HHEd -H hmmlist\hmm35\hmmall -H hmmlist\hmm35\macros -M hmmlist\hmm36 GMMlist\GMM19 word_list

HERest -S traindat -H hmmlist\hmm36\hmmall -H hmmlist\hmm36\macros  -M hmmlist\hmm37 word_list
HHEd -H hmmlist\hmm37\hmmall -H hmmlist\hmm37\macros -M hmmlist\hmm38 GMMlist\GMM20 word_list

HERest -S traindat -H hmmlist\hmm38\hmmall -H hmmlist\hmm38\macros  -M hmmlist\hmm39 word_list
HHEd -H hmmlist\hmm39\hmmall -H hmmlist\hmm39\macros -M hmmlist\hmm40 GMMlist\GMM21 word_list

HERest -S traindat -H hmmlist\hmm40\hmmall -H hmmlist\hmm40\macros  -M hmmlist\hmm41 word_list
HHEd -H hmmlist\hmm41\hmmall -H hmmlist\hmm41\macros -M hmmlist\hmm42 GMMlist\GMM22 word_list

HERest -S traindat -H hmmlist\hmm42\hmmall -H hmmlist\hmm42\macros  -M hmmlist\hmm43 word_list
HHEd -H hmmlist\hmm43\hmmall -H hmmlist\hmm43\macros -M hmmlist\hmm44 GMMlist\GMM23 word_list

HERest -S traindat -H hmmlist\hmm44\hmmall -H hmmlist\hmm44\macros  -M hmmlist\hmm45 word_list
HHEd -H hmmlist\hmm45\hmmall -H hmmlist\hmm45\macros -M hmmlist\hmm46 GMMlist\GMM24 word_list

HERest -S traindat -H hmmlist\hmm46\hmmall -H hmmlist\hmm46\macros  -M hmmlist\hmm47 word_list