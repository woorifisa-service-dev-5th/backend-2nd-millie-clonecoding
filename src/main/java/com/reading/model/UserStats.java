package com.reading.model;

public class UserStats {
    private int challengeCount;
    private int completedBooks;
    private int readingBooks;
    private int wantToReadBooks;
    private int reviewCount;
    private double monthlyAverage;
    private int progressPercentage;
    private int target;
    private int rank;
    private double globalAverage;
    
    // 생성자
    public UserStats() {}
    
    // Getter, Setter
    public int getChallengeCount() { return challengeCount; }
    public void setChallengeCount(int challengeCount) { this.challengeCount = challengeCount; }
    
    public int getCompletedBooks() { return completedBooks; }
    public void setCompletedBooks(int completedBooks) { this.completedBooks = completedBooks; }
    
    public int getReadingBooks() { return readingBooks; }
    public void setReadingBooks(int readingBooks) { this.readingBooks = readingBooks; }
    
    public int getWantToReadBooks() { return wantToReadBooks; }
    public void setWantToReadBooks(int wantToReadBooks) { this.wantToReadBooks = wantToReadBooks; }
    
    public int getReviewCount() { return reviewCount; }
    public void setReviewCount(int reviewCount) { this.reviewCount = reviewCount; }
    
    public double getMonthlyAverage() { return monthlyAverage; }
    public void setMonthlyAverage(double monthlyAverage) { this.monthlyAverage = monthlyAverage; }
    
    public int getProgressPercentage() { return progressPercentage; }
    public void setProgressPercentage(int progressPercentage) { this.progressPercentage = progressPercentage; }
    
    public int getTarget() { return target; }
    public void setTarget(int target) { this.target = target; }
    
    public int getRank() { return rank; }
    public void setRank(int rank) { this.rank = rank; }
    
    public double getGlobalAverage() { return globalAverage; }
    public void setGlobalAverage(double globalAverage) { this.globalAverage = globalAverage; }
}