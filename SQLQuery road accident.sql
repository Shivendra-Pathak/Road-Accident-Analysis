
      -- ROAD ACCIDENT REPORT ANALYSIS (2021-2022)
  
  create database road;

   use road ;

   select * from accident;
    
	 
	 
	 --Total casualties :  
     
	          select sum(number_of_casualties) as total_casualities
			   from accident;


     -- CY casualties  :
	     
		      select sum(number_of_casualties) as CY_casualities
			   from accident
			   where year(accident_date)=2022 ;


     --  CY accident  :
	          
			select  count(accident_index) as CY_casualties
			from accident 
			where year(accident_date)=2022 ;


     --  PY casualties  :

	        select sum(number_of_casualties) as PY_casualties 
			from accident
			where year(accident_date)=2021 ;


     --  PY accident  :

	        select  count(accident_index) as PY_casualties
			from accident 
			where year(accident_date)=2021 ;


     --  CY Casualties vs PY casualties month trend  :

	         --CY casualties by month trend   :

	       select datename(month,accident_date) as month_name,
		   sum(number_of_casualties) as CY_casualties from accident
		   where year(Accident_Date)=2021
		   group by datename(month,accident_date);

		      
			  -- PY casualties by month trend  :

			   select datename(month,accident_date) as month_name,
		   sum(number_of_casualties) as CY_casualties from accident
		   where year(Accident_Date)=2022
		   group by datename(month,accident_date);



     --  CY casualties by area  :
	     
		 select urban_or_rural_area,
		 sum(number_of_casualties) * 100 /
		 (select sum(number_of_casualties) 
		  from accident where year(Accident_Date)='2022') as percentage
		  from accident
		 where year(Accident_Date)='2022'
		 group by  urban_or_rural_area ;
		   

     --  CY casualties by light condition :


	      select 
		        CASE 
				    WHEN light_conditions IN ('daylight') then 'day'
					when light_conditions in ('darkness-no lighting','darkness-light unlit','darkness-light lit','darkness-lighting unknown') then 'NIGHT'
                end as light_conditions,
		 cast(sum(number_of_casualties) as decimal(10,2)) * 100 /
		 (select  cast(sum(number_of_casualties) as decimal(10,2))
		  from accident where year(Accident_Date)='2022') as CY_casualties_pct
		  from accident
		 where year(Accident_Date)='2022'
		 group by  
		         case
				    WHEN light_conditions IN ('daylight') then 'day'
					when light_conditions in ('darkness-no lighting','darkness-light unlit','darkness-light lit','darkness-lighting unknown') then 'NIGHT' 
					end
				     ;
		   


     --  CY casualties by vehicle type :

          select 
		       case 
			        when vehicle_type in ('agricultural vehicle')  then 'agriculture'
                    when vehicle_type in ('motorcycle over 500cc','motorcycle 125ccand under','motocycle 50cc and under'
					,'motorcycle over 125cc and upto 500 cc','pedal cycle')  then 'BIKE'
					when vehicle_type in ('bus or coach(17 or more pass seats)','minibus(8-16 passengers seat)')  then 'bus'
					when vehicle_type in ('car','taxi/private hire car')  then 'car'
					when vehicle_type in ('other vehicle','Ridden horse')  then 'other'
					else 'van'
               end as vehicle_group,
	     sum(number_of_casualties)as CY_casualties
         from accident
		 where year(accident_date) = '2022'
		 group by 
		        case
				     when vehicle_type in ('agricultural vehicle')  then 'agriculture'
                    when vehicle_type in ('motorcycle over 500cc','motorcycle 125ccand under','motocycle 50cc and under'
					,'motorcycle over 125cc and upto 500 cc','pedal cycle')  then 'BIKE'
					when vehicle_type in ('bus or coach(17 or more pass seats)','minibus(8-16 passengers seat)')  then 'bus'
					when vehicle_type in ('car','taxi/private hire car')  then 'car'
					when vehicle_type in ('other vehicle','Ridden horse')  then 'other'
					else 'van'
             end;

				   

     --  CY casualties by road type  :

	        select road_type,sum(number_of_casualties) from accident
		  where year(accident_date) = '2022'
		  group by road_type;


     --  CY casualties by accident severity  :
	      
		  SELECT accident_severity,sum(number_of_casualties) as cy_casualties
		  from accident
		  where year(accident_date) = '2022'
		  group by Accident_Severity
	    

     --  CY casualties by junction control  :

	      SELECT 
		       case
			       when Junction_Control in ('auto traffic sigl','auto traffic signal') then 'AUTO TRAFFIC SIGNAL'
				   WHEN junction_control in ('authorised person') then 'AUTHORISED PERSON'
				   WHEN junction_control in ('stop sign') then 'STOP SIGN'
				   WHEN JUNCTION_CONTROL in ('not at junction or within 20 metres') then 'NOT AT SIGNAL'
				   else 'OUT OF CONTROL'
              END  AS JUNCTION_CONTROL,
			 sum(number_of_casualties) as cy_casualties
		  from accident
		  where year(accident_date) = '2022'
		  group by 
		         CASE 
				     when Junction_Control in ('auto traffic sigl','auto traffic signal') then 'AUTO TRAFFIC SIGNAL'
				   WHEN junction_control in ('authorised person') then 'AUTHORISED PERSON'
				   WHEN junction_control in ('stop sign') then 'STOP SIGN'
				   WHEN JUNCTION_CONTROL in ('not at junction or within 20 metres') then 'NOT AT SIGNAL'
				   else 'OUT OF CONTROL'
              END ;
	    




	              ------ THE END -------
	   



