import pandas as pd
from mlxtend.preprocessing import TransactionEncoder 
from mlxtend.frequent_patterns import apriori, association_rules

dataset = [['Bread', 'Milk', 'Eggs'], 
            ['Bread', 'Diapers','Beer', 'Eggs'],
            ['Milk', 'Diapers','Beer', 'Coke'],
            ['Bread', 'Milk','Diapers', 'Beer'],
            ['Bread', 'Milk','Diapers', 'Coke']]

# Chuyển đổi dữ liệu thành ma trận nhị phân
te = TransactionEncoder()
te_ary = te.fit(dataset).transform(dataset)
df = pd.DataFrame(te_ary, columns=te.columns_)
print(df)

# Áp dụng thuật toán để tìm tập phổ biến
frequent_itemsets = apriori(df, min_support=0.5, use_colnames=True)

# In ra tập phổ biến
print(frequent_itemsets)