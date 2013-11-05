function extract_patches_from_position(patches, imgs)

  % we sort by imidx (image idx) to not load the same image several times
  [~, sorted_patch_idx] = sort([patches.imidx]);

  last_idx = -1;
  
  for(i = sorted_patch_idx(:)')
    img_idx = patches(i).imidx;
     
    % load image if new image idx
    if (last_idx ~= img_idx)
      I = imread(imgs(img_idx).path);
      last_idx = img_idx;
      dir = sprintf('results/images/%d', img_idx);
      mkdir(dir);
    end
   
    % cut the image according to patch dimension
    %res{i} = I(patches(i).y1:patches(i).y2,patches(i).x1:patches(i).x2,:);
    
    rect = [patches(i).y1 patches(i).x1 (patches(i).y2-patches(i).y1) (patches(i).x2-patches(i).x1)];
    
    %disp(rect);
    I2 = imcrop(I,rect);
    
    %imshow(I2),figure
    
    filename = sprintf('results/images/%d/patch_%d.jpg', img_idx, i);
    imwrite(I2, filename);
    
   end
end