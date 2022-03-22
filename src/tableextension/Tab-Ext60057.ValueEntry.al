tableextension 60057 "PWD ValueEntry" extends "Value Entry"
{
    fields
    {
        field(50010; "PWD Code prestation"; Code[10])
        {
            Caption = 'Code prestation';
            Description = 'PW2009';
            TableRelation = "PWD Prestations";
            DataClassification = CustomerContent;
        }
        field(50011; "PWD Code fournisseur"; Code[20])
        {
            Caption = 'Code fournisseur';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50012; "PWD Code client"; Code[20])
        {
            Caption = 'Code client';
            Description = 'PW2009';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(50013; "PWD Family Code"; Code[20])
        {
            Caption = 'Family Code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
}

