int longestCommonSubsequence(String str1, String str2) {
  int m = str1.length;
  int n = str2.length;

  List<List<int>> dp = List.generate(
      m + 1, (i) => List<int>.filled(n + 1, 0, growable: false),
      growable: false);

  for (int i = 0; i <= m; i++) {
    for (int j = 0; j <= n; j++) {
      if (i == 0 || j == 0) {
        dp[i][j] = 0;
      } else if (str1[i - 1] == str2[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1] + 1;
      } else {
        dp[i][j] = (dp[i - 1][j] > dp[i][j - 1]) ? dp[i - 1][j] : dp[i][j - 1];
      }
    }
  }

  return dp[m][n];
}
