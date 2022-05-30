tableextension 60021 "PWD GeneralLedgerSetup" extends "General Ledger Setup"
{
    fields
    {
        field(55000; "PWD Direction Role ID"; Code[20])
        {
            Caption = 'Direction Role ID';
            Description = 'PW2009';
            TableRelation = "Permission Set";
            DataClassification = CustomerContent;
        }
        field(55001; "PWD Magasin DEB 1"; Code[20])
        {
            Caption = 'Magasin DEB 1';
            Description = 'PW2009';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(55002; "PWD Magasin DEB 2"; Code[20])
        {
            Caption = 'Magasin DEB 2';
            Description = 'PW2009';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
    }
}
