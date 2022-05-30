tableextension 60017 "PWD CompanyInformation" extends "Company Information"
{
    fields
    {
        field(50000; "PWD Out Agrement No."; Code[20])
        {
            Caption = 'Out Agrement No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Representative"; Text[50])
        {
            Caption = 'Representative';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50002; "PWD In Agrement No."; Code[20])
        {
            Caption = 'In Agrement No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50003; "PWD Logo AVITA facture"; BLOB)
        {
            Caption = 'Logo AVITA facture';
            Description = 'PW2009';
            SubType = Bitmap;
            DataClassification = CustomerContent;
        }
        field(50004; "PWD Logo ISSA"; BLOB)
        {
            Caption = 'Logo ISSA';
            Description = 'PW2009';
            SubType = Bitmap;
            DataClassification = CustomerContent;
        }
        field(50005; "PWD Location Rights Acquit Filter"; Text[100])
        {
            Caption = 'Location Rights Acquit Filter';
            Description = 'NDBI';
            DataClassification = CustomerContent;
        }
        field(50006; "PWD Loc. Rights Suspended Filter"; Text[100])
        {
            Caption = 'Location Rights Suspended Filter';
            Description = 'NDBI';
            DataClassification = CustomerContent;
        }
        field(50007; "PWD Indebted Identification"; Text[30])
        {
            Caption = 'Indebted Identification';
            Description = 'NDBI';
            DataClassification = CustomerContent;
        }
    }
}
