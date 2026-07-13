xmlport 67024 "UTT O9ResourceAvailTime_SP"
{
    Caption = 'UTT O9 Resource Availabiliy Time';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'IVMK_P_o9ResourceAvaiTime.dsv';
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

                textelement(ResourceCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ResourceCodeLbl := 'ResourceCode';
                        IBPO9Buffer."Field 1" := ResourceCodeLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(LocationCodeLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LocationCodelbl := 'LocationCode';
                        IBPO9Buffer."Field 2" := LocationCodelbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(DayLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DayLbl := 'Day';
                        IBPO9Buffer."Field 3" := DayLbl;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(ResourceAvailabilityLbl)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ResourceAvailabilityLbl := 'ResourceAvailability(in Hours/Days)';
                        IBPO9Buffer."Field 4" := ResourceAvailabilityLbl;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    EntryNo: Integer;
                begin
                    EntryNo := IBPO9Buffer.getNextEntry();
                    IBPO9Buffer.Init();
                    IBPO9Buffer."Entry No." := EntryNo;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := o9ProjectLib.GetCurrentXMLPortName(67024);
                    IBPO9Buffer.Insert();
                end;
            }
            // tableelement(MachineCenter; "Machine Center")
            // {
            //     XmlName = 'Data';
            //     // SourceTableView = sorting("No.") WHERE("KVSTEX Item Type" = filter("Finished Product" | "yarn"));
            //     RequestFilterFields = "No.";

            //     textelement(ResourceCode)
            //     {
            //         trigger OnBeforePassVariable()
            //         var
            //             myInt: Integer;
            //         begin
            //             ResourceCode := MachineCenter."No.";
            //             IBPO9Buffer."Field 1" := ResourceCode;
            //             IBPO9Buffer.Modify();
            //         end;
            //     }

            //     textelement(LocationCode)
            //     {
            //         trigger OnBeforePassVariable()
            //         var
            //             myInt: Integer;
            //         begin
            //             case CompanyInfo."Country/Region Code" of
            //                 'DE':
            //                     LocationCode := 'IVMK';
            //                 'MX':
            //                     LocationCode := 'IVMP';
            //             end;
            //             IBPO9Buffer."Field 2" := LocationCode;
            //             IBPO9Buffer.Modify();
            //         end;
            //     }
            //     textelement(wDayLbl)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             wDayLbl := 'N/A';
            //             IBPO9Buffer."Field 3" := wDayLbl;
            //             IBPO9Buffer.Modify();
            //         end;
            //     }
            //     textelement(wResourceAvailabilityLbl)
            //     {
            //         trigger OnBeforePassVariable()
            //         begin
            //             wResourceAvailabilityLbl := 'N/A';
            //             IBPO9Buffer."Field 4" := wResourceAvailabilityLbl;
            //             IBPO9Buffer.Modify();
            //         end;
            //     }

            //     trigger OnPreXmlItem()
            //     var
            //         myInt: Integer;
            //     begin
            //         // MachineCenter.Setfilter("KVSTEX Item Type", '%1|%2|%3', item."KVSTEX Item Type"::"Finished Product", item."KVSTEX Item Type"::Yarn, item."KVSTEX Item Type"::"KVS Cutset", item."KVSTEX Item Type"::"KVS Colour Ribbon");
            //         // item.SetRange("KVSTEX Item Status", item."KVSTEX Item Status"::Certified);
            //         companyInfo.get();
            //     end;

            //     trigger OnAfterGetRecord()
            //     var
            //         EntryNo: Integer;
            //     begin
            //         EntryNo := IBPO9Buffer.getNextEntry();
            //         IBPO9Buffer.Init();
            //         IBPO9Buffer."Entry No." := EntryNo;
            //         IBPO9Buffer."Export Date" := CurrentDateTime();
            //         IBPO9Buffer."Export Batch ID" := o9ProjectLib.GetCurrentXMLPortName(67024);
            //         IBPO9Buffer.Insert();
            //     end;
            // }
            tableelement(WorkCenter; "Work Center")
            {
                XmlName = 'Data';
                // SourceTableView = sorting("No.") WHERE("KVSTEX Item Type" = filter("Finished Product" | "yarn"));
                RequestFilterFields = "No.";

                textelement(wResourceCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        wResourceCode := WorkCenter."No.";
                        IBPO9Buffer."Field 1" := wResourceCode;
                        IBPO9Buffer.Modify();
                    end;
                }

                textelement(wLocationCode)
                {
                    trigger OnBeforePassVariable()
                    var
                        myInt: Integer;
                    begin
                        case CompanyInfo."Country/Region Code" of
                            'DE':
                                wLocationCode := 'IVMK';
                            'MX':
                                wLocationCode := 'IVMP';
                        end;
                        IBPO9Buffer."Field 2" := wLocationCode;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(wResourceAvailability)
                {
                    trigger OnBeforePassVariable()
                    begin
                        wResourceAvailability := 'N/A';
                        IBPO9Buffer."Field 3" := wResourceAvailability;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(wResourceEfficiency)
                {
                    trigger OnBeforePassVariable()
                    begin
                        wResourceEfficiency := 'N/A';
                        IBPO9Buffer."Field 4" := wResourceEfficiency;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(wAverageDailyMaintenanceHours)
                {
                    trigger OnBeforePassVariable()
                    begin
                        wAverageDailyMaintenanceHours := 'N/A';
                        IBPO9Buffer."Field 5" := wAverageDailyMaintenanceHours;
                        IBPO9Buffer.Modify();
                    end;
                }
                textelement(wAverageDailySetupHours)
                {
                    trigger OnBeforePassVariable()
                    begin
                        wAverageDailySetupHours := 'N/A';
                        IBPO9Buffer."Field 6" := wAverageDailySetupHours;
                        IBPO9Buffer.Modify();
                    end;
                }

                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                    // MachineCenter.Setfilter("KVSTEX Item Type", '%1|%2|%3', item."KVSTEX Item Type"::"Finished Product", item."KVSTEX Item Type"::Yarn, item."KVSTEX Item Type"::"KVS Cutset", item."KVSTEX Item Type"::"KVS Colour Ribbon");
                    // item.SetRange("KVSTEX Item Status", item."KVSTEX Item Status"::Certified);
                    //companyInfo.get();
                end;

                trigger OnAfterGetRecord()
                var
                    EntryNo: Integer;
                begin
                    EntryNo := IBPO9Buffer.getNextEntry();
                    IBPO9Buffer.Init();
                    IBPO9Buffer."Entry No." := EntryNo;
                    IBPO9Buffer."Export Date" := CurrentDateTime();
                    IBPO9Buffer."Export Batch ID" := o9ProjectLib.GetCurrentXMLPortName(67024);
                    IBPO9Buffer.Insert();
                end;
            }


        }

    }
    var
        companyInfo: Record "Company Information";
        IBPO9Buffer: Record "UTT IBPO9 Buffer";
        o9ProjectLib: Codeunit "UTT O9 Project Lib";

}
