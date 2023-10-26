import time, os, psutil
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from mlxtend.preprocessing import TransactionEncoder
from mlxtend.frequent_patterns import fpgrowth, association_rules

# Chuyển file .dat thành mảng 2 chiều8
dataset = np.loadtxt("./Dataset/chess.dat", delimiter=None)

# Chuyển đổi dữ liệu thành ma trận nhị phân
te = TransactionEncoder()
te_ary = te.fit(dataset).transform(dataset)
df = pd.DataFrame(te_ary, columns=te.columns_)

# Trường hợp 1: Cố định minsup và minconf thay đổi
# minsup = 0.8
# minconf = 0.95, 0.9, 0.85, 0.8, 0.75
listMinconf = [0.95, 0.9, 0.85, 0.8, 0.75]
listTimeCost1 = [0]
listMemoCost1 = [0]
listTimeCost2 = []
listMemoCost2 = []

# Lấy tập phổ biến
start_time = time.time()  # Bắt đầu tính thời gian thuật toán sinh tập phố biến
frequent_itemsets = fpgrowth(df, min_support=0.8, use_colnames=True)
frequent_itemsets = frequent_itemsets.sort_values(by='support') # sắp xếp tập phổ biến
end_time = time.time()  # Kết thúc thời điểm thuật toán dừng

# Tính thời gian chạy và thiêu thụ bộ nhớ của thuật toán sinh tập kết hợp
timecost = end_time - start_time
memocost = psutil.Process(os.getpid()).memory_info().rss / 1024 ** 2
listMemoCost1.append(memocost)
listTimeCost1.append(timecost)
print("Với minsup= 0.8")
print("Thời gian thực hiện sinh tập kết hợp: {0}".format(timecost) + "s")
print("Bộ nhớ tiêu thụ  sinh tập kết hợp: {0}".format(memocost) + "MB")
print(frequent_itemsets) # In ra tập phổ biến

for val in listMinconf:
    print("")
    # Áp dụng thuật toán để tìm tập phổ biến
    start_time = time.time()  # Bắt đầu tính thời gian thuật toán sinh luật kết hợp
    rules = association_rules(frequent_itemsets, metric="confidence", min_threshold=val)
    end_time = time.time()  # Kết thúc thời điểm thuật toán dừng

    # Tính thời gian chạy và thiêu thụ bộ nhớ của thuật toán sinh luật kết hợp
    timecost = end_time - start_time
    memocost = psutil.Process(os.getpid()).memory_info().rss / 1024 ** 2
    listMemoCost2.append(memocost)
    listTimeCost2.append(timecost)
    print("Giá trị luật kết hợp: minconf = " + str(val))
    print("Thời gian thực hiện: {0}".format(timecost) + "s")
    print("Bộ nhớ tiêu thụ: {0}".format(memocost) + "MB")

    # In ra luật kết hợp
    print(rules)
    print("==========================================================")



# Vẽ đồ thị
plt.style.available
plt.style.use('seaborn-v0_8-whitegrid')
plt.plot(listTimeCost1, listMemoCost1, color='red', label='Thời gian và bộ nhớ tiêu thụ của thuật toán sinh tập phổ biến')
plt.plot(listTimeCost2, listMemoCost2, color='orange', label='Thời gian và bộ nhớ tiêu thụ của thuật toán sinh luật kết hợp')
plt.xlabel('Thời gian thực hiện (second)')
plt.ylabel('Bộ nhớ tiêu tốn (MB)')
plt.title('Thời gian thực hiện và bộ nhớ tiêu tốn')
plt.legend()
plt.show()
