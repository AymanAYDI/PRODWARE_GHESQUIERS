page 50074 "PWD Seafrance Sales Order"
{
    Caption = 'Web Sales Order';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "PWD Seafrance Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Initial order No."; Rec."Initial order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat();
                    end;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    Caption = 'Sell-to Post Code/City';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Reference; Rec.Reference)
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(SalesLines; "Seatfrance Sales Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Facturation)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidat();
                    end;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    Caption = 'Bill-to Post Code/City';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid();
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Livraison)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Country Code"; Rec."Ship-to Country Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Late Order Shipping"; Rec."Late Order Shipping")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(International)
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        IF ChangeExchangeRate.RUNMODAL() = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());
                            CurrPage.UPDATE();
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Area"; Rec.Area)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Commande Seafrance")
            {
                Caption = 'Seafrance Order';
                field("Controlled Order"; Rec."Controlled Order")
                {
                    ApplicationArea = All;
                }
                field("Call Type"; Rec."Call Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        CstL008: Label 'You must give information to the field Portray Stopover.';
                    begin
                        //>>FED_ADV_20090827_IMP_CDEVENTE_V2 :SOBI 19/10/2009
                        IF Rec."Controlled Order" THEN
                            IF (xRec."Call Type" <> '') AND (Rec."Call Type" = '') THEN
                                ERROR(CstL008);
                        //<<FED_ADV_20090827_IMP_CDEVENTE_V2 :SOBI 19/10/2009
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Fonction&s")
            {
                Caption = 'F&unctions';
                action("Contrôler la commande")
                {
                    Caption = 'Contrôler la commande';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Fct_ControlLine(Rec);
                    end;
                }
                separator(Action1000000006)
                {
                }
                action("Intégrer la commande")
                {
                    Caption = 'Intégrer la commande';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        CstL005: Label 'Do you want to insert Seafrance order ° %1 ?';
                    begin
                        IF CONFIRM(CstL005, FALSE, Rec."No.") THEN BEGIN
                            Fct_OrderVérif(Rec);
                            Fct_CreateHeader(Rec);
                        END;
                    end;
                }
                separator(Action1000000007)
                {
                }
                action("Imprimer la commande")
                {
                    Caption = 'Imprimer la commande';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        RecLSeafranceSalesHeader: Record "PWD Seafrance Sales Header";
                    begin
                        //>>FED_ADV_20090827_IMP_CDEVENTE_V2 :SOBI 19/10/2009
                        RecLSeafranceSalesHeader.SETRANGE(RecLSeafranceSalesHeader."No.", Rec."No.");
                        REPORT.RUNMODAL(50120, TRUE, FALSE, RecLSeafranceSalesHeader);
                        //<<FED_ADV_20090827_IMP_CDEVENTE_V2 :SOBI 19/10/2009
                    end;
                }
            }
        }
    }
    var
        RecGSalesSetup: Record "Sales & Receivables Setup";
        RecGSalesHeader: Record "Sales Header";
        ChangeExchangeRate: Page "Change Exchange Rate";

    procedure Fct_ControlLine(var P_SeafranceSalesHeader: Record "PWD Seafrance Sales Header")
    var
        RecLItem: Record Item;
        RecLSeafranceSalesLine: Record "PWD Seafrance Sales Line";
        BoolCreateItem: Boolean;
        CstL001: Label 'The article %1 of the line %2 of order %3 does not exist in the foundation Navision. Please create it to you?';
        CstL002: Label 'Cancelled treatment. It is necessary you to change code article of the line %1 of order %2 and to throw the check on lines once again.';
        CstL003: Label 'Check on ended order.';
        CstL004: Label 'No Item Line to prove.';
    begin
        P_SeafranceSalesHeader.TESTFIELD(P_SeafranceSalesHeader."Call Type");
        RecLSeafranceSalesLine.RESET();
        RecLSeafranceSalesLine.SETRANGE(RecLSeafranceSalesLine."Document Type", P_SeafranceSalesHeader."Document Type");
        RecLSeafranceSalesLine.SETRANGE(RecLSeafranceSalesLine."Document No.", P_SeafranceSalesHeader."No.");
        RecLSeafranceSalesLine.SETRANGE(RecLSeafranceSalesLine."Type", RecLSeafranceSalesLine."Type"::Item);
        IF RecLSeafranceSalesLine.FIND('-') THEN BEGIN
            REPEAT
                BoolCreateItem := FALSE;
                IF NOT RecLItem.GET(RecLSeafranceSalesLine."No.") THEN
                    IF CONFIRM(CstL001, FALSE, RecLSeafranceSalesLine."No.",
                                            RecLSeafranceSalesLine."Line No.",
                                            RecLSeafranceSalesLine."Document No.") THEN BEGIN
                        Fct_CreateItem(RecLSeafranceSalesLine);
                        BoolCreateItem := TRUE;
                    END ELSE
                        ERROR(CstL002, RecLSeafranceSalesLine."Line No.", RecLSeafranceSalesLine."Document No.");
                IF BoolCreateItem THEN BEGIN
                    RecLSeafranceSalesLine."New Item" := TRUE;
                    RecLSeafranceSalesLine.MODIFY();
                END;
            UNTIL RecLSeafranceSalesLine.NEXT() = 0;
            P_SeafranceSalesHeader."Controlled Order" := TRUE;
            P_SeafranceSalesHeader.MODIFY();
            MESSAGE(CstL003);
        END ELSE
            MESSAGE(CstL004);
    end;

    procedure Fct_CreateItem(P_SeafranceSalesLine: Record "PWD Seafrance Sales Line")
    var
        RecLItem: Record Item;
    begin
        RecLItem.INIT();
        RecLItem."No." := P_SeafranceSalesLine."No.";
        RecLItem.Description := P_SeafranceSalesLine."SF Description";
        RecLItem.Blocked := TRUE;
        RecLItem.INSERT();
    end;

    procedure Fct_CreateHeader(var P_SeafranceSalesHeader: Record "PWD Seafrance Sales Header")
    var
        CuLCustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        CstL006: Label 'Seafrance %1 order was created order %2 under N °.';
    begin
        IF RecGSalesHeader.RECORDLEVELLOCKING = TRUE THEN
            RecGSalesHeader.LOCKTABLE();

        RecGSalesSetup.GET();

        RecGSalesSetup.TESTFIELD(RecGSalesSetup."Order Nos.");

        P_SeafranceSalesHeader.TESTFIELD(P_SeafranceSalesHeader."Document Type", P_SeafranceSalesHeader."Document Type"::Order);

        RecGSalesHeader.INIT();
        RecGSalesHeader.VALIDATE("Document Type", P_SeafranceSalesHeader."Document Type");
        RecGSalesHeader.VALIDATE("Posting Date", P_SeafranceSalesHeader."Posting Date");
        RecGSalesHeader.VALIDATE("Sell-to Customer No.", P_SeafranceSalesHeader."Sell-to Customer No.");
        COMMIT();
        IF GUIALLOWED THEN
            CuLCustCheckCreditLimit.SalesHeaderCheck(RecGSalesHeader);
        RecGSalesHeader.VALIDATE(RecGSalesHeader."Requested Delivery Date", P_SeafranceSalesHeader."Requested Delivery Date");
        IF P_SeafranceSalesHeader."Initial order No." <> '' THEN
            RecGSalesHeader."PWD Seafrance Order No." := P_SeafranceSalesHeader."No." + '-' + P_SeafranceSalesHeader."Initial order No."
        ELSE
            RecGSalesHeader."PWD Seafrance Order No." := P_SeafranceSalesHeader."No.";
        RecGSalesHeader.INSERT(TRUE);
        RecGSalesHeader.VALIDATE("Order Date", P_SeafranceSalesHeader."Order Date");
        RecGSalesHeader.VALIDATE("Document Date", P_SeafranceSalesHeader."Document Date");
        RecGSalesHeader.VALIDATE(RecGSalesHeader."PWD Reference", P_SeafranceSalesHeader.Reference);
        RecGSalesHeader.VALIDATE(RecGSalesHeader."PWD Call Type", P_SeafranceSalesHeader."Call Type");
        RecGSalesHeader.MODIFY(TRUE);
        Fct_CreateLine(P_SeafranceSalesHeader, RecGSalesHeader);
        MESSAGE(CstL006, P_SeafranceSalesHeader."No.", RecGSalesHeader."No.");
    end;

    Procedure Fct_CreateLine(var P_SeafranceSalesHeaderForLine: Record "PWD Seafrance Sales Header"; var P_SalesHeaderCreate: Record "Sales Header")
    var
        RecLocPriority: Record "PWD Location Priority";
        RecLSeafranceSalesLine: Record "PWD Seafrance Sales Line";
        RecLSalesLine: Record "Sales Line";
        CuLItemCheckAvail: Codeunit "Item-Check Avail.";
        CstL007: Label 'No line to be validated.';
    begin
        RecLSeafranceSalesLine.RESET();
        RecLSeafranceSalesLine.SETRANGE("Document Type", P_SeafranceSalesHeaderForLine."Document Type");
        RecLSeafranceSalesLine.SETRANGE("Document No.", P_SeafranceSalesHeaderForLine."No.");
        IF RecLSeafranceSalesLine.FIND('-') THEN BEGIN
            REPEAT
                RecLSalesLine.INIT();
                IF RecLSalesLine.RECORDLEVELLOCKING THEN
                    RecLSalesLine.LOCKTABLE();
                RecLSalesLine.VALIDATE(RecLSalesLine."Document Type", P_SeafranceSalesHeaderForLine."Document Type");
                RecLSalesLine.VALIDATE(RecLSalesLine."Document No.", P_SalesHeaderCreate."No.");
                RecLSalesLine.VALIDATE("Line No.", RecLSeafranceSalesLine."Line No.");
                RecLSalesLine.VALIDATE("Sell-to Customer No.", P_SeafranceSalesHeaderForLine."Sell-to Customer No.");
                RecLSalesLine.VALIDATE(Type, RecLSeafranceSalesLine.Type);
                RecLSalesLine."PWD Call Type" := RecLSeafranceSalesLine."Call Type";
                RecLocPriority.RESET();
                RecLocPriority.SETCURRENTKEY(RecLocPriority."PWD Call Type Code", RecLocPriority."PWD Location priority");
                RecLocPriority.SETRANGE(RecLocPriority."PWD Call Type Code", RecLSalesLine."PWD Call Type");
                IF RecLocPriority.FIND('+') THEN
                    RecLSalesLine."Location Code" := RecLocPriority."PWD Location code";
                IF RecLSalesLine.Type <> RecLSalesLine.Type::" " THEN BEGIN
                    RecLSalesLine.VALIDATE("No.", RecLSeafranceSalesLine."No.");
                    RecLSalesLine.VALIDATE(Quantity, RecLSeafranceSalesLine.Quantity);
                END ELSE
                    RecLSalesLine.VALIDATE(Description, RecLSeafranceSalesLine.Description);
                COMMIT();
                IF GUIALLOWED THEN
                    CuLItemCheckAvail.SalesLineCheck(RecLSalesLine);
                RecLSalesLine."PWD New Item" := RecLSeafranceSalesLine."New Item";
                RecLSalesLine."PWD Seafrance Order Line No." := RecLSeafranceSalesLine."Seafrance Order Line No.";
                RecLSalesLine.INSERT(TRUE);
                IF RecLSalesLine.Reserve = RecLSalesLine.Reserve::Always THEN BEGIN
                    RecLSalesLine.AutoReserve();
                    RecLSalesLine.MODIFY(TRUE);
                END;
                RecLSeafranceSalesLine.DELETE();
            UNTIL RecLSeafranceSalesLine.NEXT() = 0;
            P_SeafranceSalesHeaderForLine.DELETE();
        END ELSE
            ERROR(CstL007);
    end;

    procedure "Fct_OrderVérif"(P_SeafranceSalesHeader: Record "PWD Seafrance Sales Header")
    var
        RecLCustomer: Record Customer;
        RecLItem: Record Item;
        RecLSeafranceSalesLine: Record "PWD Seafrance Sales Line";
    begin
        P_SeafranceSalesHeader.TESTFIELD(P_SeafranceSalesHeader."Controlled Order", TRUE);
        P_SeafranceSalesHeader.TESTFIELD(P_SeafranceSalesHeader."Call Type");
        RecLCustomer.GET(P_SeafranceSalesHeader."Sell-to Customer No.");
        RecLSeafranceSalesLine.RESET();
        RecLSeafranceSalesLine.SETRANGE(RecLSeafranceSalesLine."Document Type", P_SeafranceSalesHeader."Document Type");
        RecLSeafranceSalesLine.SETRANGE(RecLSeafranceSalesLine."Document No.", P_SeafranceSalesHeader."No.");
        RecLSeafranceSalesLine.SETRANGE(RecLSeafranceSalesLine.Type, RecLSeafranceSalesLine.Type::Item);
        IF RecLSeafranceSalesLine.FIND('-') THEN
            REPEAT
                IF RecLSeafranceSalesLine."No." <> '' THEN BEGIN
                    RecLItem.GET(RecLSeafranceSalesLine."No.");
                    RecLItem.TESTFIELD(RecLItem.Blocked, FALSE);
                    RecLItem.TESTFIELD(RecLItem."Inventory Posting Group");
                    RecLItem.TESTFIELD(RecLItem."Gen. Prod. Posting Group");
                    RecLItem.TESTFIELD(RecLItem."VAT Prod. Posting Group");
                END;
            UNTIL RecLSeafranceSalesLine.NEXT() = 0;
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE();
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE();
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE();
    end;
}

