page 50009 "PWD Run Journal/Douane"
{
    Caption = 'PWD Run Journal/Douane';
    PageType = Card;

    actions
    {
        area(Processing)
        {
            action("Run Journal")
            {
                ApplicationArea = all;
                Caption = 'Run Journal';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = codeunit 50021;
            }
            action("Run Douane 1")
            {
                ApplicationArea = all;
                Caption = 'Run Journal';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = codeunit 50022;
            }
            action("Run Douane 2")
            {
                ApplicationArea = all;
                Caption = 'Run Journal';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = codeunit 50023;
            }
        }
    }
}
