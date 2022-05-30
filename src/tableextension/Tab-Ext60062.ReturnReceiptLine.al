tableextension 60062 "PWD ReturnReceiptLine" extends "Return Receipt Line"
{
    fields
    {
        field(55045; "PWD Quantite initiale"; Decimal)
        {
            Caption = 'Quantité initiale';
            Description = 'PW2009';
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
