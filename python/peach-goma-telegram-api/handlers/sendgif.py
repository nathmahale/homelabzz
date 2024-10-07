from aiogram import Router
from aiogram.filters import Command
from aiogram.types import Message

sendgif_router = Router()


@sendgif_router.message(Command("sendgif"))
async def command_sendgif_handler(message: Message) -> None:
    """
    This handler receives messages with `/sendgif` command
    """
    # Most event objects have aliases for API methods that can be called in events' context
    # For example if you want to answer to incoming message you can use `message.answer(...)` alias
    # and the target chat will be passed to :ref:`aiogram.methods.send_message.SendMessage`
    # method automatically or call API method directly via
    # Bot instance: `bot.send_message(chat_id=message.chat.id, ...)`
    await message.answer("Please enter userid of the recipient")