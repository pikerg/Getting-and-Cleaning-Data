# Getting-and-Cleaning-Data
Course project for the Johns Hopkins Coursera course Getting and Cleaning Data

##  Overview
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. This repository contains 1) a tidy data set "averages_data.txt" as required by the assignment that includes the average of each variable for each activity and each subject 2) a code book "CodeBook.MD" that describes the variables, the data, and any transformations or work that you performed to clean up the data 3) and this README.md describing the requirements for the run_analysis.R script to run.

***

## Set up Requirements

+ The data set must be located in the R working directory.
+ The run_analysis must be saved in the R working directory.
+ The following packages must be installed and added to the library in R:
    - "data.table"
    - "plyr"
+ File paths inside the run_analysis.R file must match the location of the data set files in the local working directory.

## Code Descriptions
+ The scope of the required assignment is narrow. Therefore the instructions are specific to the required task. The script follows good coding practices first, then satisfies the assignment requirements. Creating an initial complete set of the data, then making subsets of the data for different analysis and preserving the original data set for further analysis.
  - First, this code reads in all of the required files to build the data set.
  - Second, a complete data set is created by joining the separate files and naming the appropriate columns in the complete data set.
  - Third, a subset of the complete set is created to set up the creation of the required tidy data set
  - Fourth, the mean() function is applied to the subset to create the final processed tidy data set.

## Additional Information
+ Information about the data itself is found in the CodeBook.md
