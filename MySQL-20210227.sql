SELECT cf.custom_form_id, ct.custom_text_1  'WuCardNum' ,  ct.custom_text_6  'MTCN' ,
ct.custom_text_5  'DocReferenceNum' ,
ct.custom_text_120  'Request_Source',
ct.custom_text_81	 'HostStatus',
ct.custom_text_82	 'Host_Responce',
ct.custom_text_80	 'Host_Try',
ct.custom_text_83	 'WURT_HOST_STATUS',
c.name, cf.custom_product_id ,cp.name ,cf.state , cf.parent_form_id , cf.created_on , cf.last_updated_on ,cf.last_updated_by,cf.created_by , cf.company_id , c.name
  FROM tbl_custom_forms cf
  left join tbl_custom_products cp on cf.custom_product_id = cp.id
  left join tbl_companies c ON cf.company_id = c.company_id
  left join tbl_custom_forms_custom_text ct on ct.custom_form_id = cf.custom_form_id
   WHERE     cf.custom_product_id = 328  order by 1 desc limit 10000 ;  
   
    -- XXXXXXXXXXXXXXXXXXXXXXXXXXXX-----------
 select status ,task_id , now() ,
   server_address
 , count(1) from tbl_asynchronous_tasks 
 where   scheduled_start > (CONVERT_TZ(now() - INTERVAL 30 HOUR,'UTC','America/New_York'))
 and task_type = 'AsyncFormHeavy'
 group by status ;
 
 -- Review Form Count
SELECT cf.custom_form_id, cf.external_field_2_value ,cf.custom_product_id ,cp.name ,cf.state , cf.parent_form_id , cf.created_on , cf.last_updated_on ,cf.last_updated_by,cf.created_by , cf.company_id , concat(substring_index ( substring_index (cf.current_assignee, '(' , - 1 ),')' ,1)) 'Assignee',
cf.current_assignee
  FROM tbl_custom_forms cf
  left join tbl_custom_products cp on cf.custom_product_id = cp.id
  -- left join tbl_companies c ON cf.company_id = c.company_id
   WHERE   cf.custom_product_id = 328 and cf.state like '%Review%'  
   -- and cf.current_assignee is null
   and cf.created_on > (CONVERT_TZ( now()- INTERVAL 24 hour , 'UTC' , 'America/New_York' )) ; group by  cf.external_field_2_value  ;order by 1 desc limit 100 ;
   
   SELECT at.task_id, cf.custom_form_id,  cf.state  , at.entity_id ,  at.task_type,  at.attempts
 status, cf.external_field_2_value
  FROM tbl_custom_forms cf
  left join tbl_asynchronous_tasks at on cf.custom_form_id = at.entity_id
   WHERE     cf.custom_product_id = 328 and cf.state = 'Draft' and  cf.external_field_2_value = 'DE'  and cf.created_on > '2021-02-26 01:00:00'  and  at.task_type = 'AsyncFormHeavy' and 
at.status = 'NEW' ;

 update tbl_asynchronous_tasks set status = 'KILLED' where task_id in
(88082700, 88082704, 88082706, 88082709, 88082710, 88082711, 88082714, 88082715, 88082716, 88082724, 88082726, 88082727, 88082737, 88082738, 88082740, 88082748, 88082745, 88082759, 88082749, 88082758, 88082750, 88082756, 88082751, 88082769, 88082768, 88082767, 88082777, 88082786, 88082789, 88082790, 88082788, 88082785, 88082784, 88082801, 88082796, 88082792, 88082800, 88082808, 88082815, 88082812, 88082816, 88082819, 88082822, 88082825, 88082826, 88082832, 88082846, 88082833, 88082842, 88082831, 88082849, 88082850, 88082852, 88082854, 88082860, 88082867, 88082875, 88082874, 88082878, 88082879, 88082880, 88082881, 88082882, 88082890, 88082892, 88082891, 88082894, 88082900, 88082902, 88082918, 88082910, 88082912, 88082923, 88082922, 88082925, 88082935, 88082936, 88082926, 88082931, 88082928, 88082937, 88082945, 88082940, 88082946, 88082947);
 commit ;
