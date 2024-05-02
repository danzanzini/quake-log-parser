# frozen_string_literal: true

require_relative '../test_helper'

class EntryTest < Minitest::Test
  def setup
    @init_game_log = '0:00 InitGame: \sv_floodProtect\1\sv_maxPing\0\sv_minPing\0\sv_maxRate\10000\sv_minRate\0\sv_hostname\Code Miner Server\g_gametype\0\sv_privateClients\2\sv_maxclients\16\sv_allowDownload\0\dmflags\0\fraglimit\20\timelimit\15\g_maxGameClients\0\capturelimit\8\version\ioq3 1.36 linux-x86_64 Apr 12 2009\protocol\68\mapname\q3dm17\gamename\baseq3\g_needpass\0'
    @client_connect_log = '20:34 ClientConnect: 2'
    @client_userinfo_changed_log = '20:38 ClientUserinfoChanged: 2 n\Isgalamido\t\0\model\xian/default\hmodel\xian/default\g_redteam\\g_blueteam\\c1\4\c2\5\hc\100\w\0\l\0\tt\0\tl\0'
    @kill_log = '21:07 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT'
  end

  def test_type
    assert_equal :init_game, Entry.new(@init_game_log).type
    assert_equal :client_connect, Entry.new(@client_connect_log).type
    assert_equal :client_userinfo_changed, Entry.new(@client_userinfo_changed_log).type
    assert_equal :kill, Entry.new(@kill_log).type
  end

  def test_client_id
    assert_nil Entry.new(@init_game_log).client_id
    assert_equal 2, Entry.new(@client_connect_log).client_id
    assert_equal 2, Entry.new(@client_userinfo_changed_log).client_id
    assert_nil Entry.new(@kill_log).client_id
  end

  def test_client_name
    assert_nil Entry.new(@init_game_log).client_name
    assert_nil Entry.new(@client_connect_log).client_name
    assert_equal 'Isgalamido', Entry.new(@client_userinfo_changed_log).client_name
    assert_nil Entry.new(@kill_log).client_name
  end

  def test_kill_info
    assert_nil Entry.new(@init_game_log).kill_info
    assert_nil Entry.new(@client_connect_log).kill_info
    assert_nil Entry.new(@client_userinfo_changed_log).kill_info

    kill_info = Entry.new(@kill_log).kill_info
    assert_equal 1022, kill_info[:killer_id]
    assert_equal 2, kill_info[:killed_id]
    assert_equal 'MOD_TRIGGER_HURT', kill_info[:mod]
  end
end
