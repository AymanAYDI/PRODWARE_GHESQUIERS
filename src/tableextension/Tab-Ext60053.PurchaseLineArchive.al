tableextension 60053 "PWD PurchaseLineArchive" extends "Purchase Line Archive"
{
    fields
    {
        field(55050; "PWD Cle (restitution)"; Code[20])
        {
            Caption = 'Restitution Key';
            Description = 'PW2009';
            TableRelation = "PWD Item Restitution".Cle;
            DataClassification = CustomerContent;
        }
        field(70060; "PWD Last Version"; Boolean)
        {
            Caption = 'Last Version';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
}
