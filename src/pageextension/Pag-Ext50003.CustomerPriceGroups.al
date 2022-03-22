pageextension 50003 "PWD CustomerPriceGroups" extends "Customer Price Groups"
{
    layout
    {
        modify("Price Includes VAT")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            Visible = false;
        }
    }
}
