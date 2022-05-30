table 50041 "PWD mouchar"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; order; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(3; "time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(4; user; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "order", date, time)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
