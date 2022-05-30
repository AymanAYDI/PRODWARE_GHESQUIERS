table 50033 "Items Available per Location"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF Item.GET("Item No.") THEN
                    "Item Description" := Item.Description;
            end;
        }
        field(2; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF Location.GET("Location Code") THEN
                    "Location Name" := Location.Name;
            end;
        }
        field(3; "Available Inventory"; Decimal)
        {
            Caption = 'Available Inventory';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                LocationPriority.SETRANGE(LocationPriority."PWD Location code", "Location Code");
                IF LocationPriority.FIND('-') THEN
                    REPEAT
                        IF CallType <> LocationPriority."PWD Call Type Code" THEN
                            IF NOT ItemAvailableperCallType.GET(LocationPriority."PWD Call Type Code", LocationPriority."PWD Location code", "Item No.") THEN BEGIN
                                ItemAvailableperCallType.INIT();
                                ItemAvailableperCallType.VALIDATE("Call Type", LocationPriority."PWD Call Type Code");
                                ItemAvailableperCallType.VALIDATE("Location Code", "Location Code");
                                ItemAvailableperCallType.VALIDATE("Item No.", "Item No.");
                                ItemAvailableperCallType.VALIDATE("Available Inventory", "Available Inventory");
                                ItemAvailableperCallType.INSERT();
                            END ELSE BEGIN
                                ItemAvailableperCallType.VALIDATE("Available Inventory", "Available Inventory");
                                ItemAvailableperCallType.MODIFY();
                            END;
                        CallType := LocationPriority."PWD Call Type Code";
                    UNTIL LocationPriority.NEXT() = 0;

                IF RecCallType.FIND('-') THEN
                    REPEAT
                        ItemAvailableperCallType.RESET();
                        LocationPriority.RESET();
                        LocationPriority.SETRANGE(LocationPriority."PWD Call Type Code", RecCallType.Code);
                        IF LocationPriority.FIND('-') THEN
                            REPEAT
                                IF NOT ItemAvailableperCallType.GET(RecCallType.Code, LocationPriority."PWD Location code", "Item No.") THEN BEGIN
                                    ItemAvailableperCallType.INIT();
                                    ItemAvailableperCallType.VALIDATE("Call Type", RecCallType.Code);
                                    ItemAvailableperCallType.VALIDATE("Location Code", LocationPriority."PWD Location code");
                                    ItemAvailableperCallType.VALIDATE("Item No.", "Item No.");
                                    ItemAvailableperCallType.INSERT();
                                END;
                            UNTIL LocationPriority.NEXT() = 0;
                    UNTIL RecCallType.NEXT() = 0;
            end;
        }
        field(8; "Item Description"; Text[30])
        {
            Caption = 'Item Description';
            DataClassification = CustomerContent;
        }
        field(9; "Location Name"; Text[30])
        {
            Caption = 'Location Name';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item No.", "Location Code")
        {
            Clustered = true;
            SumIndexFields = "Available Inventory";
        }
    }

    var
        Item: Record Item;
        ItemAvailableperCallType: Record "Items Available per Call Type";
        Location: Record Location;
        RecCallType: Record "PWD Call Type";
        LocationPriority: Record "PWD Location Priority";
        CallType: Code[20];
}
