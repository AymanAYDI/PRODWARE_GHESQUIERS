tableextension 60054 "PWD StockkeepingUnit" extends "Stockkeeping Unit"
{
    fields
    {
        modify("Shelf No.")
        {
            TableRelation = "PWD Custom Parameters".Code WHERE("Table ID" = CONST(27), "Field ID" = CONST(12));
        }
    }
}
