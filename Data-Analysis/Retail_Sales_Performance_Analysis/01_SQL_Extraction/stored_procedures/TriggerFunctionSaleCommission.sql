DROP TRIGGER IF EXISTS trg_record_sale_commission ON sales;

CREATE TRIGGER trg_record_sale_commission
AFTER INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION trigger_sale_commission();
