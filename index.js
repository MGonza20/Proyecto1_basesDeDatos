// Libraries
const fs = require('fs');
const path = require('path');

const csv = require('fast-csv');
const colors = require('colors');
const { Pool } = require('pg');
const { createDraftCombineQuery, createDraftQuery, createPlayerQuery, createPlayerBiosQuery, createGameInactivePlayersQuery, createGameQuery, createGameOficialsQuery, createNewsQuery, createPlayerAttributesQuery, createTeamAttributesQuery, createTeamHistoryQuery, createTeamSalaryQuery, createTeamQuery, createPlayerSalaryQuery } = require('./queries');
// Constants
const credentials = {
    user: 'postgres',
    host: 'localhost',
    database: 'proyecto01',
    password: '2302',
    port: 5432
}

const columns_used = {
    player: ['GAME_ID',
        'SEASON_ID',
        'TEAM_ID_HOME',
        'TEAM_ABBREVIATION_HOME',
        'TEAM_NAME_HOME',
        'GAME_DATE',
        'MATCHUP_HOME',
        'WL_HOME',
        'MIN_HOME',
        'FGM_HOME',
        'FGA_HOME',
        'FG_PCT_HOME',
        'FG3M_HOME',
        'FG3A_HOME',
        'FG3_PCT_HOME',
        'FTM_HOME',
        'FTA_HOME',
        'FT_PCT_HOME',
        'OREB_HOME',
        'DREB_HOME',
        'REB_HOME',
        'AST_HOME',
        'STL_HOME',
        'BLK_HOME',
        'TOV_HOME',
        'PF_HOME',
        'PTS_HOME',
        'PLUS_MINUS_HOME',
        'TEAM_ID_AWAY',
        'TEAM_ABBREVIATION_AWAY',
        'TEAM_NAME_AWAY',
        'MATCHUP_AWAY',
        'WL_AWAY',
        'MIN_AWAY',
        'FGM_AWAY',
        'FGA_AWAY',
        'FG_PCT_AWAY',
        'FG3M_AWAY',
        'FG3A_AWAY',
        'FG3_PCT_AWAY',
        'FTM_AWAY',
        'FTA_AWAY',
        'FT_PCT_AWAY',
        'OREB_AWAY',
        'DREB_AWAY',
        'REB_AWAY',
        'AST_AWAY',
        'STL_AWAY',
        'BLK_AWAY',
        'TOV_AWAY',
        'PF_AWAY',
        'PTS_AWAY',
        'PLUS_MINUS_AWAY',
        'GAME_DATE_EST',
        'GAME_SEQUENCE',
        'GAME_STATUS_ID',
        'GAME_STATUS_TEXT',
        'GAMECODE',
        'HOME_TEAM_ID',
        'VISITOR_TEAM_ID',
        'SEASON',
        'NATL_TV_BROADCASTER_ABBREVIATION',
        'LIVE_PERIOD_TIME_BCAST',
        'WH_STATUS',
        'TEAM_CITY_HOME',
        'PTS_PAINT_HOME',
        'PTS_2ND_CHANCE_HOME',
        'PTS_FB_HOME',
        'LARGEST_LEAD_HOME',
        'LEAD_CHANGES_HOME',
        'TIMES_TIED_HOME',
        'TEAM_TURNOVERS_HOME',
        'TOTAL_TURNOVERS_HOME',
        'TEAM_REBOUNDS_HOME',
        'PTS_OFF_TO_HOME',
        'TEAM_CITY_AWAY',
        'PTS_PAINT_AWAY',
        'PTS_2ND_CHANCE_AWAY',
        'PTS_FB_AWAY',
        'LARGEST_LEAD_AWAY',
        'LEAD_CHANGES_AWAY',
        'TIMES_TIED_AWAY',
        'TEAM_TURNOVERS_AWAY',
        'TOTAL_TURNOVERS_AWAY',
        'TEAM_REBOUNDS_AWAY',
        'PTS_OFF_TO_AWAY',
        'LEAGUE_ID',
        'GAME_DATE_DAY',
        'ATTENDANCE',
        'GAME_TIME'],
    player_bios: [
        'namePlayerBREF',
        'urlPlayerBioBREF',
        'nameTable',
        'urlPlayerImageBREF',
        'slugPlayerBREF',
        'numberTransactionPlayer'
    ]
}

// Function to read a csv file

/**
 * Reads a CSV file
 * @param {string} fileName Name of file to read
 * @param {string} tableName Name of the table to insert the data
 */
const crateTableFromFile = (fileName, tableName) => {
    const parsedData = [];
    fs.createReadStream(path.resolve(__dirname, 'files', `${fileName}.csv`))
        .pipe(csv.parse({ headers: true }))
        .on('error', error => console.log(error))
        .on('data', async (row) => {
            parsedData.push(row);
        })
        .on('end', async (count) => {
            for (const row of parsedData) {
                const pool = new Pool(credentials);
                const cols = Object.keys(row).map(col => col.replace(" ", "_")).join(',');
                const values = Object.values(row)
                    .map(val => `'${val.replace(/'/g, "''")}'`);
                if (columns_used[]) {
                    numberTransactionPlayer
                }
                console.log(`INSERT INTO ${tableName}(${columns_used[tableName] || cols}) VALUES(
                        ${values.join(",")}
                    )`);
                await pool.query(`
                    INSERT INTO ${tableName}(${columns_used[tableName] || cols}) VALUES(
                        ${values.join(",")}                    
                    )
                `);
                pool.end();
            }
            console.log(`Inserted a total of ${count} rows into ${tableName}`.blue);
        });

}

// Functions to create the tables

const createTable = async (query) => {
    try {
        const pool = new Pool(credentials);
        await pool.query(query);
        pool.end();
        console.log(`Created table`.blue);

    } catch (error) {
        console.log(`Error Creating: `.red, error);
    }

}



// Insert Into Tables

(async () => {
    // Create Tables
    // await createTable(createDraftCombineQuery);
    // crateTableFromFile('Draft_Combine', 'draft_combine');

    // await createTable(createDraftQuery);
    // crateTableFromFile('Draft', 'draft');

    // await createTable(createPlayerQuery);
    // crateTableFromFile('Player', 'player');

    await createTable(createPlayerBiosQuery);
    crateTableFromFile('Player_Bios', 'player_bios');


    // await createTable(createGameInactivePlayersQuery);
    // crateTableFromFile('Game_Inactive_Players', 'game_inactive_players');


    // await createTable(createGameQuery);
    // crateTableFromFile('Game', 'game');

    // await createTable(createGameOficialsQuery);
    // crateTableFromFile('Game_Officials', 'game_officials');

    // await createTable(createPlayerAttributesQuery);
    // crateTableFromFile('Player_Attributes', 'player_attributes');

    // await createTable(createPlayerSalaryQuery);
    // crateTableFromFile('Player_Salary', 'player_salary');

    // await createTable(createTeamAttributesQuery);
    // crateTableFromFile('Team_Attributes', 'team_attributes');

    // await createTable(createTeamHistoryQuery);
    // crateTableFromFile('Team_History', 'team_history');

    // await createTable(createTeamSalaryQuery);
    // crateTableFromFile('Team_Salary', 'team_salary');

    // await createTable(createTeamQuery);
    // crateTableFromFile('Team', 'team');



})();


