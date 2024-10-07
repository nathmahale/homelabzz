from telegram.ext import CommandHandler, MessageHandler, Application, ContextTypes, filters
import os
import requests
from telegram import Update as upd
import glob

Token = os.environ['API_KEY']

application = Application.builder().token(Token).build()


async def start(update: upd, context: ContextTypes.DEFAULT_TYPE):
    await context.bot.send_message(chat_id=update.effective_chat.id, text="Welcome to peach-goma-api-sender")


async def help(update: upd, context: ContextTypes.DEFAULT_TYPE):
    await context.bot.send_message(chat_id=update.effective_chat.id,
                                   text='\n'.join(("/giflist -> Gifs list",
                                                   "/sendgif -> Send Gif",
                                                   "/privacy -> Privacy",
                                                   "/about -> About the application",
                                                   "/getuserid -> Get Telegram UserID")))


async def sendgif(update: upd, context: ContextTypes.DEFAULT_TYPE):
    await context.bot.send_message(chat_id=update.effective_chat.id, text="Please enter userid of the recipient")


async def giflist(update: upd, context: ContextTypes.DEFAULT_TYPE):
    for filepath in glob.glob(os.path.join(os.path.curdir, 'gifs', '*.gif')):
        gif_caption = filepath.split("/")[2].split(".")[1]
        await context.bot.send_animation(
            chat_id=update.effective_chat.id,
            animation=filepath,
            caption=gif_caption,
            width=20,
            height=20
        )


async def privacy(update: upd, context: ContextTypes.DEFAULT_TYPE):
    await context.bot.send_message(chat_id=update.effective_chat.id, text="The receipient's UserID will only be used to send GIFs and deleted after each send operation, you can check the related Python3 source code here - URL")


async def about(update: upd, context: ContextTypes.DEFAULT_TYPE):
    await context.bot.send_message(chat_id=update.effective_chat.id, text="Maintainer nathmahale, application source code - URL")


async def unknown_text(update: upd, context: ContextTypes.DEFAULT_TYPE):
    await context.bot.send_message(chat_id=update.effective_chat.id, text="Unknown text detected, please type /help to show available commands")


async def unknown(update: upd, context: ContextTypes.DEFAULT_TYPE):
    await context.bot.send_message(chat_id=update.effective_chat.id, text="Unknown command detected, please type /help to show available commands")

async def getuserid(update: upd, context: ContextTypes.DEFAULT_TYPE):
    await context.bot.send_message(chat_id=update.effective_chat.id, text= update.effective_sender.id)

# async def exit(update: upd, context: ContextTypes.DEFAULT_TYPE):
#     await context.bot.do_api_request

application.add_handler(CommandHandler('help', help))
application.add_handler(CommandHandler('start', start))
application.add_handler(CommandHandler('sendgif', sendgif))
application.add_handler(CommandHandler('giflist', giflist))
application.add_handler(CommandHandler('privacy', privacy))
application.add_handler(CommandHandler('getuserid', getuserid))
application.add_handler(CommandHandler('about', about))

application.add_handler(MessageHandler(filters.TEXT, unknown))
application.add_handler(MessageHandler(filters.COMMAND, unknown))
application.add_handler(MessageHandler(filters.TEXT, unknown_text))
# application.add_handler(CommandHandler('exit', exit))

application.run_polling()
