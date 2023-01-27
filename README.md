# NFL-calendar
Organizing athe NFL ligue calendar can be considered an integer linear optimization problem, where the optimal solution is determined by the expected audience profit (which depends on the chosen dates).

We want a calendar where each team plays $r$ matches against each team in their division and $s$ matches against each team in the other division. 
This is the first group of restrictions. Note that in this calendar we need more than $n-1$ days (if no team rests, and all of them play every 
match day, we will need $r(n/2-1)+sn/2$ days). The second group of restrictions must ensure that each team does not play more than one game at 
a time on a single match day.

For all calendars that satisfy the above constraints, the objective function must give preference to those where intra-divisional matches are played 
towards the last days. To achieve this we define the coefficients $c_{i,j,k}$ which indicate the preference to play the match a match day as it follows:
```math
		c_{i,j,k} = 
		\left\{
		\begin{align*}
			&0 & &\text{ if the match } (i,j) \text{ is intradivisional and } k=1\\
			&0 & &\text{ if the match } (i,j) \text{ is interdivisional }\\
			&2^{k-2} & &\text{ si el partido } (i,j) \text{ is intradivisional and } k\geq2
		\end{align*}
		\right.
```
We define as well the indicator variable of the match $(i,j)$ as follows:
```math
		x_{i,j,k} = 
		\left\{
		\begin{align*}
			&1 & &\text{ if the match } (i,j) \text{ is played in the match day } k\\
			&0 & &\text{ if the match } (i,j) \text{ is not played in the match day } k
		\end{align*}
		\right.
```
With the prior, we are ready to define our problem:
```math
		(PLe)
		\left\{
		\begin{align}
			\text{máx } z = &\sum\limits_{\substack{i,j\in \text{E}\\ i\neq j\\ k\in\text{J}}} c_{i,j,k}x_{i,j,k}\\  
			\text{s.a.}\\
			&\sum\limits_{\substack{k\in\text{J}}} x_{i,j,k} = r & &\forall(i,j) \in \text{Intradivisional matches}\\
			&\sum\limits_{\substack{k\in \text{J}}} x_{i,j,k} = s & &\forall i \in \text{Division A}, \forall j \in \text{Division B}\\
			&\sum\limits_{\substack{j\in \text{E} \\ i\neq j}} x_{i,j,k} = 1 & &\forall i\in \text{Teams},     \forall k\in\text{Match days}\\
			&x_{i,j,k}=x_{j,i,k}& &\forall i,j\in\text{Teams}, i\neq j, \forall k\in\text{Match days}
		\end{align}
		\right.
```
where:\
	$\bullet$ $n$ is the number of teams in the league.\
	$\bullet$ $r$ is the number of intradivisional matches that each team plays.\
	$\bullet$ $s$ is the number of interdivisional matches that each team plays.\
	$\bullet$ $\text{J = Match days}$ = { $1,\dots,r(n/2-1)+sn/2$}\
	$\bullet$ $\text{Division A}$ $=$ { $1,\dots,n/2$} \
	$\bullet$ $\text{Division B}$ $=$ { $n/2+1,\dots,n$}\
	$\bullet$ $\text{E = Teams}$ $=$ { $1,\dots,n$}\
	$\bullet$ $\text{Intradivisional matches}$ $=$ { $(i,j): i < j, i,j \in \ \text{Division A} $} $\cup$ { $(i,j): i < j, i,j \in \ \text{Division B} $} 
	
# Use
One must install the AMPL language and place all the archives in the same directory and run the calendari_NFL.run file.

# Authors
Erik Altelarrea-Ferré and Álvaro Ortiz Villa.
