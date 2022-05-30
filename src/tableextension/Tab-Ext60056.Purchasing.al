tableextension 60056 "PWD Purchasing" extends Purchasing
{
    fields
    {
        field(50000; "PWD Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Description = 'PW2009';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
    }
}
