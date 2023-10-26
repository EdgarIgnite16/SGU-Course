import time, os, psutil
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from mlxtend.preprocessing import TransactionEncoder
from mlxtend.frequent_patterns import apriori, association_rules

# Chuyển file .dat thành mảng 2 chiều8
dataset = np.loadtxt("./Dataset/chess.dat", delimiter=None)

# Chuyển đổi dữ liệu thành ma trận nhị phân
te = TransactionEncoder()
te_ary = te.fit(dataset).transform(dataset)
df = pd.DataFrame(te_ary, columns=te.columns_)

# Trường hợp 1: Cố định minconf và minsup thay đổi
# minconf = 0.75
# minssup = 0.9, 0.85, 0.8, 0.75, 0.7
listMinsup = [0.9, 0.85, 0.8, 0.75, 0.7]
listTimeCost1 = [0]
listMemoCost1 = [0]
listTimeCost2 = []
listMemoCost2 = []

for val in listMinsup:
    print("")
    # Áp dụng thuật toán để tìm tập phổ biến
    start_time = time.time()  # Bắt đầu tính thời gian thuật toán tập phổ biến
    frequent_itemsets = apriori(df, min_support=val, use_colnames=True)
    frequent_itemsets = frequent_itemsets.sort_values(by='support') # sắp xếp tập phổ biến
    end_time = time.time()  # Kết thúc thời điểm thuật toán dừng

    # Tính thời gian chạy và thiêu thụ bộ nhớ của thuật toán sinh luật kết hợp
    timecost = end_time - start_time
    memocost = psutil.Process(os.getpid()).memory_info().rss / 1024 ** 2
    listMemoCost1.append(memocost)   
    listTimeCost1.append(timecost)
    print("Giá trị tập phổ biết: minsup = " + str(val))
    print("Thời gian thực hiện: {0}".format(timecost) + "s")
    print("Bộ nhớ tiêu thụ: {0}".format(memocost) + "MB")

    # In ra tập phổ biến
    print(frequent_itemsets)

    # ============================================================== #
    # Tính luật kết hợp
    start_time = time.time()  # Bắt đầu tính thời gian thuật toán sinh luật kết hợp
    rules = association_rules(frequent_itemsets, metric="confidence", min_threshold=0.75)
    end_time = time.time()  # Kết thúc thời điểm thuật toán dừng

    # Tính thời gian chạy và thiêu thụ bộ nhớ của thuật toán sinh tập kết hợp
    timecost = end_time - start_time
    memocost = psutil.Process(os.getpid()).memory_info().rss / 1024 ** 2
    listMemoCost2.append(memocost)
    listTimeCost2.append(timecost)
    print("Với minconf= 0.75")
    print("Thời gian thực hiện sinh luật kết hợp: {0}".format(timecost) + "s")
    print("Bộ nhớ tiêu thụ  sinh luật kết hợp: {0}".format(memocost) + "MB")
    print(frequent_itemsets) # In ra tập phổ biến
    print("==========================================================")


# Vẽ đồ thị
plt.style.available
plt.style.use('seaborn-v0_8-whitegrid')
plt.plot(listTimeCost1, listMemoCost1, color='blue', label='Thời gian và bộ nhớ tiêu thụ của thuật toán sinh tập phổ biến')
plt.plot(listTimeCost2, listMemoCost2, color='orange', label='Thời gian và bộ nhớ tiêu thụ của thuật toán sinh luật kết hợp')
plt.xlabel('Thời gian thực hiện (second)')
plt.ylabel('Bộ nhớ tiêu tốn (MB)')
plt.title('Thời gian thực hiện và bộ nhớ tiêu tốn')
plt.legend()
plt.show()
