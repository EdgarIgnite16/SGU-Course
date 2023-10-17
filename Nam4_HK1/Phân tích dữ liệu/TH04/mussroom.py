import time, os, psutil
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from mlxtend.preprocessing import TransactionEncoder 
from mlxtend.frequent_patterns import apriori, association_rules

# Chuyển file .dat thành mảng 2 chiều
dataset = np.array 
dataset = np.loadtxt("./Dataset/mussroom.dat", delimiter=None, skiprows=15)

# Chuyển đổi dữ liệu thành ma trận nhị phân
te = TransactionEncoder()
te_ary = te.fit(dataset).transform(dataset)
df = pd.DataFrame(te_ary, columns=te.columns_)

# Áp dụng thuật toán để tìm tập phổ biến
start_time = time.time() # Bắt đầu tính thời gian thuật toán chạy chạy
frequent_itemsets = apriori(df, min_support=0.6, use_colnames=True)
end_time = time.time() # Kết thúc thời điểm thuật toán dừng

# Tính thời gian chạy và thiêu thụ bộ nhớ của thuật toán
print("Thời gian thực hiện: {0}".format(end_time - start_time) + "s")
print("Bộ nhớ tiêu thụ: {0}".format(psutil.Process(os.getpid()).memory_info().rss / 1024 ** 2) + "MB") 

# In ra tập phổ biến
print(frequent_itemsets)