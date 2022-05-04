pageextension 50062 "PWD SmallBusinessOwnerRC" extends "Small Business Owner RC"
{
    actions
    {
        addafter("Payment Slip List Archives")
        {
            action("PWD Archives sale quote without continuation")
            {
                applicationarea = all;
                Caption = 'Archives sale quote without continuation';
                RunObject = Page "PWD Archived Sales List";
                RunPageView = SORTING("Document Type", "No.", "Doc. No. Occurrence", "Version No.")
                                  WHERE("Document Type" = CONST(Quote));
            }
            action("PWD Archives purchase quote without continuation")
            {
                ApplicationArea = all;
                Caption = 'Archives purchase quote without continuation';
                RunObject = Page "PWD Archived Purchase List";
                RunPageView = SORTING("Document Type", "No.", "Doc. No. Occurrence", "Version No.")
                                  WHERE("Document Type" = CONST(Quote));
            }
        }
        addafter("Customer Invoice Discount")
        {
            action("PWD Service rates")
            {
                ApplicationArea = all;
                Caption = 'Service rates';
                RunObject = Page "PWD Tarifs préstation";
            }
            action("PWD Service rates M2")
            {
                ApplicationArea = all;
                Caption = 'Service rates';
                RunObject = Page "PWD Tarifs prestation M2";
            }
        }
    }
}
