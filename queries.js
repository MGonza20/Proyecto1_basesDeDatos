

const createDraftCombineQuery = `
CREATE TABLE draft_combine (
            yearCombine NUMERIC(10,0),
            idPlayer NUMERIC(10,0),
            nameFirst VARCHAR,
            nameLast VARCHAR,
            namePlayer VARCHAR
        );
`

const createDraftQuery = `
CREATE TABLE draft(
    yearDraft NUMERIC(10,0),
    numberPickOverall NUMERIC(10,0),
    numberRound NUMERIC(10,0),
    numberRoundPick NUMERIC(10,0),
    namePlayer VARCHAR,
    slugTeam VARCHAR,
    nameOrganizationFrom VARCHAR,
    typeOrganizationFrom VARCHAR,
    idPlayer NUMERIC(10,0),
    idTeam NUMERIC(10,0),
    nameTeam VARCHAR,
    cityTeam VARCHAR,
    teamName VARCHAR,
    PLAYER_PROFILE_FLAG NUMERIC(10,0),
    slugOrganizationTypeFrom VARCHAR,
    locationOrganizationFrom VARCHAR
)
`;

const createPlayerQuery = `
    CREATE TABLE player(
        id NUMERIC(10,0),
        full_name VARCHAR,
        first_name VARCHAR,
        last_name VARCHAR,
        is_active BOOLEAN
    )
`
const createPlayerBiosQuery = `
CREATE TABLE player_bios(
    namePlayerBREF VARCHAR,
    urlPlayerBioBREF VARCHAR,
    nameTable VARCHAR,
    urlPlayerImageBREF VARCHAR,
    slugPlayerBREF VARCHAR,
    numberTransactionPlayer NUMERIC(10,0)
);
`;

const createGameInactivePlayersQuery = `
CREATE TABLE game_inactive_players (
    PLAYER_ID NUMERIC(10,0),
    FIRST_NAME VARCHAR,
    LAST_NAME VARCHAR,
    JERSEY_NUM VARCHAR,
    TEAM_ID NUMERIC(10,0),
    TEAM_CITY VARCHAR,
    TEAM_NAME VARCHAR,
    TEAM_ABBREVIATION VARCHAR,
    GAME_ID NUMERIC(10,0)
)
`;
const createGameQuery = `
    CREATE TABLE game(
        GAME_ID NUMERIC(10,0),
        SEASON_ID NUMERIC(10,0),
        TEAM_ID_HOME NUMERIC(10,0),
        TEAM_ABBREVIATION_HOME VARCHAR,
        TEAM_NAME_HOME VARCHAR,
        GAME_DATE DATE,
        MATCHUP_HOME VARCHAR,
        WL_HOME VARCHAR,
        MIN_HOME VARCHAR,
        FGM_HOME NUMERIC(10,0),
        FGA_HOME NUMERIC(10,0),
        FG_PCT_HOME FLOAT,
        FG3M_HOME NUMERIC(10,0),
        FG3A_HOME NUMERIC(10,0),
        FG3_PCT_HOME FLOAT,
        FTM_HOME NUMERIC(10,0),
        FTA_HOME NUMERIC(10,0),
        FT_PCT_HOME FLOAT,
        OREB_HOME NUMERIC(10,0),
        DREB_HOME NUMERIC(10,0),
        REB_HOME NUMERIC(10,0),
        AST_HOME NUMERIC(10,0),
        STL_HOME NUMERIC(10,0),
        BLK_HOME NUMERIC(10,0),
        TOV_HOME NUMERIC(10,0),
        PF_HOME NUMERIC(10,0),
        PTS_HOME NUMERIC(10,0),
        PLUS_MINUS_HOME NUMERIC(10,0),
        TEAM_ID_AWAY NUMERIC(10,0),
        TEAM_ABBREVIATION_AWAY VARCHAR,
        TEAM_NAME_AWAY VARCHAR,
        MATCHUP_AWAY VARCHAR,
        WL_AWAY VARCHAR,
        MIN_AWAY VARCHAR,
        FGM_AWAY NUMERIC(10,0),
        FGA_AWAY NUMERIC(10,0),
        FG_PCT_AWAY FLOAT,
        FG3M_AWAY NUMERIC(10,0),
        FG3A_AWAY NUMERIC(10,0),
        FG3_PCT_AWAY FLOAT,
        FTM_AWAY NUMERIC(10,0),
        FTA_AWAY NUMERIC(10,0),
        FT_PCT_AWAY FLOAT,
        OREB_AWAY NUMERIC(10,0),
        DREB_AWAY NUMERIC(10,0),
        REB_AWAY NUMERIC(10,0),
        AST_AWAY NUMERIC(10,0),
        STL_AWAY NUMERIC(10,0),
        BLK_AWAY NUMERIC(10,0),
        TOV_AWAY NUMERIC(10,0),
        PF_AWAY NUMERIC(10,0),
        PTS_AWAY NUMERIC(10,0),
        PLUS_MINUS_AWAY NUMERIC(10,0),
        GAME_DATE_EST DATE,
        GAME_SEQUENCE VARCHAR,
        GAME_STATUS_ID NUMERIC(10,0),
        GAME_STATUS_TEXT VARCHAR,
        GAMECODE VARCHAR,
        HOME_TEAM_ID NUMERIC(10,0),
        VISITOR_TEAM_ID NUMERIC(10,0),
        SEASON NUMERIC(10,0),
        NATL_TV_BROADCASTER_ABBREVIATION VARCHAR,
        LIVE_PERIOD_TIME_BCAST VARCHAR,
        WH_STATUS VARCHAR,
        TEAM_CITY_HOME VARCHAR,
        PTS_PAINT_HOME VARCHAR,
        PTS_2ND_CHANCE_HOME VARCHAR,
        PTS_FB_HOME VARCHAR,
        LARGEST_LEAD_HOME VARCHAR,
        LEAD_CHANGES_HOME VARCHAR,
        TIMES_TIED_HOME VARCHAR,
        TEAM_TURNOVERS_HOME VARCHAR,
        TOTAL_TURNOVERS_HOME VARCHAR,
        TEAM_REBOUNDS_HOME VARCHAR,
        PTS_OFF_TO_HOME VARCHAR,
        TEAM_CITY_AWAY VARCHAR,
        PTS_PAINT_AWAY VARCHAR,
        PTS_2ND_CHANCE_AWAY VARCHAR,
        PTS_FB_AWAY VARCHAR,
        LARGEST_LEAD_AWAY VARCHAR,
        LEAD_CHANGES_AWAY VARCHAR,
        TIMES_TIED_AWAY VARCHAR,
        TEAM_TURNOVERS_AWAY VARCHAR,
        TOTAL_TURNOVERS_AWAY VARCHAR,
        TEAM_REBOUNDS_AWAY VARCHAR,
        PTS_OFF_TO_AWAY VARCHAR,
        LEAGUE_ID VARCHAR,
        GAME_DATE_DAY VARCHAR,
        ATTENDANCE VARCHAR,
        GAME_TIME TIME
    )
`;

const createGameOficialsQuery = `
        CREATE TABLE game_officials(
            OFFICIAL_ID NUMERIC(10,0),
            FIRST_NAME VARCHAR,
            LAST_NAME VARCHAR,
            JERSEY_NUM VARCHAR,
            GAME_ID NUMERIC(10,0)
        );
`;


const createPlayerSalaryQuery = `
            CREATE TABLE player_salary (
                slugSeason VARCHAR,
                nameTeam VARCHAR,
                namePlayer VARCHAR,
                statusPlayer VARCHAR,
                value NUMERIC(10,0)
            )
`;

const createTeamAttributesQuery = `
            CREATE TABLE team_attributes (
                ID NUMERIC(10,0),
                ABBREVIATION VARCHAR,
                NICKNAME VARCHAR,
                YEARFOUNDED NUMERIC(10,0),
                CITY VARCHAR,
                ARENA VARCHAR,
                ARENACAPACITY VARCHAR
            );
`;
const createTeamHistoryQuery = `
            CREATE TABLE team_history(
                ID NUMERIC(10,0),
                CITY VARCHAR,
                NICKNAME VARCHAR,
                YEARFOUNDED NUMERIC(10,0),
                YEARACTIVETILL NUMERIC(10,0)
            );
`;

const createTeamSalaryQuery = `
            CREATE TABLE team_salary(
                nameTeam VARCHAR,
                slugTeam VARCHAR,
                urlTeamSalaryHoopsHype VARCHAR,
                X2020_21 NUMERIC(10,0),
                X2021_22 NUMERIC(10,0),
                X2022_23 NUMERIC(10,0),
                X2023_24 NUMERIC(10,0),
                X2024_25 NUMERIC(10,0),
                X2025_26 NUMERIC(10,0)
            );
`;

const createTeamQuery = `
            CREATE TABLE team(
                id NUMERIC(10,0),
                full_name VARCHAR,
                abbreviation VARCHAR,
                nickname VARCHAR,
                city VARCHAR,
                state VARCHAR,
                year_founded NUMERIC(10,0)
            )
`;

module.exports = {
    createDraftCombineQuery,
    createDraftQuery,
    createPlayerBiosQuery,
    createGameQuery,
    createGameInactivePlayersQuery,
    createPlayerQuery,
    createGameOficialsQuery,
    createPlayerSalaryQuery,
    createTeamAttributesQuery,
    createTeamHistoryQuery,
    createTeamSalaryQuery,
    createTeamQuery
};