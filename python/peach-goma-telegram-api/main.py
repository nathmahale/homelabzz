from telegram.ext import Updater, CallbackContext, CommandHandler, MessageHandler
from telegram.ext.filters import Filters
import os

updater = Updater(os.environ['API_KEY'],
                  use_context=True)


def oi(update: updater, context: CallbackContext):
    update.message.reply_text(
        "Hello, Welcome to the Bot.Please write\
        /help to see the commands available.")


def help(update: updater, context: CallbackContext):
    update.message.reply_text("""Available Commands :-
    /happy - Happy mood
    /food - Food
    /rom - Different command""")


updater.dispatcher.add_handler(CommandHandler('oi', oi))
updater.dispatcher.add_handler(CommandHandler('help', help))
updater.start_polling()
