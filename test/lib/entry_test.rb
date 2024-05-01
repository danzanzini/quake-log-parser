# frozen_string_literal: true

require_relative '../test_helper'

class EntryTest < Minitest::Test
  def test_it_gets_the_kill_type_from_log
    entry = Entry.new('21:07 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT')
    assert entry.type == :kill
  end

  def test_it_gets_the_client_begin_type_from_log
    entry = Entry.new('20:38 ClientBegin: 2')
    assert entry.type == :client_begin
  end

  def test_it_gets_the_client_connect_type_from_log
    entry = Entry.new('21:15 ClientConnect: 2')
    assert entry.type == :client_connect
  end

  def test_it_gets_the_client_user_info_changed_type_from_log
    entry = Entry.new('21:15 ClientUserinfoChanged: 2 n\Isgalamido\t\0\model\uriel/zael\hmodel\uriel/zael\g_redteam\\g_blueteam\\c1\5\c2\5\hc\100\w\0\l\0\tt\0\tl\0')
    assert entry.type == :client_userinfo_changed
  end

  def test_it_gets_the_init_game_type_from_log
    entry = Entry.new('20:37 InitGame: \sv_floodProtect\1\sv_maxPing\0\sv_minPing\0\sv_maxRate\10000\sv_minRate\0\sv_hostname\Code Miner Server\g_gametype\0\sv_privateClients\2\sv_maxclients\16\sv_allowDownload\0\bot_minplayers\0\dmflags\0\fraglimit\20\timelimit\15\g_maxGameClients\0\capturelimit\8\version\ioq3 1.36 linux-x86_64 Apr 12 2009\protocol\68\mapname\q3dm17\gamename\baseq3\g_needpass\0')
    assert entry.type == :init_game
  end

  # TODO: Improve client_id tests to ensure them for all types
  def test_it_returns_the_client_id_when_appropriate
    entry = Entry.new('21:15 ClientUserinfoChanged: 2 n\Isgalamido\t\0\model\uriel/zael\hmodel\uriel/zael\g_redteam\\g_blueteam\\c1\5\c2\5\hc\100\w\0\l\0\tt\0\tl\0')
    assert entry.client_id == 2
  end

  def test_it_returns_nil_for_client_id_when_appropriate
    entry = Entry.new('21:07 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT')
    assert entry.client_id.nil?
  end

  def test_it_gets_the_client_name
    entry = Entry.new('21:15 ClientUserinfoChanged: 2 n\Isgalamido\t\0\model\uriel/zael\hmodel\uriel/zael\g_redteam')
    assert entry.client_name == 'Isgalamido'

    entry = Entry.new('21:15 ClientUserinfoChanged: 2 n\Dono da Bola\t\0\model\uriel/zael\hmodel\uriel/zael\g_redteam')
    assert entry.client_name == 'Dono da Bola'
  end

  def test_it_gets_the_kill_info
    entry = Entry.new(' 10:38 Kill: 5 7 6: Oootsimo killed Assasinu Credi by MOD_ROCKET')
    assert entry.kill_info == { killer_id: 5, killed_id: 7, mod_id: 6 }
  end
end
