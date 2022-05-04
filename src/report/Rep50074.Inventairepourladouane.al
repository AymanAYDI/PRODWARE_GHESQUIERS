report 50074 "PWD Inventaire pour la douane"
{
    // ------------------------------------------------------------------------------------------------------------------------------------
    // www.prodware.fr
    // ------------------------------------------------------------------------------------------------------------------------------------
    // 
    // //>> MODIF HL
    // TI105367 DO.GEPO 01/06/2012 : MODIf Design and add field description 2 in section
    // 
    // ------------------------------------------------------------------------------------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = './rdl/Inventairepourladouane.rdl';


    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Location Filter", "PWD Family", "PWD Sub Family";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(Item_Item__Qty__on_Sales_Order_; Item."Qty. on Sales Order")
            {
            }
            column(Item_Inventory; Inventory)
            {
                DecimalPlaces = 3 : 3;
            }
            column(Item_Description; Description)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(LocationFilter; LocationFilter)
            {
            }
            column(Item__Description_2_; "Description 2")
            {
            }
            column(Etat_des_stocks_DouaneCaption; Etat_des_stocks_DouaneCaptionLbl)
            {
            }
            column(LocationFilterCaption; LocationFilterCaptionLbl)
            {
            }
            column(Item__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Item_InventoryCaption; Item_InventoryCaptionLbl)
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(Item_Item__Qty__on_Sales_Order_Caption; Item_Item__Qty__on_Sales_Order_CaptionLbl)
            {
            }
            column(PhysiqueCaption; PhysiqueCaptionLbl)
            {
            }
            column(Diff_Caption; Diff_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS(Inventory);
                CALCFIELDS("Qty. on Sales Order");
                IF ((Inventory = 0) AND ("Qty. on Sales Order" = 0)) THEN CurrReport.SKIP();
            end;

            trigger OnPreDataItem()
            begin
                LocationFilter := GETFILTER("Location Filter");
            end;
        }
    }

    var
        Diff_CaptionLbl: Label 'Diff.';
        Etat_des_stocks_DouaneCaptionLbl: Label 'Etat des stocks Douane';
        Item_DescriptionCaptionLbl: Label 'Libellé article';
        Item_InventoryCaptionLbl: Label 'Inventory';
        Item_Item__Qty__on_Sales_Order_CaptionLbl: Label 'Réservé';
        LocationFilterCaptionLbl: Label 'Code magasin';
        PhysiqueCaptionLbl: Label 'Physique';
        LocationFilter: Text[30];
}

