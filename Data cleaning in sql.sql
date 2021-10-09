-- Cleaning Data in SQL Queries
select*
from NashvilleHousing
 --Standardize Date format
 Select SaleDate ,CONVERT( date,SaleDate)
 from NashvilleHousing

 update NashvilleHousing
 set SaleDate = CONVERT( date,SaleDate

 Alter table NashvilleHousing
 add salesdateConverted date;

 update NashvilleHousing
 set salesdateConverted = CONVERT( date,SaleDate)


 -- Change Y and N to Yes and No in SoldAsVacant 

 select distinct(soldasvacant)
 from NashvilleHousing



Select  salesdateConverted ,CONVERT( date,SaleDate)
 from NashvilleHousing

 --Populate Property Addresss

  Select PropertyAddress
 from  NashvilleHousing
 where PropertyAddress is null

 
  Select *
 from NashvilleHousing
 --where PropertyAddress is null
 Order by ParcelID

 --self join

   Select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,ISNULL(a.PropertyAddress,b.PropertyAddress)
 from [Portfolio projectCovid]..Nashville a
 join [Portfolio projectCovid]..Nashville b
 on a.ParcelID = b.ParcelID
 and a.[UniqueID ] <> b.[UniqueID ]
 where a.PropertyAddress is null

 update a
 set PropertyAddress =ISNULL(a.PropertyAddress,b.PropertyAddress)
  from NashvilleHousing a
 join NashvilleHousing b
 on a.ParcelID = b.ParcelID
 and a.[UniqueID ] <> b.[UniqueID ]
 where a.PropertyAddress is null

 
 --Breaking address into seoarate column


   Select *
 from NashvilleHousing
 --where PropertyAddress is null
 --Order by ParcelID

   Select 
   SUBSTRING  (PropertyAddress ,1,CHARINDEX (',', PropertyAddress)-1) as address
   , SUBSTRING  (PropertyAddress ,CHARINDEX (',', PropertyAddress)+1 , len(propertyaddress)) as address
 from NashvilleHousing

  Alter table NashvilleHousing
 add PropertyNewAddress Nvarchar(255);

 update NashvilleHousing
 set PropertyNewAddress =  SUBSTRING  (PropertyAddress ,1,CHARINDEX (',', PropertyAddress)-1)

  Alter table NashvilleHousing
 add PropertyCity nvarchar(255);

 update NashvilleHousing
 set PropertyCity = SUBSTRING  (PropertyAddress ,CHARINDEX (',', PropertyAddress)+1 , len(propertyaddress))


 select OwnerAddress
 from NashvilleHousing

  select 
  PARSENAME (replace(owneraddress,',','.'),3),
   PARSENAME (replace(owneraddress,',','.'),2),
    PARSENAME (replace(owneraddress,',','.'),1)
 from NashvilleHousing

   Alter table NashvilleHousing
 add OwnerSplitAdress Nvarchar(255);

 update NashvilleHousing
 set OwnerSplitAdress =  PARSENAME (replace(owneraddress,',','.'),3)

   Alter table NashvilleHousing
 add OwnerSplitCity Nvarchar(255);

 update NashvilleHousing
 set OwnerSplitCity =  PARSENAME (replace(owneraddress,',','.'),2)

   Alter table NashvilleHousing
 add OwnerSplitState Nvarchar(255);

 update NashvilleHousing
 set OwnerSplitState =  PARSENAME (replace(owneraddress,',','.'),1)


 --Change Y and N to Yes and NO in soldbyvacant
  Select distinct (soldasvacant), count (soldasvacant)
  from NashvilleHousing
  group by SoldAsVacant
  order by 2

  select 
  Case when SoldAsVacant ='Y'then 'Yes'
        when SoldAsVacant ='N' then 'No'
		else SoldAsVacant
		end
 from NashvilleHousing

Update NashvilleHousing
set SoldAsVacant= Case when SoldAsVacant ='Y'then 'Yes'
        when SoldAsVacant ='N' then 'No'
		else SoldAsVacant
		end


		--Removing Duplicates


	WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From NashvilleHousing
--order by ParcelID
)
select *
From RowNumCTE
Where row_num > 1
--Order by PropertyAddress

   -- Deleting unused columns



		select *
			from NashvilleHousing

			alter table NashvilleHousing
			drop column owneraddress,propertyaddress,taxDistrict