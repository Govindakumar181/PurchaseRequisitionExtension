codeunit 70104 calNetAmount
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Requistion Line", 'OnAfterValidateEvent', 'Amount', false, false)]
    local procedure UnitPriceChange(var Rec: Record "Purchase Requistion Line")
    begin
        Rec."Net Amount" := Rec.Amount * Rec.Quantity;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Requistion Line", 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure QtyChange(var Rec: Record "Purchase Requistion Line")
    begin
        Rec."Net Amount" := Rec.Amount * Rec.Quantity;
    end;

}