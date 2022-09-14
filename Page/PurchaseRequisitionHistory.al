page 70104 "Purchase Requisition History"
{
    ApplicationArea = All;
    Caption = 'Purchase Requisition History';
    PageType = List;
    SourceTable = "Purchase Requisition History";
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("PR No"; Rec."PR No")
                {
                    ToolTip = 'Specifies the value of the Header No. field.';
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.';
                    ApplicationArea = All;
                }
                field("Status From"; Rec."Status From")
                {
                    ToolTip = 'Specifies the value of the Status From field.';
                    ApplicationArea = All;
                }
                field("Status To"; Rec."Status To")
                {
                    ToolTip = 'Specifies the value of the Status To field.';
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ToolTip = 'Specifies the value of the Modified By field.';
                    ApplicationArea = All;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ToolTip = 'Specifies the value of the Modified Date field.';
                    ApplicationArea = All;
                }
                field("Approver Comments"; Rec."Approver Comments")
                {
                    ToolTip = 'Specifies the value of the Approver Comments field.';
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnOpenPage()
    var
        varCurrentUser: Record User;
        varPermissions: Record "Access Control";
        varRoleID: Text;
    begin
        varCurrentUser.SETFILTER("User Name", UserId());
        If varCurrentUser.FindSet() then begin

            varPermissions.SetFilter("User Security ID", varCurrentUser."User Security ID");
            varPermissions.SetFilter("Role ID", 'SUPER');
            if varPermissions.FindSet() then begin

                exit
            end

            else begin
                Rec.FilterGroup(100);
                Rec.SetFilter(Email, varCurrentUser."Authentication Email");
                if Rec.FindSet() then begin

                    exit;

                end;
                Rec.FilterGroup(0);
            end;


        end;




    end;

}
