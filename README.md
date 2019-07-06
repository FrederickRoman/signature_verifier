# signature_verifier
Accompanying code for signature verifier paper https://drive.google.com/open?id=1Wwn6fvrIwcTcaHXqtMNBB-nsAil3S00q

## A few notes

Handwriting is an important form of personal
authentication and authorization, and is used to certify
important documents, including but not limited to:
passports, visas, paychecks, etc. 

Therefore, this computer tool was developed to learn a
personís signature from sample pictures, and then classify
future examples as either authentic or forged.

## Prerequisites
- MATLAB Version 7.10.0.499 (R2010a)  (Though any version from 2010 onwards will probably work)
- SVM light Version: 6.02 

## Instructions to run the code:

1) Open in Matlab and navigate to parent folder of this document
2) Include the entire project in the path 
	- Right click on Signature_Verification_Project -> Add to path -> Selected Folders and Subfolders
3) Open the Util folder
4) Drag svm_classify.exe and svm_learn.exe to the Util folder
5) All you need to do to run the code is to open one of the "Main" script and press the run button.
    - Main_SVM.m - runs linear hard SVM with the best model found
    - Main_knn_neighbor.m - runs knn using nearest neighbor for classification
    - Main_knn_centroid.m - runs knn using centroid for classification
(Optional) If you want to change the feature space from the default (pHash) to percetual Hash (average hash)
              comment line 47 (the pHash line) and
              uncomment line 46 (the perceptual hash line)
           If later on you want to reverse this all you need to is to comment 46 and uncomment 47.

## Results:
![Heat Map]("./DFFT heat map.JPG")
![Heat Map]("./DFFT heat map.JPG")
![Heat Map]("./DFFT heat map.JPG")
![Heat Map]("./DFFT heat map.JPG")
