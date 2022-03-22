tableextension 60040 "PWD PaymentMethod" extends "Payment Method"
{
    fields
    {

        field(50000; "PWD International Description"; Text[50])
        {
            Caption = 'International Description';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
}

