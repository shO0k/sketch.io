import torch
import clip
from PIL import Image

def CLIP_cosine_similarity(img1, img2):
        #run on CPU if GPU is unavailable
        device = "cuda" if torch.cuda.is_available() else "cpu"
        model, preprocess = clip.load("ViT-B/32", device=device)
  
        img1_use = preprocess(Image.open(img1)).unsqueeze(0).to(device)
        img2_use = preprocess(Image.open(img2)).unsqueeze(0).to(device)

        with torch.no_grad():
                features1 = model.encode_image(img1_use)
                features2 = model.encode_image(img2_use)

        features1 /= features1.norm(dim=-1, keepdim=True)
        features2 /= features2.norm(dim=-1, keepdim=True)

        similarity = (features1 @ features2.T).item()
        return similarity
  
