# task 3
# import libraries
import statistics
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# sample dataset
datasetX = [2, 5, 3, 6, 33]

# mean by statistics lib
meanX = statistics.mean(datasetX)
print(meanX)

# mean by numpy lib
meanXnp = np.mean(datasetX)
print(np.mean(datasetX))

# median by statistics lib
medianX = statistics.median(datasetX)
print(medianX)

# median by np lib
medianXnp = np.median(datasetX)
print(medianXnp)

# standard deviation by statistics lib
stdevX = statistics.stdev(datasetX)
print(stdevX)

# standard deviation by np lib
stdXnp = np.std(datasetX)
print(stdXnp)

# pd series
numseries = pd.Series(datasetX)

# EDA
# import csv
players = pd.read_csv(r'players.csv')

# describing the data
print(players.describe())
print(players['salary'].describe())

# variance
print(players['salary'].var())

# correlation
col1 = players['salary']
col2 = players['rating']
correlation = col1.corr(col2)
print(correlation)
print(players.corr())
print(players.corr(method = 'pearson'))
print(players.corr(method = 'spearman'))

# non-numerical
print(players['teams'].value_counts())
print(players['teams'].describe())

# visualization
# boxplot
boxplot = players.boxplot(column = ['salary'])
print(players['salary'].describe())
boxplot1 = players.boxplot()

# boxplot by matplotlib lib
x = players['salary']
fig, ax = plt.subplots()
ax.boxplot(x, showmeans = True, meanline = True, medianprops = {'linewidth': 5, 'color': 'purple'})
plt.show()

# correlation
print(players.corr(method = 'pearson'))
ax = players.plot.scatter(x = 'salary', y = 'rating', color = 'DarkBlue', label = 'Player Salary vs Rating')

# bar graph
ratingcount = players['rating'].value_counts()
print(ratingcount)
ratingcount.plot.bar()
plt.xlabel('rating')
plt.ylabel('number of instances')

# barh graph
ratingcount = players['rating'].value_counts()
print(ratingcount)
ratingcount.plot.barh()
plt.xlabel('rating')
plt.ylabel('number of instances')

# pie chart
players.groupby('teams').size().plot(kind = 'pie')
plt.title('Team representation')
plt.ylabel(' ')

# statistical analysis
listings = pd.read_csv(r'listings.csv')

# describe price column
print(listings['price'].describe())

# boxplot
listings.boxplot(column = ['price'])

# correlations
print(listings[['minimum_nights', 'number_of_reviews', 'reviews_per_month']].corrwith(listings['price']))
print(listings[['number_of_reviews', 'price', 'reviews_per_month']].corrwith(listings['minimum_nights']))

# breakdown by group
# pie chart
print(listings['room_type'].describe())
listings.groupby('room_type').size().plot(kind = 'pie', autopct = '%1.0f%%')
plt.tile('Room type')

# scatter plot
# plot longitude and latitude
listings.plot.scatter(x = 'longitude', y = 'latitude', alpha = 0.1, label = 'AirBnB Amsterdam')
