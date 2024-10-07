import asyncio
import logging
from os import getenv

from handlers.start import start_router
from handlers.about import about_router
from handlers.getuserid import getuserid_router
from handlers.giflist import giflist_router
from handlers.privacy import privacy_router
from handlers.sendgif import sendgif_router

from aiogram import Bot, Dispatcher
from aiogram.client.default import DefaultBotProperties
from aiogram.enums import ParseMode

# Bot token can be obtained via https://t.me/BotFather
TOKEN = getenv("API_KEY")



async def main() -> None:
    # Dispatcher is a root router
    dp = Dispatcher()

    # Register all the routers from handlers package
    dp.include_routers(
        start_router,
        about_router,
        getuserid_router,
        giflist_router,
        privacy_router,
        sendgif_router
    )

    # Initialize Bot instance with default bot properties which will be passed to all API calls
    bot = Bot(token=TOKEN, default=DefaultBotProperties(
        parse_mode=ParseMode.HTML))

    # And the run events dispatching
    await dp.start_polling(bot)


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    asyncio.run(main())
