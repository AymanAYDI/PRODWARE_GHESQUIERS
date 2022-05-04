codeunit 50010 "PWD ConvertAscii"
{

    trigger OnRun()
    begin
    end;

    var
        trouve: Boolean;
        Correspondances: array[83, 2] of Char;
        i: Integer;
        pos: Integer;


    procedure AsciiToAnsi(var TextAscii: Text[250]) TextAnsi: Text[250]
    begin
        InitTableauCorrespondances();
        TextAnsi := TextAscii;
        FOR pos := 1 TO STRLEN(TextAscii) DO
            IF (TextAnsi[pos] > 127) THEN BEGIN                      //cars différent après 127 (8e bit)
                i := 0;
                trouve := FALSE;
                WHILE ((trouve = FALSE) AND (i < 83)) DO BEGIN       //tableau de 83 éléments
                    i += 1;
                    IF (Correspondances[i] [1] = TextAnsi[pos]) THEN BEGIN
                        trouve := TRUE;
                        TextAnsi[pos] := Correspondances[i] [2];
                    END;
                END;
            END;
    end;


    procedure AnsiToAscii(var TextAnsi: Text[250]) TextAscii: Text[250]
    begin
        InitTableauCorrespondances();
        TextAscii := TextAnsi;
        FOR pos := 1 TO STRLEN(TextAscii) DO
            IF (TextAscii[pos] > 127) THEN BEGIN                     //cars diffèrent après 127 (8e bit)
                i := 0;
                trouve := FALSE;
                WHILE ((trouve = FALSE) AND (i < 83)) DO BEGIN       //tableau de 83 éléments
                    i += 1;
                    IF (Correspondances[i] [2] = TextAscii[pos]) THEN BEGIN
                        trouve := TRUE;
                        TextAscii[pos] := Correspondances[i] [1];
                    END;
                END;
            END;
    end;


    procedure InitTableauCorrespondances()
    begin
        /*Ç*/
        Correspondances[1] [1] := 128;
        Correspondances[1] [2] := 199;
        /*ü*/
        Correspondances[2] [1] := 129;
        Correspondances[2] [2] := 252;
        /*é*/
        Correspondances[3] [1] := 130;
        Correspondances[3] [2] := 233;
        /*â*/
        Correspondances[4] [1] := 131;
        Correspondances[4] [2] := 226;
        /*ä*/
        Correspondances[5] [1] := 132;
        Correspondances[5] [2] := 228;
        /*à*/
        Correspondances[6] [1] := 133;
        Correspondances[6] [2] := 224;
        /*å*/
        Correspondances[7] [1] := 134;
        Correspondances[7] [2] := 229;
        /*ç*/
        Correspondances[8] [1] := 135;
        Correspondances[8] [2] := 231;
        /*ê*/
        Correspondances[9] [1] := 136;
        Correspondances[9] [2] := 234;
        /*ë*/
        Correspondances[10] [1] := 137;
        Correspondances[10] [2] := 235;
        /*è*/
        Correspondances[11] [1] := 138;
        Correspondances[11] [2] := 232;
        /*ï*/
        Correspondances[12] [1] := 139;
        Correspondances[12] [2] := 239;
        /*î*/
        Correspondances[13] [1] := 140;
        Correspondances[13] [2] := 238;
        /*ì*/
        Correspondances[14] [1] := 141;
        Correspondances[14] [2] := 236;
        /*Ä*/
        Correspondances[15] [1] := 142;
        Correspondances[15] [2] := 196;
        /*Å*/
        Correspondances[16] [1] := 143;
        Correspondances[16] [2] := 197;
        /*É*/
        Correspondances[17] [1] := 144;
        Correspondances[17] [2] := 201;
        /*æ*/
        Correspondances[18] [1] := 145;
        Correspondances[18] [2] := 230;
        /*Æ*/
        Correspondances[19] [1] := 146;
        Correspondances[19] [2] := 198;
        /*ô*/
        Correspondances[20] [1] := 147;
        Correspondances[20] [2] := 244;
        /*ö*/
        Correspondances[21] [1] := 148;
        Correspondances[21] [2] := 246;
        /*ò*/
        Correspondances[22] [1] := 149;
        Correspondances[22] [2] := 242;
        /*û*/
        Correspondances[23] [1] := 150;
        Correspondances[23] [2] := 251;
        /*ù*/
        Correspondances[24] [1] := 151;
        Correspondances[24] [2] := 249;
        /*Ö*/
        Correspondances[25] [1] := 153;
        Correspondances[25] [2] := 214;
        /*Ü*/
        Correspondances[26] [1] := 154;
        Correspondances[26] [2] := 220;
        /*£*/
        Correspondances[27] [1] := 156;
        Correspondances[27] [2] := 163;
        /*á*/
        Correspondances[28] [1] := 160;
        Correspondances[28] [2] := 225;
        /*í*/
        Correspondances[29] [1] := 161;
        Correspondances[29] [2] := 237;
        /*ó*/
        Correspondances[30] [1] := 162;
        Correspondances[30] [2] := 243;
        /*ú*/
        Correspondances[31] [1] := 163;
        Correspondances[31] [2] := 250;
        /*ñ*/
        Correspondances[32] [1] := 164;
        Correspondances[32] [2] := 241;
        /*Ñ*/
        Correspondances[33] [1] := 165;
        Correspondances[33] [2] := 209;
        /*¿*/
        Correspondances[34] [1] := 168;
        Correspondances[34] [2] := 191;
        /*®*/
        Correspondances[35] [1] := 169;
        Correspondances[35] [2] := 174;
        /*½*/
        Correspondances[36] [1] := 171;
        Correspondances[36] [2] := 189;
        /*¼*/
        Correspondances[37] [1] := 172;
        Correspondances[37] [2] := 188;
        /*¡*/
        Correspondances[38] [1] := 173;
        Correspondances[38] [2] := 161;
        /*«*/
        Correspondances[39] [1] := 174;
        Correspondances[39] [2] := 171;
        /*»*/
        Correspondances[40] [1] := 175;
        Correspondances[40] [2] := 187;
        /*Á*/
        Correspondances[41] [1] := 181;
        Correspondances[41] [2] := 193;
        /*Â*/
        Correspondances[42] [1] := 182;
        Correspondances[42] [2] := 194;
        /*À*/
        Correspondances[43] [1] := 183;
        Correspondances[43] [2] := 192;
        /*©*/
        Correspondances[44] [1] := 184;
        Correspondances[44] [2] := 169;
        /*¢*/
        Correspondances[45] [1] := 189;
        Correspondances[45] [2] := 162;
        /*¥*/
        Correspondances[46] [1] := 190;
        Correspondances[46] [2] := 165;
        /*ã*/
        Correspondances[47] [1] := 198;
        Correspondances[47] [2] := 227;
        /*Ã*/
        Correspondances[48] [1] := 199;
        Correspondances[48] [2] := 195;
        /*¤*/
        Correspondances[49] [1] := 207;
        Correspondances[49] [2] := 164;
        /*ð*/
        Correspondances[50] [1] := 208;
        Correspondances[50] [2] := 240;
        /*Ð*/
        Correspondances[51] [1] := 209;
        Correspondances[51] [2] := 208;
        /*Ê*/
        Correspondances[52] [1] := 210;
        Correspondances[52] [2] := 202;
        /*Ë*/
        Correspondances[53] [1] := 211;
        Correspondances[53] [2] := 203;
        /*È*/
        Correspondances[54] [1] := 212;
        Correspondances[54] [2] := 200;
        /*Í*/
        Correspondances[55] [1] := 214;
        Correspondances[55] [2] := 205;
        /*Î*/
        Correspondances[56] [1] := 215;
        Correspondances[56] [2] := 206;
        /*Ï*/
        Correspondances[57] [1] := 216;
        Correspondances[57] [2] := 207;
        /*Ì*/
        Correspondances[58] [1] := 222;
        Correspondances[58] [2] := 204;
        /*Ó*/
        Correspondances[59] [1] := 224;
        Correspondances[59] [2] := 211;
        /*ß*/
        Correspondances[60] [1] := 225;
        Correspondances[60] [2] := 223;
        /*Ô*/
        Correspondances[61] [1] := 226;
        Correspondances[61] [2] := 212;
        /*Ò*/
        Correspondances[62] [1] := 227;
        Correspondances[62] [2] := 210;
        /*õ*/
        Correspondances[63] [1] := 228;
        Correspondances[63] [2] := 245;
        /*Õ*/
        Correspondances[64] [1] := 229;
        Correspondances[64] [2] := 213;
        /*µ*/
        Correspondances[65] [1] := 230;
        Correspondances[65] [2] := 181;
        /*þ*/
        Correspondances[66] [1] := 231;
        Correspondances[66] [2] := 222;
        /*Þ*/
        Correspondances[67] [1] := 232;
        Correspondances[67] [2] := 254;
        /*Ú*/
        Correspondances[68] [1] := 233;
        Correspondances[68] [2] := 218;
        /*Û*/
        Correspondances[69] [1] := 234;
        Correspondances[69] [2] := 219;
        /*Ù*/
        Correspondances[70] [1] := 235;
        Correspondances[70] [2] := 217;
        /*ý*/
        Correspondances[71] [1] := 236;
        Correspondances[71] [2] := 253;
        /*Ý*/
        Correspondances[72] [1] := 237;
        Correspondances[72] [2] := 221;
        /*´*/
        Correspondances[73] [1] := 239;
        Correspondances[73] [2] := 180;
        /*±*/
        Correspondances[74] [1] := 241;
        Correspondances[74] [2] := 177;
        /*¾*/
        Correspondances[75] [1] := 243;
        Correspondances[75] [2] := 190;
        /*¶*/
        Correspondances[76] [1] := 244;
        Correspondances[76] [2] := 182;
        /*§*/
        Correspondances[77] [1] := 245;
        Correspondances[77] [2] := 167;
        /*°*/
        Correspondances[78] [1] := 248;
        Correspondances[78] [2] := 176;
        /*¨*/
        Correspondances[79] [1] := 249;
        Correspondances[79] [2] := 168;
        /*·*/
        Correspondances[80] [1] := 250;
        Correspondances[80] [2] := 183;
        /*¹*/
        Correspondances[81] [1] := 251;
        Correspondances[81] [2] := 185;
        /*³*/
        Correspondances[82] [1] := 252;
        Correspondances[82] [2] := 179;
        /*²*/
        Correspondances[83] [1] := 253;
        Correspondances[83] [2] := 178;

    end;
}

