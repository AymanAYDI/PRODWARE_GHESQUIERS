page 50009 "PWD Run Journal/Douane"
{
    Caption = 'Run Journal/Douane';
    PageType = Card;
UsageCategory = None;
    actions
    {
        area(Processing)
        {
            action("Run Journal")
            {
                ApplicationArea = all;
                Caption = 'Run Journal';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = codeunit "PWD RunJournal";
                PromotedOnly = true;
            }
            action("Run Douane 1")
            {
                ApplicationArea = all;
                Caption = 'Run Journal';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = codeunit "PWD Run douane1";
                PromotedOnly = true;
            }
            action("Run Douane 2")
            {
                ApplicationArea = all;
                Caption = 'Run Journal';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = codeunit "PWD Run douane2";
            }
        }
    }
}
