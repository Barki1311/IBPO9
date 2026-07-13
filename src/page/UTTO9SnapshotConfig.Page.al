page 67051 "UTT O9 Snapshot Config"
{
    Caption = 'O9 Snapshot Configurations', Comment = 'DEU=O9-Snapshot-Konfigurationen,DEA=O9-Snapshot-Konfigurationen';
    ApplicationArea = All;
    UsageCategory = Administration;
    PageType = List;
    SourceTable = UTTO9SnapshotConfig;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique code for this snapshot configuration.';
                    Lookup = false;
                    AssistEdit = false;
                    DrillDown = false;
                }
                field(XMLPortName; XMLPortName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the XML Port used for exporting the snapshot data. The XML Port must be designed to export data in a specific format expected by the recipients of the snapshot.';
                    Lookup = true;
                    AssistEdit = false;
                    DrillDown = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description for this snapshot configuration.';
                }
                field(TurnoverPlanFilter; Rec.TurnoverPlanFilter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the turnover plan name used as filter for this snapshot.';
                }
                field(CurrencyCode; Rec.CurrencyCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the currency code for amount calculations. Leave blank for LCY.';
                }
                field(StartDate; Rec.StartDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the start date of the reporting period. The end date is always today.';
                }
                field(EndDate; Rec.EndDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%DEU=Enddatum,DEA=Enddatum';
                }
                field(dateFormel; Rec.DateFormel)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a date formula to calculate the Start and End Date. If this field is filled, it will override the values in the Start Date and End Date fields.', Comment = '%DEU=Datumsformel,DEA=Datumsformel';
                }
                field(KeepHistory; KeepHistory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to keep historical snapshot data when running new snapshots. If true, new snapshot entries will be added without deleting old ones. If false, old snapshot entries for the same configuration will be deleted before inserting new ones.';
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this configuration is included in the automated job queue run.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RunSnapshot)
            {
                ApplicationArea = All;
                Caption = 'Run Snapshot', Comment = 'DEU=Snapshot ausführen,DEA=Snapshot ausführen';
                ToolTip = 'Runs the SIV snapshot calculation for this configuration immediately.';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()

                begin

                    o9ProjectLib.RunSnapshot(Rec);
                end;
            }
            action(RunAllActive)
            {
                ApplicationArea = All;
                Caption = 'Run All Active', Comment = 'DEU=Alle aktiven ausführen,DEA=Alle aktiven ausführen';
                ToolTip = 'Runs the SIV snapshot for all active configurations.';
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Process;
                 PromotedIsBig = true;

                trigger OnAction()

                begin
                    o9ProjectLib.CreateDailySnapshot();
                    Message(MsgAllSnapshotsDone);
                end;
            }
            action(CleanupOldSnapshots)
            {
                ApplicationArea = All;
                Caption = 'Cleanup Old Snapshots', Comment = 'DEU=Alte Snapshots bereinigen,DEA=Alte Snapshots bereinigen';
                ToolTip = 'Deletes old snapshot entries for configurations that are set to not keep history.';
                Image = Erase;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    o9ProjectLib.CleanupOldSnapshots();
                    Message(MsgcleanupOldSnapshots);
                end;
            }
            action(ShowSnapshotData)
            {
                ApplicationArea = All;
                Caption = 'Show Snapshot Data', Comment = 'DEU=Snapshot-Daten anzeigen,DEA=Snapshot-Daten anzeigen';
                ToolTip = 'Opens the snapshot entries for this configuration.', Comment = 'DEU=Öffnet die Snapshot-Einträge für diese Konfiguration.';
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                 O9Buffer: Record "UTT IBPO9 Buffer";
                 O9BufferPage: Page "UTT IBPO9 Buffer List";
                begin
                    O9Buffer.SetRange("Export Batch ID", rec.XMLPortName);
                    O9BufferPage.SetTableView(O9Buffer);
                    O9BufferPage.Run();
                end;
            }
        }
    }

    var
        MsgSnapshotDone: Label 'Snapshot for configuration "%1" successfully updated.', Comment = 'DEU=Snapshot für Konfiguration "%1" erfolgreich aktualisiert.,DEA=Snapshot für Konfiguration "%1" erfolgreich aktualisiert.';
        MsgAllSnapshotsDone: Label 'All active snapshots successfully updated.', Comment = 'DEU=Alle aktiven Snapshots erfolgreich aktualisiert.,DEA=Alle aktiven Snapshots erfolgreich aktualisiert.';
        O9ProjectLib: Codeunit "UTT O9 Project Lib";
        MsgcleanupOldSnapshots: Label 'Old snapshots cleaned up successfully.', Comment = 'DEU=Alte Snapshots erfolgreich bereinigt.,DEA=Alte Snapshots erfolgreich bereinigt.';

}
