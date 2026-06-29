USE telecom_db;
SET SQL_SAFE_UPDATES = 0;

-- 1. DATA CLEANSING: Impute missing contracts to 'Month-to-Month' (highest risk assumption)
UPDATE telecom_master 
SET contract_type = 'Month-to-Month' 
WHERE contract_type IS NULL OR contract_type = '';

-- 2. FEATURE ENGINEERING & AGGREGATION VIEW
CREATE OR REPLACE VIEW v_telecom_features AS
SELECT 
    customer_id, tenure_months, contract_type, network_type, monthly_bill,
    total_call_duration, days_since_recharge, network_drops, complaints, churn_label,
    -- Engineer a 'Usage Intensity' metric
    ROUND(total_call_duration / (tenure_months + 1), 2) AS avg_calls_per_month,
    -- Engineer a 'Customer Frustration Index' (Weighting drops and complaints)
    (network_drops * 1.5) + (complaints * 3.0) AS frustration_index
FROM telecom_master;

-- 3. VERIFY AND EXPORT
SELECT * FROM v_telecom_features;