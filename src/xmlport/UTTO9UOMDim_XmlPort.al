xmlport 67006 "UTT O9UOMDim"
{
    Caption = 'UTT O9UOMDim';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_UOM.dsv';
    TableSeparator = '<NewLine>';
    FieldSeparator = '|';
    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'Header';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                textelement(UOMLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOMLbl := 'UOM';
                        IBPO9Buffer."Field 1" := UOMLbl;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IBPO9Buffer.Init();
                    if not IBPO9Buffer.FindLast() then
                        IBPO9Buffer."Entry No." := 1
                    else
                        IBPO9Buffer."Entry No." := IBPO9Buffer."Entry No." + 1;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'UOMDIM';
                    IBPO9Buffer.Insert();
                end;
            }

            tableelement(UOM; "Unit of Measure")
            {
                XmlName = 'UOM';
                RequestFilterFields = Code;
                textelement(Matl_Number) 
                {
                    trigger OnBeforePassVariable()
                    begin
                        Matl_Number := UOM.Code;
                        IBPO9Buffer."Field 1" := Matl_Number;
                        IBPO9Buffer.Modify();
                    end;
                 }

                trigger OnAfterGetRecord()
                begin
                    IBPO9Buffer.Init();
                    if not IBPO9Buffer.FindLast() then
                        IBPO9Buffer."Entry No." := 1
                    else
                        IBPO9Buffer."Entry No." := IBPO9Buffer."Entry No." + 1;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := 'UOMDIM';
                    IBPO9Buffer.Insert();
                end;
            }
        }
    }

    var
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
}
