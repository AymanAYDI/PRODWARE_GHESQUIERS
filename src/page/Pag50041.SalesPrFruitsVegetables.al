page 50041 "Sales Pr Fruits & Vegetables"
{
    Caption = 'Sales Prices Fruits & Vegetables';
    DataCaptionExpression = GetCaption();
    DelayedInsert = true;
    PageType = Card;
    SaveValues = true;
    SourceTable = "Price List Line";
    SourceTableView = WHERE("PWD Family" = CONST('50'));
    ApplicationArea = all;
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field(SalesTypeFilter; SalesTypeFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Sales Type Filter';
                    Editable = true;
                    OptionCaption = 'Customer,Customer Price Group,All Customers,None';

                    trigger OnValidate()
                    begin
                        SalesTypeFilterOnAfterValidate();
                    end;
                }
                field(SalesCodeFilterCtrl; SalesCodeFilter)
                {
                    Caption = 'Sales Code Filter';
                    Editable = true;
                    Enabled = SalesCodeFilterCtrlEnable;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CustList: Page "Customer List";
                        CustPriceGrList: Page "Customer Price Groups";
                    begin
                        IF SalesTypeFilter = SalesTypeFilter::"All Customers" THEN EXIT;

                        CASE SalesTypeFilter OF
                            SalesTypeFilter::Customer:
                                BEGIN
                                    CustList.LOOKUPMODE := TRUE;
                                    IF CustList.RUNMODAL() = ACTION::LookupOK THEN
                                        Text := CustList.GetSelectionFilter()
                                    ELSE
                                        EXIT(FALSE);
                                END;
                            SalesTypeFilter::"Customer Price Group":
                                BEGIN

                                    CustPriceGrList.LOOKUPMODE := TRUE;
                                    IF CustPriceGrList.RUNMODAL() = ACTION::LookupOK THEN
                                        Text := CustPriceGrList.GetSelectionFilter()
                                    ELSE
                                        EXIT(FALSE);
                                END;
                        END;

                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        SalesCodeFilterOnAfterValidate();
                    end;
                }
                field(ItemNoFilterCtrl; ItemNoFilter)
                {
                    Caption = 'Item No. Filter';
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemList: Page "Item List";
                    begin
                        ItemList.LOOKUPMODE := TRUE;
                        IF ItemList.RUNMODAL() = ACTION::LookupOK THEN
                            Text := ItemList.GetSelectionFilter()
                        ELSE
                            EXIT(FALSE);

                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        ItemNoFilterOnAfterValidate();
                    end;
                }
                field(StartingDateFilter; StartingDateFilter)
                {
                    Caption = 'Starting Date Filter';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        StartingDateFilterOnAfterValid();
                    end;
                }
            }
            repeater(Control1)
            {
                ShowCaption = false;

                field("Source Type"; Rec."Source Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                //TODO
                /*field("Sales Code"; "Sales Code")
                {
                    Editable = "Sales CodeEditable";
                    Visible = false;
                    ApplicationArea = All;
                }*/
                field("Asset No."; Rec."Asset No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Minimum Quantity"; Rec."Minimum Quantity")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Purch. Cost"; Rec."PWD Purch. Cost")
                {
                    ApplicationArea = All;
                }
                field("Percentage Profit"; Rec."PWD Percentage Profit")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                }
                field("Price Includes VAT"; Rec."Price Includes VAT")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Gr. (Price)"; Rec."VAT Bus. Posting Gr. (Price)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Options)
            {
                Caption = 'Options';
                field(CurrencyCodeFilterCtrl; CurrencyCodeFilter)
                {
                    Caption = 'Currency Code Filter';
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CurrencyList: Page Currencies;
                    begin
                        CurrencyList.LOOKUPMODE := TRUE;
                        IF CurrencyList.RUNMODAL() = ACTION::LookupOK THEN
                            Text := CurrencyList.GetSelectionFilter()
                        ELSE
                            EXIT(FALSE);

                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeFilterOnAfterValid();
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Imprimer")
            {
                Caption = '&Imprimer';
                action("Tarif de la semaine")
                {
                    Caption = 'Tarif de la semaine';
                    Image = Price;
                    //TODO
                    //RunObject = Report "Liste prix fruits et légumes";
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Fct_OnAfterGetCurrRecord();
    end;

    trigger OnInit()
    begin
        SalesCodeFilterCtrlEnable := TRUE;
        "Sales CodeEditable" := TRUE;
        SalesTypeFilter := SalesTypeFilter::"All Customers";
        SalesCodeFilter := '';
        ItemNoFilter := '';
        StartingDateFilter := '';
        CurrencyCodeFilter := '';
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Source Type" := xRec."Source Type";
        Fct_OnAfterGetCurrRecord();
    end;

    trigger OnOpenPage()
    begin
        SalesTypeFilter := SalesTypeFilter::None;
        SalesCodeFilter := '';
        ItemNoFilter := '';
        StartingDateFilter := '';
        CurrencyCodeFilter := '';
    end;

    var
        Cust: Record Customer;
        CustPriceGr: Record "Customer Price Group";
        [InDataSet]
        "Sales CodeEditable": Boolean;
        [InDataSet]
        SalesCodeFilterCtrlEnable: Boolean;
        Text000: Label 'All Customers';
        SalesTypeFilter: Option Customer,"Customer Price Group","All Customers","None";
        StartingDateFilter: Text[30];
        CurrencyCodeFilter: Text[250];
        ItemNoFilter: Text[250];
        SalesCodeFilter: Text[250];

    procedure GetRecFilters()
    begin
        IF Rec.GETFILTERS <> '' THEN
            //TODO Verif
            IF Rec.GETFILTER("Source Type") <> '' THEN
                SalesTypeFilter := SalesTypeFilter
            ELSE
                SalesTypeFilter := SalesTypeFilter::None;
        //TODO
        //SalesCodeFilter := Rec.GETFILTER("Sales Code");
        ItemNoFilter := Rec.GETFILTER("Asset No.");
        CurrencyCodeFilter := Rec.GETFILTER("Currency Code");

        EVALUATE(StartingDateFilter, Rec.GETFILTER("Starting Date"));
    end;

    procedure SetRecFilters()
    begin

        SalesCodeFilterCtrlEnable := TRUE;
        //TODO VERIF
        IF SalesTypeFilter <> SalesTypeFilter::None THEN
            Rec.SETRANGE("Source Type", SalesTypeFilter)
        ELSE
            Rec.SETRANGE("Source Type");
        IF SalesTypeFilter IN [SalesTypeFilter::"All Customers", SalesTypeFilter::None] THEN BEGIN
            SalesCodeFilterCtrlEnable := FALSE;
            SalesCodeFilter := '';
        END;
        //TODO verif 
        IF SalesCodeFilter <> '' THEN
            Rec.SETFILTER("Source Type", SalesCodeFilter)
        ELSE
            Rec.SETRANGE("Source Type");
        IF StartingDateFilter <> '' THEN
            Rec.SETFILTER("Starting Date", StartingDateFilter)
        ELSE
            Rec.SETRANGE("Starting Date");

        IF ItemNoFilter <> '' THEN
            Rec.SETFILTER("Asset No.", ItemNoFilter)
        ELSE
            Rec.SETRANGE("Asset No.");

        IF CurrencyCodeFilter <> '' THEN
            Rec.SETFILTER("Currency Code", CurrencyCodeFilter)
        ELSE
            Rec.SETRANGE("Currency Code");
        CurrPage.UPDATE(TRUE);
    end;

    procedure GetCaption(): Text[250]
    var
        ObjTransl: Record "Object Translation";
        SalesSrcTableName: Text[100];
        SourceTableName: Text[100];
        DescriptionValue: Text[250];
    begin
        GetRecFilters();
        //TODO Verif
        IF Rec."Source Type" = Rec."Source Type"::"All Customers" THEN
            "Sales CodeEditable" := FALSE
        ELSE
            "Sales CodeEditable" := TRUE;
        SourceTableName := '';
        IF ItemNoFilter <> '' THEN
            SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 27);

        SalesSrcTableName := '';
        CASE SalesTypeFilter OF
            SalesTypeFilter::Customer:
                BEGIN
                    SalesSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 18);
                    Cust."No." := SalesCodeFilter;
                    IF Cust.FIND() THEN
                        DescriptionValue := Cust.Name;
                END;
            SalesTypeFilter::"Customer Price Group":

                BEGIN

                    SalesSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 6);
                    CustPriceGr.Code := SalesCodeFilter;
                    IF CustPriceGr.FIND() THEN
                        DescriptionValue := CustPriceGr.Description;
                END;
            SalesTypeFilter::"All Customers":
                BEGIN
                    SalesSrcTableName := Text000;
                    DescriptionValue := '';
                END;
        END;

        IF SalesSrcTableName = Text000 THEN
            EXIT(STRSUBSTNO('%1 %2 %3', SalesSrcTableName, SourceTableName, ItemNoFilter));

        EXIT(STRSUBSTNO('%1 %2 %3 %4 %5', SalesSrcTableName, SalesCodeFilter, DescriptionValue, SourceTableName, ItemNoFilter));
    end;

    local procedure SalesCodeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD();
        SetRecFilters();
    end;

    local procedure SalesTypeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD();
        SalesCodeFilter := '';
        SetRecFilters();
    end;

    local procedure StartingDateFilterOnAfterValid()
    begin
        CurrPage.SAVERECORD();
        SetRecFilters();
    end;

    local procedure ItemNoFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD();
        SetRecFilters();
    end;

    local procedure CurrencyCodeFilterOnAfterValid()
    begin
        CurrPage.SAVERECORD();
        SetRecFilters();
    end;

    local procedure Fct_OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        IF Rec."Source Type" = Rec."Source Type"::"All Customers" THEN
            "Sales CodeEditable" := FALSE
        ELSE
            "Sales CodeEditable" := TRUE;
    end;
}
