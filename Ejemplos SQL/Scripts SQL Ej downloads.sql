--- ejemplo

-- SPONSORED DOWNLOADS

--Info and instructions:

-- Manufacturer: You will need to use quotation marks. You can insert more than 1 manufacturer using commas.
-- Manufacturer list and respective code: https://tinyurl.com/yrbbtpa8 (if you need further assistance ask David or Tobias)
-- Ref List:  list and respective codes : https://tinyurl.com/yrbbtpa8 (if you need further assistance ask David or Tobias)
-- Date Frequency: date frequency in which you want your data to be grouped. Options: day, week, month, quarter, year
-- Start_Date: date in which your date frequency will start collecting data

select date_trunc('{{date_frequency}}', timestamp) as date,
        -- part as date,
        -- manufacturer as date,
       count(*) as ctn 
       from actstream_action ac
left join spicemodels_unipart su on ac.target_object_id::integer = su.id
left join auth_user on   ac.actor_object_id::integer = auth_user.id
where verb = 'download'
 --and part ilike '%RPX-1.5%'
and  manufacturer ilike any (array[{{manufacturer}}])
and ref ilike any (array[{{ref}},'carousel_search'])
and timestamp >= '{{start_date}}'
and (is_staff = FALSE or is_staff is null)
group by date order by date;

---A. All Downloads (Organic + Sponsored)
-- Objective: view all downloads (both organic and sponsored)
-- INSTRUCTIONS:
-- Manufacturer: You will need to use quotation marks. You can insert more than 1 manufacturer using commas.
-- Manufacturer list and respective code: https://tinyurl.com/yrbbtpa8 (if you need 'access' ask David or Tobias)
-- Date Frequency: date frequency in which you want your data to be grouped. Options: day, week, month, quarter, year
-- Start_Date: date in which your date frequency will start collecting data

SELECT date_trunc('{{date_frequency}}', timestamp) as date,
       count(*) as "Total"
       from actstream_action ac
left join spicemodels_unipart su on ac.target_id = su.id
left join auth_user au on ac.actor_id = au.id
where verb = 'download' 
and  manufacturer ilike any(array[{{manufacturer}}])
and (is_staff = FALSE or is_staff is null)
and timestamp >= '{{start_date}}'
--and (ref!='None' or ref is not NULL)
group by date 
order by date;


--- 
-- Unique Users that made a Download (Sponsored + Organic)


--Info and instructions:

-- Manufacturer: You will need to use quotation marks. You can insert more than 1 manufacturer using commas.
-- Manufacturer list and respective code: https://tinyurl.com/yrbbtpa8 (if you need further assistance ask David or Tobias)
-- Date Frequency: date frequency in which you want your data to be grouped. Options: day, week, month, quarter, year
-- Start_Date: date in which your date frequency will start collecting data


SELECT date_trunc('{{date_frequency}}',timestamp) as date, 
 count(distinct(auth_user.id)) as counts
from actstream_action
 left join spicemodels_unipart on actstream_action.target_object_id::integer = spicemodels_unipart.id
 left join auth_user on actstream_action.actor_object_id::integer = auth_user.id
 where verb = 'download'
 and manufacturer ilike any (array[{{manufacturer}}])
  and timestamp >= '{{start_date}}'
 and (is_staff = FALSE or is_staff is null) 
 --and email not ilike '%@snapeda.com' and te_param::json -> 'Offers'->> 'buy_url' ilike '%ti%'
group by date 
order by date;


--- all search keywords
-- All Search Keywords: this query returns the total amount of searches for each corresponding keyword

-- Start_Date: date in which the query will start collecting data




select search_term, count(*) as total_amount 
from actstream_action
left join spicemodels_unipart su on actstream_action.target_id = su.id
left join auth_user au on actstream_action.actor_id = au.id
where verb = 'download' and is_staff = FALSE
and manufacturer ilike '%kingsto%'
--AND (timestamp between '{{a_start_date}}' and '{{b_end_date}}')
AND timestamp >= '2021-07-01'
-- and mydata::json->>'plugin' ilike 'designspark%'
--and ref ilike 'recom_%'
 group by search_term 
 order by total_amount desc limit 100;
 
 -- Competitor Design Wins: (this occurs when a user downloads a sponsored part instead than the one they were seeking for)

-- Info and Instructions:

-- Ref List:  list and respective codes : https://tinyurl.com/yrbbtpa8 (if you need further assistance ask David or Tobias)
-- Start_Date: date in which the query will start collecting data




SELECT count(*) as ctn
 from actstream_action ac
left join spicemodels_unipart su on ac.target_object_id::integer = su.id
left join auth_user on ac.actor_object_id::integer = auth_user.id
where verb = 'download'
  and (is_staff = FALSE or is_staff is NULL)
  and ref ilike any (array[{{ref}},'carousel_search'])
  and timestamp >= '{{start_date}}';