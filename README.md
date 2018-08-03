# Data Analyst Projects

This repo contains some of the Data Analytics projects I have worked to learn what does it means to be a data analyst and have a path towards data science.

## Getting Started

All the projects use the **environment.yml** file in this repository. This environment has more packages that you probably need, but it is an environment with packages used also in machine learning and self-driving car applications such as TensorFlow, Scikit-learn, and OpenCV3. 

To install the environment first you need to download the file to your computer or get all this repository. Then, with the command line go to the repository folder or the folder in which the **environment.yml** lives. Finally, you can run the following command on the terminal:

```
conda env create -f environment.yml
```

Once you have run that you will create the environment named **datasci**. To start using your environment simply type on the command line:

```
source activate datasci
```

At this point you are ready to open all the notebooks using the command line to call jupyter notebook to open any project. Do this with the following comand:

```
jupyter notebook [Notebook_Name.ipynb]
```

After that command a tab in your browser will pop up with all the notebook on it.

> **NOTE:** If you do not want to use conda and only look at the project, you can check them out using the html or pdf files of each notebook. Otherwise, you can explore them in github by going to the project's jupyter notebook.

## Projects' Index

>**Recommendations:** 
Check the **European Soccer** notebook (uses a SQLite DB, Pandas, 2D and 3D plots)
For hypothesis testing review the **Stroop Effect** notebook, it has a simple explanation on how to do Boostrapping and t-test one-tail
If you want to brush up basic SQL queries, check the **SQL Appendix**

1. [Temperature Trends per Year](./TemperatureTrends/Temperature_Trends.ipynb)
2. [Bike Sharing](./BikeSharing/Bike_Share_Analysis.ipynb)
3. **[European Soccer](./SoccerTeamsAnalysis/European_Soccer.ipynb)**
4. [AB Test for a Web Page Release](./ABTest/AB_test.ipynb)
5. **[Stroop Effect](./StroopEffect/Stroop_Effect_Perceptual_Phenomenon.ipynb)**
6. [Red Wine Quality Analysis](./RedWine/RedWine.Rmd)

## Appendix

1. [Basic SQL queries and examples](./SQL_Appendix)
2. [R basics examples' index](./Rbasics_Appendix/README.md)
3. [Wikipedia Web Crawler (python scripts - Comming Soon)](./WebCrawler)


