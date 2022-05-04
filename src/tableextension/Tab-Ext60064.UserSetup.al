tableextension 60064 "PWD UserSetup" extends "User Setup"
{
    fields
    {
        field(50000; "PWD Signing"; Blob)
        {
            Caption = 'Signing';
            DataClassification = CustomerContent;
            SubType = Bitmap;
        }
    }
}
