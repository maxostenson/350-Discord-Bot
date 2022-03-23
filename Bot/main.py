import discord
from discord.ext import commands
import asyncio
import asyncpg
import json
import datetime

from config_token import TOKEN

f = open(f"./cred.json", "r")
db_credentials = json.loads(f.read())

DEFAULT_PREFIX = '!'
ADMINS = [771443587086549012, 268415752564899841, 620001065659531307]


async def run():
    description = "A Discord database bot"

    db = await asyncpg.connect(**db_credentials)
    print("Database Connection successful")

    bot = Bot(description=description, db=db)

    @bot.command()
    async def users(ctx):
        if ctx.author.id in ADMINS:
            query = 'SELECT * FROM "User";' #" WHERE 'user.userid' = $1;"

            rows = await bot.db.fetch(query) #, ctx.author.id)
            for row in rows:
                await ctx.send(f"```userid: {row[0]}, Discord ID: {row[1]}, Discord Name: {row[2]}, Current XP: {row[3]}```")

    @bot.command()
    async def feedback(ctx):
        if ctx.author.id in ADMINS:
            query = 'SELECT * FROM "Feedback";'

            rows = await bot.db.fetch(query)
            for row in rows:
                await ctx.send(f"```{row}```")

    @bot.command()
    async def bugReport(ctx):
        query = 'SELECT count(*) FROM "BugReport";'
        rows = await bot.db.fetch(query)
        query = 'INSERT INTO "BugReport" VALUES ($1, $2, $3, $4, $5, $6, $7, $8)'
        result = await bot.db.execute(query, rows[0]['count'] + 1, ctx.message.content[11:], 0, True, False, 'Open', datetime.date.today(), ctx.author.id/1000000000)

    @bot.command()
    async def subFeed(ctx):
        query = 'SELECT count(*) FROM "Feedback";'
        rows = await bot.db.fetch(query)
        query = 'INSERT INTO "Feedback" VALUES ($1, $2, $3, $4)'
        result = await bot.db.execute(query, rows[0]['count'] + 1, ctx.message.content[9:], datetime.date.today(), ctx.author.id / 1000000000)

    @bot.command()
    async def bugreports(ctx):
        if ctx.author.id in ADMINS:
            query = 'SELECT * FROM "BugReport";'

            rows = await bot.db.fetch(query)
            for row in rows:
                await ctx.send(f"```{row}```")

    @bot.command()
    async def rewards(ctx):
        query = 'SELECT * FROM "Rewards";'

        rows = await bot.db.fetch(query)
        for row in rows:
            await ctx.send(f"```{row}```")

    @bot.command(alasis='p')
    async def points(ctx):
        query = 'SELECT * FROM "User" WHERE userid = $1;'
        row = await bot.db.fetch(query, ctx.author.id/1000000000)
        if row:
            await ctx.send(f"You have {row[0]['points']} points.")
        else:
            query = 'INSERT INTO "User" VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)'
            result = await bot.db.execute(query, ctx.author.id/1000000000, ctx.author.id/1000000000, ctx.author.name, 0, datetime.time(), 0, 1, "User", 1)
            query = 'SELECT * FROM "User" WHERE userid = $1;'
            row = await bot.db.fetch(query, ctx.author.id / 1000000000)
            await ctx.send(f"You have {row[0]['points']} points.")

    @bot.event
    async def on_message(message):
        query = 'SELECT * FROM "User" WHERE userid = $1;'
        row = await bot.db.fetch(query, message.author.id / 1000000000)
        if row:
            query = 'UPDATE "User" SET points = $1 WHERE userid = $2;'
            result = await bot.db.execute(query, row[0]['points'] + 1, message.author.id / 1000000000)
        else:
            query = 'INSERT INTO "User" VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)'
            result = await bot.db.execute(query, message.author.id / 1000000000, message.author.id / 1000000000,
                                              message.author.name, 0, datetime.time(), 0, 1, "User", 1)

        await bot.process_commands(message)

    try:
        await bot.start(TOKEN)
    except KeyboardInterrupt:
        await db.close()
        await bot.logout()


class Bot(commands.Bot):
    def __init__(self, **kwargs):
        super().__init__(
            description=kwargs.pop("description"),
            command_prefix=DEFAULT_PREFIX
        )

        self.db = kwargs.pop("db")

    async def on_ready(self):
        print("Bot Ready")
        print(f"Username: {self.user}\nID: {self.user.id}")




loop = asyncio.get_event_loop()
loop.run_until_complete(run())
