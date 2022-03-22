tableextension 60029 "PWD PurchRcptLine" extends "Purch. Rcpt. Line"
{
    DrillDownPageID = "Posted Purchase Receipt Lines";
    fields
    {
        field(50001; "PWD Parcel Nb."; Decimal)
        {
            Caption = 'Parcel Nb.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Unit per Parcel"; Decimal)
        {
            Caption = 'Unit per Parcel';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50003; "PWD Origin"; Code[10])
        {
            Caption = 'Origin';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50004; "PWD Cetificate Transit No."; Code[50])
        {
            Caption = 'Cetificate Transit No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50005; "PWD Family"; Code[10])
        {
            Caption = 'Family';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50006; "PWD No. avis de placement"; Code[20])
        {
            Caption = 'N° avis de placement';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50014; "PWD COM7 No."; Code[20])
        {
            Caption = 'COM7 No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55000; "PWD Sales Type Doc Appeal tenders"; Enum "PWD Sales TypeDocAppealtenders")
        {
            Caption = 'Sales Type Doc Appeal tenders';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55001; "PWD Sales No. Appeal Tenders"; Code[20])
        {
            Caption = 'Sales No. Appeal Tenders';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55002; "PWD Sales Line No. Appeal Tenders"; Integer)
        {
            Caption = 'Sales Line No. Appeal Tenders';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55045; "PWD Quantite initiale"; Decimal)
        {
            Caption = 'Quantité initiale';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55050; "PWD Cle (restitution)"; Code[20])
        {
            Caption = 'Restitution Key';
            Description = 'PW2009';
            TableRelation = "PWD Item Restitution".Cle;
            DataClassification = CustomerContent;
        }
        field(55051; "PWD Designation FR"; Text[50])
        {
            Caption = 'Désignation FR';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
    keys
    {

        key(Key50000; "PWD Sales Type Doc Appeal tenders", "PWD Sales No. Appeal Tenders", "PWD Sales Line No. Appeal Tenders")
        {
            //SumIndexFields = Quantity;
        }
        key(Key50001; "Special Order Sales No.", "Special Order Sales Line No.")
        {
            //SumIndexFields = Quantity,"PWD Parcel Nb.";
        }
        key(Key50002; "Document No.", Type, "No.")
        {
        }
    }
}

