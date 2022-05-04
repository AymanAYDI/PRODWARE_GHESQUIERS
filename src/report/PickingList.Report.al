/*report 50042 "PWD Picking List"
{
      DefaultLayout = RDLC;
    RDLCLayout = './PickingList.rdlc';

    Caption = 'Picking List';

    dataset
    {
        dataitem(DataItem6640; Table36)
        {
            DataItemTableView = SORTING (Document Type, "No.") WHERE (Document Type=CONST(Order));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            dataitem(DataItem2844; Table37)
            {
                DataItemLink = Document Type=FIELD(Document Type),Document No.=FIELD(No.);
                DataItemTableView = SORTING(Document Type,Document No.,Location Code,Shelf/Bin No.,Family Code,No.) ORDER(Ascending) WHERE(Type=FILTER(<>' '&<>Resource),Trading Brand=CONST(No),Special Order=CONST(No),Location Code=FILTER(<>''));
                RequestFilterFields = "Location Code","Family Code";
                column(USERID;USERID)
                {
                }
                column(ShipToAddr_1_;ShipToAddr[1])
                {
                }
                column(FORMAT_TODAY_0_4_;FORMAT(TODAY,0,4))
                {
                }
                column(CurrReport_PAGENO;CurrReport.PAGENO)
                {
                }
                column(call__Board_Location_;call."Board Location")
                {
                }
                column(Recarea_Text;Recarea.Text)
                {
                }
                column(Sales_Line__Requested_Delivery_Date_;"Requested Delivery Date")
                {
                }
                column(STRSUBSTNO_Text000__Sales_Header___No____Sales_Header___Order_Date__;STRSUBSTNO(Text000,"Sales Header"."No.","Sales Header"."Order Date"))
                {
                }
                column(Sales_Header__Reference;"Sales Header".Reference)
                {
                }
                column(TIME;TIME)
                {
                }
                column(Sales_Header___Sell_to_Contact_; "Sales Header"."Sell-to Contact")
                {
                }
                column(Sales_Line__Location_Code_;"Location Code")
                {
                }
                column(Sales_Line__Family_Code_;"Family Code")
                {
                }
                column(Sales_Line__Location_Code__Control1000000008;"Location Code")
                {
                }
                column(Sales_Line__Location_Code__Control1000000036;"Location Code")
                {
                }
                column(Sales_Line__Family_Code__Control1000000041;"Family Code")
                {
                }
                column(Sales_Line__Location_Code__Control1000000019;"Location Code")
                {
                }
                column(Sales_Line__Family_Code__Control1000000059;"Family Code")
                {
                }
                column(Sales_Line__No__;"No.")
                {
                }
                column(Sales_Line_Description;Description)
                {
                }
                column(Sales_Line_Quantity;Quantity)
                {
                }
                column(Sales_Line__Unit_of_Measure_Code_;"Unit of Measure Code")
                {
                }
                column(Item__SEAF_E_price_;Item."SEAF E price")
                {
                }
                column(SKU__Shelf_No__;SKU."Shelf No.")
                {
                }
                column(CallType2_Pas_de_saut_de_page_sur_BP_;CallType2."Pas de saut de page sur BP")
                {
                }
                column(Sales_Header_No;STRSUBSTNO(Text000,"Sales Header"."No.","Sales Header"."Order Date"))
                {
                }
                column(Lot_No_;RecGReservEntry."Lot No.")
                {
                }
                column(ABS_Quantity;ABS(Quantity))
                {
                    DecimalPlaces = 0:5;
                }
                column(Reservation_Entry_Expiration_Date;RecGReservEntry."Expiration Date")
                {
                }
                column(CallType2_Ne_pas_imprimer_DLC_sur_BP;CallType2."Ne pas imprimer DLC sur BP")
                {
                }
                column(Line_No;"Line No.")
                {
                }
                column(SalesLine_ShelfBinNo;"Sales Line"."Shelf/Bin No.")
                {
                }
                column(CallType2_TriSurCodeSEAF;CallType2."Tri sur code SEAF")
                {
                }
                column(TxtShelfBinNoGroup;TxtShelfBinNoGroup)
                {
                }
                column(Description_2_______Designation_ENU_;"Description 2"+' '+"Designation ENU")
                {
                }
                column(RefFournisseur;RefFournisseur)
                {
                }
                column(Call_Type;"Sales Header"."Call Type")
                {
                }
                column(Sales_Line__COUNT;"Sales Line".COUNT)
                {
                }
                column(IntGNewPage;IntGNewPage)
                {
                }
                column(PICKING_LISTCaption;PICKING_LISTCaptionLbl)
                {
                }
                column("Livré_à__Caption";Livré_à__CaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Requested_Delivery_DateCaption;Requested_Delivery_DateCaptionLbl)
                {
                }
                column(Commande_N_Caption;Commande_N_CaptionLbl)
                {
                }
                column("Edité_le_Caption";Edité_le_CaptionLbl)
                {
                }
                column("àCaption";àCaptionLbl)
                {
                }
                column(parCaption;parCaptionLbl)
                {
                }
                column(SKU__Shelf_No__Caption;SKU__Shelf_No__CaptionLbl)
                {
                }
                column(Sales_Line__No__Caption;FIELDCAPTION("No."))
                {
                }
                column(Sales_Line_DescriptionCaption;FIELDCAPTION(Description))
                {
                }
                column("QuantitéCaption";QuantitéCaptionLbl)
                {
                }
                column("Quantité_préparéeCaption";Quantité_préparéeCaptionLbl)
                {
                }
                column("UnitéCaption";UnitéCaptionLbl)
                {
                }
                column(Sales_Line__Location_Code_Caption;FIELDCAPTION("Location Code"))
                {
                }
                column(Sales_Line__Family_Code_Caption;FIELDCAPTION("Family Code"))
                {
                }
                column(Sales_Line__Location_Code__Control1000000008Caption;FIELDCAPTION("Location Code"))
                {
                }
                column(Sales_Line__Location_Code__Control1000000036Caption;FIELDCAPTION("Location Code"))
                {
                }
                column(Sales_Line__Family_Code__Control1000000041Caption;FIELDCAPTION("Family Code"))
                {
                }
                column(Sales_Line__Location_Code__Control1000000019Caption;FIELDCAPTION("Location Code"))
                {
                }
                column(Code_familleCaption;Code_familleCaptionLbl)
                {
                }
                column(Lot_No_Caption;Lot_No_CaptionLbl)
                {
                }
                column(DLC_Caption;DLC_CaptionLbl)
                {
                }
                column(FIN_DE_BP___________Caption;FIN_DE_BP___________CaptionLbl)
                {
                }
                column(Sales_Line_Document_Type;"Document Type")
                {
                }
                column(Sales_Line_Document_No_;"Document No.")
                {
                }
                column(Sales_Line_Previous_Line_No;"Previous Line No")
                {
                }
                dataitem(DataItem4003;Table337)
                {
                    DataItemLink = Item No.=FIELD(No.),Location Code=FIELD(Location Code),Source Subtype=FIELD(Document Type),Source ID=FIELD(Document No.),Source Ref. No.=FIELD(Line No.);
                    DataItemTableView = SORTING(Entry No.,Positive) WHERE(Source Type=FILTER(37));
                    column(Reservation_Entry__Expiration_Date_;"Expiration Date")
                    {
                    }
                    column(ABS_Quantity_;ABS(Quantity))
                    {
                        DecimalPlaces = 0:5;
                    }
                    column(Reservation_Entry__Lot_No__;"Lot No.")
                    {
                    }
                    column(BooShowDLC;BooShowDLC)
                    {
                    }
                    column(DLCCaption;DLCCaptionLbl)
                    {
                    }
                    column(Reservation_Entry__Lot_No__Caption;FIELDCAPTION("Lot No."))
                    {
                    }
                    column(Reservation_Entry_Entry_No_;"Entry No.")
                    {
                    }
                    column(Reservation_Entry_Positive;Positive)
                    {
                    }
                    column(Reservation_Entry_Item_No_;"Item No.")
                    {
                    }
                    column(Reservation_Entry_Location_Code;"Location Code")
                    {
                    }
                    column(Reservation_Entry_Source_Subtype;"Source Subtype")
                    {
                    }
                    column(Reservation_Entry_Source_ID;"Source ID")
                    {
                    }
                    column(Reservation_Entry_Source_Ref__No_;"Source Ref. No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //>>GHE-RE1.00
                        BooShowDLC:=TRUE;
                        IF CallType.GET("Sales Header"."Call Type") THEN
                         BEGIN
                          IF CallType."Ne pas imprimer DLC sur BP"=TRUE THEN
                           BooShowDLC:=FALSE;
                         END;
                        //<<GHE-RE1.00
                    end;
                }
                dataitem(InfoTrading;Table2000000026)
                {
                    DataItemTableView = SORTING(Number) WHERE(Number=CONST(1));
                    column(Item__Conserving_Temperature_;Item."Conserving Temperature")
                    {
                        DecimalPlaces = 0:2;
                    }
                    column(Item__Transport_Temperature_;Item."Transport Temperature")
                    {
                        DecimalPlaces = 0:2;
                    }
                    column("N__d_agréement__Caption";N__d_agréement__CaptionLbl)
                    {
                    }
                    column(Marquage__Caption;Marquage__CaptionLbl)
                    {
                    }
                    column(EmptyStringCaption;EmptyStringCaptionLbl)
                    {
                    }
                    column(EmptyStringCaption_Control1000000062;EmptyStringCaption_Control1000000062Lbl)
                    {
                    }
                    column(Date_Fabrication__Caption;Date_Fabrication__CaptionLbl)
                    {
                    }
                    column(EmptyStringCaption_Control1000000064;EmptyStringCaption_Control1000000064Lbl)
                    {
                    }
                    column(DLC__Caption;DLC__CaptionLbl)
                    {
                    }
                    column(EmptyStringCaption_Control1000000066;EmptyStringCaption_Control1000000066Lbl)
                    {
                    }
                    column("Abattoir_ou_atelier_de_découpe__Caption";Abattoir_ou_atelier_de_découpe__CaptionLbl)
                    {
                    }
                    column(EmptyStringCaption_Control1000000068;EmptyStringCaption_Control1000000068Lbl)
                    {
                    }
                    column(T__conservation__Caption;T__conservation__CaptionLbl)
                    {
                    }
                    column(T__transport__Caption;T__transport__CaptionLbl)
                    {
                    }
                    column(InfoTrading_Number;Number)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF "Sales Header"."Call Type" <> 'TRADING' THEN CurrReport.SKIP;
                        IF NOT Item.GET ("Sales Line"."No.") THEN Item.INIT;
                    end;
                }
                dataitem(CommentSalesLine;Table37)
                {
                    DataItemLink = Linked Sales Line=FIELD(Previous Line No),Document Type=FIELD(Document Type),Document No.=FIELD(Document No.);
                    DataItemTableView = SORTING(Shelf/Bin No.,Location Code) ORDER(Ascending) WHERE(Type=FILTER(' '));
                    column(CommentSalesLine_Description;Description)
                    {
                    }
                    column(CommentSalesLine_Document_Type;"Document Type")
                    {
                    }
                    column(CommentSalesLine_Document_No_;"Document No.")
                    {
                    }
                    column(CommentSalesLine_Line_No_;"Line No.")
                    {
                    }
                    column(CommentSalesLine_Linked_Sales_Line;"Linked Sales Line")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //>>MIGRATION2009R2
                    //BEGIN 01/02/2006   C2A(LLE) cf commande CDVS004032
                    IF "Sales Line"."Location Code" <> CodeMagasinMem THEN BEGIN
                          IF CallType.GET("Sales Header"."Call Type") THEN
                          BEGIN
                           IF CallType."Pas de saut de page sur BP"=FALSE THEN
                            BEGIN
                              CurrReport.NEWPAGE;
                              //>>GHE-RE1.00
                              IntGNewPage:=IntGNewPage+1;
                              //>>GHE-RE1.00
                            END;
                          END ELSE
                            BEGIN
                              CurrReport.NEWPAGE;
                              //>>GHE-RE1.00
                              IntGNewPage:=IntGNewPage+1;
                              //>>GHE-RE1.00
                            END;
                          CodeMagasinMem:="Sales Line"."Location Code";
                    END;
                    //END 01/02/2006   C2A(LLE)
                    // ** Trouver le code emplacement
                    IF NOT SKU.GET ("Sales Line"."Location Code","Sales Line"."No.","Sales Line"."Variant Code") THEN
                      SKU.INIT;
                    //On fait une rupture par emplacement de la fiche article mais on fait apparaître l'emplacement du bon de stock
                    IF Type = Type :: Item THEN BEGIN
                      IF Item.GET("Sales Line"."No.") THEN BEGIN
                        IF (BinCode <>Item."Shelf No.") AND (LocationCode = "Sales Line"."Location Code") THEN BEGIN
                          //Pour éviter une rupture à vide à cause du changement de magasin

                    //BEGIN 01/02/2006   C2A(LLE) cf commande CDVS004032


                          IF CallType.GET("Sales Header"."Call Type") THEN   // Code Added AMI   cf commande CDVS004032
                          BEGIN                                         // Code Added AMI
                           IF CallType."Pas de saut de page sur BP"=FALSE THEN  // Code Added AMI
                           BEGIN
                            CurrReport.NEWPAGE;                          // Code Added AMI
                            //>>GHE-RE1.00
                            IntGNewPage:=IntGNewPage+1;
                            //>>GHE-RE1.00
                           END;
                          END ELSE                                              // Code Added AMI / LLE
                          BEGIN
                           CurrReport.NEWPAGE;
                            //>>GHE-RE1.00
                            IntGNewPage:=IntGNewPage+1;
                            //>>GHE-RE1.00
                          END;
                         // CurrReport.NEWPAGE;                         // Code Commented AMI
                    //END 01/02/2006   C2A(LLE)

                          ShowLocationHeader:=TRUE;
                        END ELSE
                          ShowLocationHeader:=FALSE;
                        BinCode :=Item."Shelf No.";
                        RefFournisseur :=Item."Vendor Item No.";
                      END;
                    END;
                    //LocationCode := "Sales Line"."Location Code";



                    //MIGRATION23009R2--BEGIN
                    RecGReservEntry.RESET;
                    RecGReservEntry.SETRANGE("Item No.","No.");
                    IF NOT RecGReservEntry.FINDSET THEN
                     RecGReservEntry."Lot No." := '';
                    //MIGRATION23009R2--END
                    //<<MIGRATION2009R2

                    //>>GHE-RE1.00
                    IF ISSERVICETIER THEN
                      LocationCode := "Sales Line"."Location Code";

                    IF Rec_CallType.GET("Sales Header"."Call Type") THEN
                      IF NOT Rec_CallType."Tri sur code SEAF" THEN
                        TxtShelfBinNoGroup:="Sales Line"."Shelf/Bin No."
                      ELSE
                        TxtShelfBinNoGroup:='*';


                    //>>GHE-RE1.00
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FIELDNO("Bin Code");
                    //BEGIN 31/01/2006   C2A(LLE) cf commande CDVS004032
                    IF "Sales Line".FIND('-') THEN CodeMagasinMem:="Sales Line"."Location Code";
                    //END 31/01/2006   C2A(LLE)

                    //C2A JRA 31/05/07 CF 16374 Start
                    IF Rec_CallType.GET("Sales Header"."Call Type") THEN
                      IF Rec_CallType."Tri sur code SEAF" THEN
                    //BEGIN   04/07/07   C2A(LLE)   cf appel NAV0016773
                    //    "Sales Line".SETCURRENTKEY("Sales Line"."SEAF Code");
                      "Sales Line".SETCURRENTKEY("Document Type","Document No.","Location Code","Shelf/Bin No.","SEAF Code")
                      //>>GHE-RE1.00
                      ELSE
                        "Sales Line".SETCURRENTKEY("Document Type","Document No.","Location Code","Shelf/Bin No.","Family Code","No.");
                      //<<GHE-RE1.00

                    //END   04/07/07   C2A(LLE)   cf appel NAV0016773
                    //C2A JRA 31/05/07 CF 16374 END
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //>>MIGRATION2009R2
                CompanyInfo.GET;
                FormatAddr.Company(CompanyAddr,CompanyInfo);
                FormatAddr.SalesHeaderShipTo(ShipToAddr,"Sales Header");
                IF NOT call.GET("Sales Header"."Call No.") THEN call.INIT;
                IF NOT Recarea.GET(call.Area) THEN Recarea.INIT;
                //MIGRATION2009R2-BEGIN
                IF NOT CallType2.GET("Sales Header"."Call Type") THEN BEGIN
                  CallType2."Pas de saut de page sur BP":=FALSE;
                  CallType2."Ne pas imprimer DLC sur BP":=FALSE;
                END;

                //MIGRATION2009R2-END
                //<<MIGRATION2009R2
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        ShipToAddr: array [8] of Text[50];
        CompanyAddr: array [8] of Text[50];
        FormatAddr: Codeunit "365";
        CompanyInfo: Record "79";
        Text000: Label '%1 du %2';
        Text001: Label 'DLC Article %1 : %2';
        TrackingExist: Boolean;
        ReservEntry: Record "337";
        call: Record "50001";
        Recarea: Record "284";
        Item: Record "27";
        BinCode: Code[20];
        SKU: Record "5700";
        LocationCode: Code[10];
        PageNumber: Integer;
        ShowLocationHeader: Boolean;
        RefFournisseur: Text[20];
        vCallType: Record "50007";
        CallType: Record "50007";
        CodeMagasinMem: Code[10];
        Rec_CallType: Record "50007";
        "-MIGRATION2009R2-": Integer;
        CallType2: Record "50007";
        RecGReservEntry: Record "337";
        IntGNewPage: Integer;
        BooShowDLC: Boolean;
        TxtShelfBinNoGroup: Text[30];
        PICKING_LISTCaptionLbl: Label 'PICKING LIST';
        "Livré_à__CaptionLbl": Label 'Livré à :';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Requested_Delivery_DateCaptionLbl: Label 'Requested Delivery Date';
        Commande_N_CaptionLbl: Label 'Commande N°';
        "Edité_le_CaptionLbl": Label 'Edité le ';
        "àCaptionLbl": Label 'à';
        parCaptionLbl: Label 'par';
        SKU__Shelf_No__CaptionLbl: Label 'Bin code';
        "QuantitéCaptionLbl": Label 'Quantité';
        "Quantité_préparéeCaptionLbl": Label 'Quantité préparée';
        "UnitéCaptionLbl": Label 'Unité';
        Code_familleCaptionLbl: Label 'Code famille';
        Lot_No_CaptionLbl: Label 'Label1000000076';
        DLC_CaptionLbl: Label 'DLC';
        FIN_DE_BP___________CaptionLbl: Label '********** FIN DE BP **********';
        DLCCaptionLbl: Label 'DLC';
        "N__d_agréement__CaptionLbl": Label 'N° d''agréement :';
        Marquage__CaptionLbl: Label 'Marquage :';
        EmptyStringCaptionLbl: Label '......................................';
        EmptyStringCaption_Control1000000062Lbl: Label '......................................';
        Date_Fabrication__CaptionLbl: Label 'Date Fabrication :';
        EmptyStringCaption_Control1000000064Lbl: Label '......................................';
        DLC__CaptionLbl: Label 'DLC :';
        EmptyStringCaption_Control1000000066Lbl: Label '......................................';
        "Abattoir_ou_atelier_de_découpe__CaptionLbl": Label 'Abattoir ou atelier de découpe :';
        EmptyStringCaption_Control1000000068Lbl: Label '..................................................................';
        T__conservation__CaptionLbl: Label 'T° conservation :';
        T__transport__CaptionLbl: Label 'T° transport :';
}

*/