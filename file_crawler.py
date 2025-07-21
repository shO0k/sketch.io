import os
import random

#will eventually take in two feature profiles,
#one comes from inputted sketch and one from the file it is being compared to
#function determines how similar the profiles are and returns a float from 0.0 to 1.0
#returns the euclidean distance of two random floats in (0,1) for now
def comparison_score(sketch_profle,file_path_profile):
        return 1 - abs(sketch_profile - file_path_profile)


#will be the model that extracts features from file
#input file path
#generates random float in (0,1) for now
def get_feature_profile():
        return random.random()

#iterates through file architecture and returns a list of pairs: (filename, filename_feature_profile)
def file_iterator(start_path):
        file_profiles = []
        for dirpath, dirnames, filenames in os.walk(start_path):
                for filename in filenames:
                        full_path = os.path.join(dirpath, filename)
                        if filename.lower().endswith(('.pdf')):
                                x = get_feature_profile()
                                file_profiles.append((filename,x))

        return file_profiles

#takes in a list of pairs: (filename, filename_feature_profile) and returns a sorted list of pairs: (filename, probability_score)
def output_list(list, sketch_profile):
        result = []
        for i in list:
                result.append((i[0], comparison_score(sketch_profile,i[1])))
        result.sort(key=lambda i: i[1], reverse=True)
        return result

start_path = '/Users/johnshook/Downloads'
sketch_profile = get_feature_profile()

results = output_list(file_iterator(start_path), sketch_profile)
print(results)
print(results[0])
print(results[-1])
