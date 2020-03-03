% clear ; 
clc

%Testing with a sample image
input_image=imread('5.jpg');
imshow(input_image);title('Sample Image');

figure;
input_image=imgaussfilt(input_image); %Apply Gaussian Filter
[r,c]=size(input_image(:,:,1));
facedetect=vision.CascadeObjectDetector('FrontalFaceCART','MinSize',[100,100],'MergeThreshold',5);
multiple_images=0;
face_loc=zeros(100,5);
faces_1=zeros(150,150,3,100);

%Detecting number of faces present in an image
for i=1:4
    degree=(i-1)*90;
    to_crop=imrotate(input_image,degree);
    bounding_box=facedetect(to_crop);
    [multipleface,col]=size(bounding_box);
    for k=1:multipleface
            if multipleface>0
                multiple_images=multiple_images+1;
                face_loc(multiple_images,1:4)=bounding_box(k,:);
                face_loc(multiple_images,5)=degree;
                a(1)=bounding_box(k,1)-0.1*bounding_box(k,3);
                a(2)=bounding_box(k,2)-0.1*bounding_box(k,4);
                a(3)=1.2*bounding_box(k,3);
                a(4)=1.2*bounding_box(k,4);
                cropedface=imcrop(to_crop,a);
                resized=imresize(cropedface,[150,150]);
                faces_1(:,:,:,multiple_images)=resized;
            end
    end
end
faces_1(:,:,:,~any(faces_1,[1,2,3]))=[];
faces_1=uint8(faces_1);
face_loc(~any(face_loc,2),:)=[];


%Setting parameters for Face Recognition
facedetect=vision.CascadeObjectDetector('FrontalFaceCART','MinSize',[100,100],'MergeThreshold',9);
faces_2=zeros(150,150,3,size(faces_1,4));

student = ["Pavan" "Divya" "Aayushi" "Durga" "Ayaan" "Yazhini";
         "Absent" "Absent" "Absent" "Absent" "Absent" "Absent"];

new_face_loc=[0 0 0 0];
for i=1:size(faces_1,4)
    bounding_box=facedetect(faces_1(:,:,:,i));
    if size(bounding_box,1)~=0
        faces_2(:,:,:,i)=faces_1(:,:,:,i);
        sample_img_hog = extractHOGFeatures(uint8(faces_2(:,:,:,i)),'CellSize',[4 4]);
        name_matched = predict(training_model,sample_img_hog);
        
        ind = find(any(student == name_matched{1}));
        student(2,ind) = "Present";
        
%         Bounding Box
        val = face_loc(i,5);
        x=face_loc(i,1);
        y=face_loc(i,2);
        w=face_loc(i,3);
        h=face_loc(i,4);
               
        if val==0
            new_face_loc=[x y w h];
        elseif val==90
            new_face_loc=[c-(y+h) x h w];
        elseif val==180
            new_face_loc=[c-(x+w) r-(y+h) w h];
        elseif val==270
            new_face_loc=[y r-(x+w) h w];
        end
%         Match Face with the name
         input_image = insertObjectAnnotation(input_image,'rectangle',new_face_loc,name_matched,'LineWidth',10,'Color','yellow','FontSize',50); 
         imshow(uint8(input_image));title('Faces Detected')
    end
end
 student
