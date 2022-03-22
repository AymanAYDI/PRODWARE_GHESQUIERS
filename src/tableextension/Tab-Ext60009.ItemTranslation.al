tableextension 60009 "PWD ItemTranslation" extends "Item Translation"
{
    procedure ChangeItemTranslation()
    var
        Item: Record Item;
        InventorySetup: Record "Inventory Setup";
    begin
        InventorySetup.GET();
        IF InventorySetup."PWD Default Translation Language" = "Language Code" THEN
            IF Item.GET("Item No.") THEN BEGIN
                Item."PWD Translation" := Description;
                Item.MODIFY();
            END;
    end;
}

