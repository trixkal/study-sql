/*You are given two tables team and matches, with the following structures:

create table teams (
	team_id integer not null,
	team_name varchar(30) not null,
	unique(team_id)
);

create table matches (
	match_id integer not null,
	host_team integer not null,
	guest_team integer not null,
	host_goals integer not null,
	guest_goals integer not null,
	(unique match_id)
);


Points have been scored in the worldcup with the following rules:

Wins: 3 points
Draw: 1 point 
Lost: 0 points

Who won?
*/


select worldcup.teams.*, SUM(sum_points) as Winner
from worldcup.teams left join 
    (select host_team, SUM(hostpoint) as sum_points 
     from (select host_team,
				  (case when host_goals>guest_goals then 3 when host_goals=guest_goals then 1 else 0 end) as hostpoint
           from worldcup.matches
           union
           select guest_team,
                  (case when host_goals>guest_goals then 0 when host_goals=guest_goals then 1 else 3 end) as guestpoint
           from worldcup.matches) point 
     group by host_team) points 
on teams.team_id=points.host_team
order by points.sum_points desc,teams.team_id asc;





/* INITIAL TEST DATA
insert into worldcup.teams (team_id, team_name) values (1,"Juventus");
insert into worldcup.teams (team_id, team_name) values (2,"Bayer");
insert into worldcup.teams (team_id, team_name) values (3,"Liverpool");
insert into worldcup.teams (team_id, team_name) values (4,"Barca");

insert into worldcup.matches (match_id, host_team, guest_team, host_goals, guest_goals) values (1, 1, 2, 1, 0);
insert into worldcup.matches (match_id, host_team, guest_team, host_goals, guest_goals) values (2, 3, 4, 2, 3);
insert into worldcup.matches (match_id, host_team, guest_team, host_goals, guest_goals) values (3, 1, 4, 3, 0);
insert into worldcup.matches (match_id, host_team, guest_team, host_goals, guest_goals) values (4, 1, 4, 3, 0);
*/