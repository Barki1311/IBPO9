tableextension 67055 "UTT Location Ext" extends "Location"
{
    fields
    {
        field(50000; O9restrictedQty; boolean)
        {
            Caption = 'O9 blocked Qty';
            DataClassification = ToBeClassified;
        }
    }
}
