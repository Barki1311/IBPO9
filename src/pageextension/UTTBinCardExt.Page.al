pageextension 67101 "UTT Bin Card Ext" extends Bins
{
    layout
    {
        addafter(Dedicated)
        {
          
                field("O9restrictedQty"; Rec.O9restrictedQty)
                {
                    ApplicationArea = All;
                    Caption = 'O9 restricted Qty';
                }
            }
      
    }
}
