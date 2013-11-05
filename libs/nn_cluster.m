% function used to be a distributed work
function [closest_patches_idx, dist, patches_position] = nn_cluster(img_path, centroids, params)
  
  [patches , features_patches, pyramid] = compute_valid_patches(img_path, params);
  
  if(isempty(patches))
    disp('ALERT NO patch FOUND ');
    return;
  end

  % for each candidate what is the closest patche
  % (and not for each patch what is the closest candidate)
  [closest_patches_idx, dist]=assigntoclosest(single(centroids),single(features_patches));
  
  % return patch info only from the closest patches
  patches = patches(closest_patches_idx,:);
  
  patches_position = get_patch_position(patches, pyramid, params);
end