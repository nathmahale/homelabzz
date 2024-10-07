from aiogram import Router
from aiogram.filters import CommandStart
from aiogram.types import Message, InlineKeyboardButton, InlineKeyboardMarkup, CallbackQuery


start_router = Router()


@start_router.message(CommandStart())
async def command_start_handler(message: Message) -> None:
    """
    This handler receives messages with `/start` command
    """

    await message.answer(text='\n'.join(("/giflist -> Gifs list",
                                         "/sendgif -> Send Gif",
                                         "/privacy -> Privacy",
                                         "/about -> About the application",
                                         "/getuserid -> Get Telegram UserID")))
