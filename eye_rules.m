%Rules to detect eye blobs
%Solidity of the region is greater than 0.5
%Aspect ratio between 0.8 and 4.0
%Connected region is not touching the border
%The orientation of the connected component is between -45 and +45 degree


function image_eye_rules = eye_rules(in_image)

    blob_areas = regionprops(in_image, 'Solidity', 'BoundingBox', 'Orientation', 'PixelList', 'Area');

%clear border
    image_eye_rules = imclearborder(in_image);

    for i = 1:length(blob_areas)
        
        solidity = blob_areas(i).Solidity;
        
        width = blob_areas(i).BoundingBox(3);
        height = blob_areas(i).BoundingBox(4);
        aspectRatio = width/height;
        
        orientation = blob_areas(i).Orientation;
        
        % remove blobs according to rules
        if ((solidity < 0.5) && (aspectRatio > 4.0 || aspectRatio < 0.8) && (orientation < -45 || orientation > 45))
            region_pixels = blob_areas(i).PixelList;
            image_eye_rules(region_pixels) = 0;
        end   
    end
end



