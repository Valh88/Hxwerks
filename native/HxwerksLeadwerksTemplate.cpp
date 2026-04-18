/**
 * Shared implementation of the default Leadwerks game template loop (used from `main_stock.cpp`).
 */
#include "Leadwerks.h"
#include "Encryption.h"
#include "ComponentSystem.h"
#include "CustomEvents.h"
#include "Game/Game.h"
#include "Game/GameMenu.h"
#include "../cinclude/HxwerksLeadwerksTemplate.h"

//#include "Steamworks/Steamworks.h"

using namespace Leadwerks;

namespace
{
std::vector<std::shared_ptr<Package>> g_packages;
std::shared_ptr<GameMenu> g_mainmenu;
bool g_exit_requested = false;
} // namespace

extern "C" int hxwerks_leadwerks_template_init(void)
{
	g_exit_requested = false;
	g_packages.clear();
	g_mainmenu.reset();

	if (not Game::Initialize())
		return 1;

	auto dir = LoadDir("");
	String password;
	GetPassword(password);
	for (auto file : dir)
	{
		if (ExtractExt(file).Lower() == "zip")
		{
			auto pak = LoadPackage(file);
			if (pak)
			{
				if (not password.empty())
				{
					pak->SetPassword(password);
					pak->Restrict();
				}
				g_packages.push_back(pak);
			}
		}
	}
	password.Clear();

	RegisterComponents();

	g_mainmenu = CreateGameMenu();
	if (not g_mainmenu)
		return 1;

	g_mainmenu->AddPostEffect("Bloom", "Effects/Bloom.fx", true);
	g_mainmenu->AddPostEffect("SSAO", "Effects/SSAO.fx");
	g_mainmenu->AddPostEffect("Auto-exposure", "Effects/AutoExposure.fx");
	g_mainmenu->AddPostEffect("Volumetric Lighting", "Effects/VolumetricLighting.fx");

	if (Game::commandline["map"].is_string())
	{
		String mapname = Game::commandline["map"];
		Game::scene = LoadMap(Game::world, mapname);
		if (Game::scene)
		{
			g_mainmenu->ApplyCameraSettings();
			g_mainmenu->SetHidden(true);
			Game::window->SetCursor(CURSOR_NONE);
			g_mainmenu->newgamebutton->SetText("Resume Game");
		}
	}

	return 0;
}

extern "C" int hxwerks_leadwerks_template_frame(void)
{
	if (g_exit_requested)
		return 1;
	if (not Game::world || not g_mainmenu)
		return 1;

	Game::world->Update();
	bool vsync = true;
	if (Game::settings["video"]["vsync"].is_boolean() and Game::settings["video"]["vsync"] == false)
		vsync = false;
	Game::world->Render(Game::framebuffer, vsync);

	while (PeekEvent())
	{
		auto event = WaitEvent();

		if (event.id == EVENT_CHANGELEVEL)
		{
			WString mapfile = "Maps/start.map";
			if (not event.text.empty())
				mapfile = event.text;
			Game::scene = LoadScene(Game::world, mapfile);
			if (Game::scene)
			{
				g_mainmenu->ApplyCameraSettings();
				g_mainmenu->SetHidden(true);
				g_mainmenu->newgamebutton->SetText("Resume Game");
				Game::world->Resume();
				Game::window->FlushKeys();
				Game::window->FlushMouse();
				Game::window->SetCursor(CURSOR_NONE);
			}
			else
			{
				g_mainmenu->SetHidden(false);
				Game::window->SetCursor(CURSOR_DEFAULT);
			}
		}
		else if (event.id == EVENT_QUIT)
		{
			g_exit_requested = true;
			return 1;
		}
		else if (event.id == EVENT_WINDOWCLOSE && event.source == Game::window)
		{
			g_exit_requested = true;
			return 1;
		}
		else if (event.id == EVENT_WORLDPAUSE)
		{
			Game::window->SetCursor(CURSOR_DEFAULT);
		}
		else if (event.id == EVENT_WORLDRESUME)
		{
			Game::window->SetCursor(CURSOR_NONE);
			Game::window->FlushKeys();
			Game::window->FlushMouse();
		}
		else if (event.id == EVENT_STARTRENDERER)
		{
			if (event.data == 1)
			{
				Print(event.text);
				Game::window->SetHidden(false);
				Game::window->Activate();
			}
			else
			{
				Print("Error: Failed to initialize renderer");
				Print(event.text);
				g_exit_requested = true;
				return 1;
			}
		}
	}

#ifdef STEAM_API_H
	Steamworks::Update();
#endif

	return 0;
}

