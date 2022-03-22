tableextension 60033 "PWD PurchCrMemoLine" extends "Purch. Cr. Memo Line"
{
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
}

