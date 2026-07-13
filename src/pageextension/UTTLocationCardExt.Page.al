pageextension 67100 "UTT Location Card Ext" extends "Location Card"
{
    layout
    {
        addlast(Content)
        {
            group("IBP O9")
            {
                field("O9restrictedQty"; Rec.O9restrictedQty)
                {
                    ApplicationArea = All;
                    Caption = 'O9 blocked Qty';
                }
            }
        }
    }
}
