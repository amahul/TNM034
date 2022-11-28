function[crop_im] = crop_face(right_eye, left_eye, in_img)

    x1 = right_eye - 50; 
    y1 = left_eye - 100; 
    x2 = 205; 
    y2 = 300;
    
    crop_im = imcrop(in_img,[x1 y1 x2 y2]);
end