tableextension 60046 "PWD ReservationEntry" extends "Reservation Entry"
{
    fields
    {
        field(50000; "PWD Country Origin"; Code[10])
        {
            Caption = 'Country Origin';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Certificate Transit No."; Code[30])
        {
            Caption = 'Certificate Transit No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Stocking Advice No."; Code[20])
        {
            Caption = 'Stocking Advice No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50003; "PWD Lot No. Origin"; Code[20])
        {
            Caption = 'Lot No. Origin';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
    keys
    {

        key(Key50000; "Source ID", "Source Batch Name", "Source Ref. No.")
        {
        }
        key(Key50001; "Item No.", "Source Type", "Source Subtype", "Lot No.")
        {
            SumIndexFields = "Quantity (Base)";
        }
    }
    //Unsupported feature: Code Modification on "SetPointer(PROCEDURE 2)".

    //procedure SetPointer();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemTrackingMgt.DecomposeRowID(RowID,StrArray);
    Evaluate("Source Type",StrArray[1]);
    Evaluate("Source Subtype",StrArray[2]);
    "Source ID" := StrArray[3];
    "Source Batch Name" := StrArray[4];
    Evaluate("Source Prod. Order Line",StrArray[5]);
    Evaluate("Source Ref. No.",StrArray[6]);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //>>MIGRATION2009R2
    ItemTrackingMgt.DecomposeRowID(RowID,StrArray);
    EVALUATE("Source Type",StrArray[1]);
    EVALUATE("Source Subtype",StrArray[2]);
    "Source ID" := StrArray[3];
    "Source Batch Name" := StrArray[4];
    EVALUATE("Source Prod. Order Line",StrArray[5]);
    EVALUATE("Source Ref. No.",StrArray[6]);
    OriginArea:="Country Origin"; //MIGRATION2009R2 : Add specific code
    //<<MIGRATION2009R2
    */
    //end;   
}

