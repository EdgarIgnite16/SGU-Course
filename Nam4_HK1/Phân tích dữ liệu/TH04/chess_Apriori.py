import time, os, psutil
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from mlxtend.preprocessing import TransactionEncoder
from mlxtend.frequent_patterns import apriori

# Chuyển file .dat thành mảng 2 chiều
dataset = np.array
dataset = np.loadtxt("./Dataset/chess.dat", delimiter=None)

# Chuyển đổi dữ liệu thành ma trận nhị phân
te = TransactionEncoder()
te_ary = te.fit(dataset).transform(dataset)
df = pd.DataFrame(te_ary, columns=te.columns_)

listMinsup = [0.9, 0.8, 0.7, 0.6, 0.55]
listTimeCost = []
listMemoCost = []

for val in listMinsup:
    # Áp dụng thuật toán để tìm tập phổ biến
    start_time = time.time()  # Bắt đầu tính thời gian thuật toán chạy chạy
    frequent_itemsets = apriori(df, min_support=val, use_colnames=True)
    end_time = time.time()  # Kết thúc thời điểm thuật toán dừng

    # Tính thời gian chạy và thiêu thụ bộ nhớ của thuật toán
    timecost = end_time - start_time
    memocost = psutil.Process(os.getpid()).memory_info().rss / 1024 ** 2
    listMemoCost.append(memocost)
    listTimeCost.append(timecost)
    print("Thời gian thực hiện: {0}".format(timecost) + "s")
    print("Bộ nhớ tiêu thụ: {0}".format(memocost) + "MB")

    # In ra tập phổ biến
    print(frequent_itemsets)

print(listTimeCost)
print(listMemoCost)

# Vẽ đồ thị
plt.plot(listTimeCost, listMemoCost, color='red', label='Thời gian và bộ nhớ tiêu thụ')
plt.xlabel('Thời gian thực hiện (second)')
plt.ylabel('Bộ nhớ tiêu tốn (MB)')
plt.title('Thời gian thực hiện và bộ nhớ tiêu tốn')
plt.legend()
plt.show()
