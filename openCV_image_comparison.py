import cv2
import numpy as np

def compare_images_openCV(file_path1, file_path2):
        #initialize ORB detector
        orb = cv2.ORB_create()

        # grayscale images
        img1 = cv2.imread(file_path1, cv2.IMREAD_GRAYSCALE)
        img2 = cv2.imread(file_path2, cv2.IMREAD_GRAYSCALE)
        #detect keypoints and compute descriptors
        keypoints1, descriptors1 = orb.detectAndCompute(img1, None)
        keypoints2, descriptors2 = orb.detectAndCompute(img2, None)

        #return 0 if either image is blank
        if descriptors1 is None or descriptors2 is None:
                return 0

        #brute force matcher with hamming distance (good for ORB)
        bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)

        #create list of matches
        matches = bf.match(descriptors1, descriptors2)

        #sorts matches, define "good" in "good match" to be a hamming distance between two bit vectors to be less than 50
        matches = sorted(matches, key=lambda x: x.distance)
        good_matches = [m for m in matches if m.distance < 50]

        # returns number of "good" matches
        return len(good_matches)

