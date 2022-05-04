report 50041 "PWD Fiche Anomalie"
{
    // 01.02.2006   C2A(LLE)   cf CDVS004032
    //                         Modif the last section footer from dataitem Sales Header to SalesLineAnomalie
    //                         and modif Sorting Key of dataitem SalesLineAnomalie
    DefaultLayout = RDLC;
    RDLCLayout = './rdl/FicheAnomalie.rdl';

    Caption = 'Missing items List';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
            RequestFilterFields = "No.";
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            dataitem(SalesLineAnomalie; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = SORTING("PWD Vendor No.", "PWD Shelf/Bin No.", "Location Code") WHERE(Type = FILTER(<> ' '), "PWD Trading Brand" = CONST(false), "Special Order" = CONST(false), "Location Code" = FILTER(''));
                column(ShipToAddr_1_; ShipToAddr[1])
                {
                }
                column(call__Board_Location_; call."Board Location")
                {
                }
                column(Recarea_Text; Recarea.Text)
                {
                }
                column(SalesLineAnomalie__Requested_Delivery_Date_; "Requested Delivery Date")
                {
                }
                column(STRSUBSTNO_Text000__Sales_Header___No____Sales_Header___Order_Date__; STRSUBSTNO(Text000, "Sales Header"."No.", "Sales Header"."Order Date"))
                {
                }
                column(USERID; USERID)
                {
                }
                column(CurrReport_PAGENO; CurrReport.PAGENO())
                {
                }
                column(TIME; TIME)
                {
                }
                column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                {
                }
                column(SalesLineAnomalie__Unit_of_Measure_Code_; "Unit of Measure Code")
                {
                }
                column(SalesLineAnomalie_Quantity; Quantity)
                {
                }
                column(SalesLineAnomalie_Description; Description)
                {
                }
                column(SalesLineAnomalie__No__; "No.")
                {
                }
                column(SalesLineAnomalie__Vendor_No__; "PWD Vendor No.")
                {
                }
                column(SalesLineAnomalie__Location_Code_; "Location Code")
                {
                }
                column(SalesLineAnomalie__Type_; Type)
                {
                }
                column(SalesLineAnomalie__Trading_Brand_; "PWD Trading Brand")
                {
                }
                column(SalesLineAnomalie__Special_Order_; "Special Order")
                {
                }
                column(PICKING_LISTCaption; PICKING_LISTCaptionLbl)
                {
                }
                column("Livré_à__Caption"; Livré_à__CaptionLbl)
                {
                }
                column(Requested_Delivery_DateCaption; Requested_Delivery_DateCaptionLbl)
                {
                }
                column(Commande_N_Caption; Commande_N_CaptionLbl)
                {
                }
                column(parCaption; parCaptionLbl)
                {
                }
                column("àCaption"; àCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column("Edité_le_Caption"; Edité_le_CaptionLbl)
                {
                }
                column(ANOMALIES___STOCK_INSUFFISANTCaption; ANOMALIES___STOCK_INSUFFISANTCaptionLbl)
                {
                }
                column(Nombre_de_colisCaption; Nombre_de_colisCaptionLbl)
                {
                }
                column("Quantité_préparéeCaption"; Quantité_préparéeCaptionLbl)
                {
                }
                column(SalesLineAnomalie__Unit_of_Measure_Code_Caption; FIELDCAPTION("Unit of Measure Code"))
                {
                }
                column("Quantité_commandéeCaption"; Quantité_commandéeCaptionLbl)
                {
                }
                column(SalesLineAnomalie_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(SalesLineAnomalie__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(VendorCaption; VendorCaptionLbl)
                {
                }
                column(FIN_DE_BP___________Caption; FIN_DE_BP___________CaptionLbl)
                {
                }
                column(SalesLineAnomalie_Document_Type; "Document Type")
                {
                }
                column(SalesLineAnomalie_Document_No_; "Document No.")
                {
                }
                column(SalesLineAnomalie_Line_No_; "Line No.")
                {
                }
                column(SalesLineAnomalie_Shelf_Bin_No_; "PWD Shelf/Bin No.")
                {
                }
                column(SalesLineAnomalie_Previous_Line_No; "PWD Previous Line No")
                {
                }
                dataitem(CommentSalesLineAnomalie; 37)
                {
                    DataItemLink = "PWD Linked Sales Line" = FIELD("PWD Previous Line No"), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No.");
                    DataItemTableView = SORTING("PWD Shelf/Bin No.", "Location Code") ORDER(Ascending) WHERE(Type = FILTER(' '));
                    column(CommentSalesLineAnomalie_Description; Description)
                    {
                    }
                    column(CommentSalesLineAnomalie_Document_Type; "Document Type")
                    {
                    }
                    column(CommentSalesLineAnomalie_Document_No_; "Document No.")
                    {
                    }
                    column(CommentSalesLineAnomalie_Line_No_; "Line No.")
                    {
                    }
                    column(CommentSalesLineAnomalie_Linked_Sales_Line; "PWD Linked Sales Line")
                    {
                    }
                }

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FIELDNO("Bin Code");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.GET();
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                //TODOFormatAddr.SalesHeaderShipTo(ShipToAddr, "Sales Header"); //Changement de param du fct
                IF NOT call.GET("Sales Header"."PWD Call No.") THEN call.INIT();
                IF NOT Recarea.GET(call.Area) THEN Recarea.INIT();
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
        Recarea: Record "Area";
        CompanyInfo: Record "Company Information";
        call: Record "PWD Call";
        FormatAddr: Codeunit "Format Address";
        LastFieldNo: Integer;
        "àCaptionLbl": Label 'à';
        ANOMALIES___STOCK_INSUFFISANTCaptionLbl: Label 'ANOMALIES - STOCK INSUFFISANT';
        Commande_N_CaptionLbl: Label 'Commande N°';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "Edité_le_CaptionLbl": Label 'Edité le ';
        FIN_DE_BP___________CaptionLbl: Label '********** FIN DE BP **********';
        "Livré_à__CaptionLbl": Label 'Livré à :';
        Nombre_de_colisCaptionLbl: Label 'Nombre de colis';
        parCaptionLbl: Label 'par';
        PICKING_LISTCaptionLbl: Label 'PICKING LIST';
        "Quantité_commandéeCaptionLbl": Label 'Quantité commandée';
        "Quantité_préparéeCaptionLbl": Label 'Quantité préparée';
        Requested_Delivery_DateCaptionLbl: Label 'Requested Delivery Date';
        Text000: Label '%1 du %2';
        VendorCaptionLbl: Label 'Vendor';
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
}

