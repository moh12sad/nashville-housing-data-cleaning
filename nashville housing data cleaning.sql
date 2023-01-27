select * from [dbo].[Nashville Housing Data]

select saledate , CONVERT(date,saledate)
from [dbo].[Nashville Housing Data]

update [dbo].[Nashville Housing Data]
set saledate=CONVERT(date,saledate)

select *
from [dbo].[Nashville Housing Data]
--where propertyaddress is null
order by parcelid

select a.parcelid,b.parcelid,a.propertyaddress,b.propertyaddress,isnull(a.propertyaddress,b.propertyaddress)
from [dbo].[Nashville Housing Data] a
join [dbo].[Nashville Housing Data] b
on a.parcelid=b.parcelid
and a.uniqueid<>b.uniqueid
--where a.propertyaddress is null

update a
set propertyaddress = isnull(a.propertyaddress,b.propertyaddress)
from [dbo].[Nashville Housing Data] a
join [dbo].[Nashville Housing Data] b
on a.parcelid=b.parcelid
and a.uniqueid<>b.uniqueid
where a.propertyaddress is null

select propertyaddress
from [dbo].[Nashville Housing Data]
--where propertyaddress is null
--order by parcelid

select SUBSTRING(propertyaddress,1,charindex(',',propertyaddress)-1) address
,SUBSTRING(propertyaddress,charindex(',',propertyaddress)+1,LEN(propertyaddress)) city
from [dbo].[Nashville Housing Data]

alter table [dbo].[Nashville Housing Data]
add propertysplitaddress nvarchar(255);

update [dbo].[Nashville Housing Data]
set propertysplitaddress=SUBSTRING(propertyaddress,1,charindex(',',propertyaddress)-1)

alter table [dbo].[Nashville Housing Data]
add propertysplitcity nvarchar(255);

update [dbo].[Nashville Housing Data]
set propertysplitcity=SUBSTRING(propertyaddress,charindex(',',propertyaddress)+1,LEN(propertyaddress))

select *
from [dbo].[Nashville Housing Data]

select parsename(replace(owneraddress,',','.'),3)
,parsename(replace(owneraddress,',','.'),2)
,parsename(replace(owneraddress,',','.'),1)
from [dbo].[Nashville Housing Data]

alter table [dbo].[Nashville Housing Data]
add ownersplitaddress nvarchar(255);

update [dbo].[Nashville Housing Data]
set ownersplitaddress=parsename(replace(owneraddress,',','.'),3) 

alter table [dbo].[Nashville Housing Data]
add ownersplitcity nvarchar(255);

update [dbo].[Nashville Housing Data]
set ownersplitcity=parsename(replace(owneraddress,',','.'),2) 

alter table [dbo].[Nashville Housing Data]
add ownersplitstate nvarchar(255);

update [dbo].[Nashville Housing Data]
set ownersplitstate=parsename(replace(owneraddress,',','.'),1) 

select *
from [dbo].[Nashville Housing Data]


select *
from [dbo].[Nashville Housing Data]

select distinct (soldasvacant), count(soldasvacant)
from [dbo].[Nashville Housing Data]
group by soldasvacant
order by 2


alter table [dbo].[Nashville Housing Data]
alter column soldasvacant nvarchar(255)

update [dbo].[Nashville Housing Data]
set soldasvacant = 'YES'
where soldasvacant = '1'

update [dbo].[Nashville Housing Data]
set soldasvacant = 'NO'
where soldasvacant = '0'



with rownumcte as(
select * , ROW_NUMBER() over(
           partition by parcelid,
		                propertyaddress,
						saledate,
						saleprice,
						legalreference
						order by uniqueid ) ROW_NUM
from [dbo].[Nashville Housing Data] )

select *
from rownumcte
where ROW_NUM >1
order by parcelid

alter table [dbo].[Nashville Housing Data]
drop column propertyaddress,owneraddress

select *
from [dbo].[Nashville Housing Data]