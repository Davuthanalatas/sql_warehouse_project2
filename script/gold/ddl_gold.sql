
-- This creates views for gold layer in the waehouse. 
CREATE VIEW gold.dim_customers AS 
SELECT 
ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
        ci.cst_id AS customer_id, 
        ci.cst_key AS customer_number,
        ci.cst_firstname AS firstname,
        ci.cst_lastname AS lastname,
        la.cntry AS country ,
        ci.cst_marital_status AS marital_status,
        ci.cst_gndr AS gender,
        ci.cst_create_date AS crete_date,
        ca.bdate AS birthdate

FROM silver.crm_cust_info ci 
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la 
ON ci.cst_key = la.cid






CREATE VIEW gold.dim_products AS
SELECT 

ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
    pn.prd_id,
    pn.cat_id,
    pn.prd_key,
    pn.prd_nm,
    pn.prd_cost,
    pn.prd_line,
    pn.prd_start_dt,
    pc.cat,
    pc.subcat,
    pc.maintenance

FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pn.cat_id = pc.id


  
CREATE VIEW gold.fact_sales AS
SELECT 
 [sls_ord_num]
      ,[sls_pred_ky]
      ,[sls_cust_id]
      ,[sls_order_dt]
      ,[sls_ship_dt]
      ,[sls_due_dt]
      ,[sls_sales]
      ,[sls_quantity]
      ,[sls_price]
      ,[dwh_create_date]
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
ON sd.sls_pred_ky = pr.prd_nm

LEFT JOIN gold.dim_customers cu
ON sd.sls_cust_id = cu.customer_id


