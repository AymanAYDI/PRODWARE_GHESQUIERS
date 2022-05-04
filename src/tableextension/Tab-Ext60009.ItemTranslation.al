tableextension 60009 "PWD ItemTranslation" extends "Item Translation"
{
    procedure ChangeItemTranslation()
    var
        InventorySetup: Record "Inventory Setup";
        Item: Record Item;
    begin
        InventorySetup.GET();
        IF InventorySetup."PWD Default Translation Language" = "Language Code" THEN
            IF Item.GET("Item No.") THEN BEGIN
                Item."PWD Translation" := Description;
                Item.MODIFY();
            END;
    end;
}

