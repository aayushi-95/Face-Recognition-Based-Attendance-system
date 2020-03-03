function result = countFaces(crop,facedetect)

  for j=1:4
        crop=imrotate(crop,(j-1)*90);
        bounding_box=facedetect(crop);
        [m,c]=size(bounding_box);
        for k=1:m
            if m>0
                a(1)=bounding_box(k,1)-0.1*bounding_box(k,3);
                a(2)=bounding_box(k,2)-0.1*bounding_box(k,4);
                a(3)=1.2*bounding_box(k,3);
                a(4)=1.2*bounding_box(k,4);
                cropedface=imcrop(crop,a);

                %Resize and rewrite
                new_size=imresize(cropedface,[img_size,img_size]);
                imwrite(new_size,sprintf('%d_%d_%d.jpg',i,j,k))
                number_of_images=number_of_images+1;
                tally(:,:,:,number_of_images)=new_size;
            end
        end
    end