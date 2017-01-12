echo "* Maarten van Doornik, 12-01-2017"

cd data

echo "* Assign input file to a variable"
input=$(ls LE71700552001036SGS00_SR_Gewata_INT1U.tif)

echo "* Calculate NDVI"
gdal_calc.py -A $input --A_band=4 -B $input --B_band=3  --outfile=ndvi.tif  --calc="(A.astype(float)-B)/(A.astype(float)+B)" --type='Float32'

echo "* Resample to pixels of 60 m"
gdal_translate -tr 60 60 -r bilinear ndvi.tif ndvi_resampled.tif

echo "* Reproject"
gdalwarp -t_srs EPSG:4326 ndvi_resampled.tif ndvi_final.tif