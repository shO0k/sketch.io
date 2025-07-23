import os
import random
import CLIP

#iterates through file architecture and returns a list of pairs: (filename, comparison score)
def file_iterator(sketch_path, start_path):
        file_profiles = []
        # iterate through file hieracrcy
        for dirpath, dirnames, filenames in os.walk(start_path):
                for filename in filenames:
                        full_path = os.path.join(dirpath, filename)
                        # compare only to specific file types
                        if filename.lower().endswith(('.png', '.jpg', '.jpeg')):
                                #compute similarity score from CLIP.py
                                # eventually replace CLIP_cosine_similarity with a hybrid similarity score
                                similarity_score = CLIP.CLIP_cosine_similarity(sketch_path, full_path)
                                file_profiles.append((filename, similarity_score))
        # sort pairs from highest to lowest similarity score
        file_profiles.sort(key=lambda i: i[1], reverse=True)
        return file_profiles
