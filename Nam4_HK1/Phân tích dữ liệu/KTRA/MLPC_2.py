import matplotlib.pyplot as plt
from sklearn.datasets import load_digits
from sklearn.neural_network import MLPClassifier
import pickle
import numpy as np

# Load tệp dữ liệu digits
digits = load_digits()

# Xác dinh các features và labels
X = digits.data
y = digits.target

# Load trọng số từ file
with open('model_ismax.pkl', 'rb') as file:
    model = pickle.load(file)

# Dự đoán một mẫu ngẫu nhiên từ dữ 1iệu digits
random_index = np.random.randint(0, len(X))
sample = X[random_index].reshape(1, -1)
predicted_label = model.predict (sample)

# Hiển thị ảnh của mẫu dữ liệu và kết quả dự đoán
plt.imshow(digits.images[random_index], cmap = plt.cm.gray_r, interpolation='nearest')
plt.title(f'Predicted Label: (predicted_label[0])')
plt.show()