# encoding: utf-8

require File.expand_path('../../test_helper', __FILE__)

class LocaleTest < Test::Unit::TestCase
  test "SingleTableGlobalize3 has locale accessors" do
    assert SingleTableGlobalize3.respond_to?(:locale)
    assert SingleTableGlobalize3.respond_to?(:locale=)
  end

  test "SingleTableGlobalize3.locale reader can be called before a locale was set" do
    SingleTableGlobalize3.locale = nil
    assert_nothing_raised { SingleTableGlobalize3.locale }
  end

  test 'SingleTableGlobalize3 locale setting' do
    assert_equal :en, I18n.locale
    assert_equal :en, SingleTableGlobalize3.locale

    I18n.locale = :de
    assert_equal :de, I18n.locale
    assert_equal :de, SingleTableGlobalize3.locale

    SingleTableGlobalize3.locale = :es
    assert_equal :de, I18n.locale
    assert_equal :es, SingleTableGlobalize3.locale

    I18n.locale = :fr
    assert_equal :fr, I18n.locale
    assert_equal :es, SingleTableGlobalize3.locale
  end

  test "SingleTableGlobalize3 locale setting with strings" do
    I18n.locale = 'de'
    SingleTableGlobalize3.locale = 'de'
    assert_equal I18n.locale, SingleTableGlobalize3.locale

    I18n.locale = 'de'
    SingleTableGlobalize3.locale = :de
    assert_equal I18n.locale, SingleTableGlobalize3.locale

    I18n.locale =  :de
    SingleTableGlobalize3.locale = 'de'
    assert_equal I18n.locale, SingleTableGlobalize3.locale
  end

  test 'with_locale temporarily sets the given locale and yields the block' do
    assert_equal :en, SingleTableGlobalize3.locale
    SingleTableGlobalize3.with_locale :de do |locale|
      assert_equal :de, SingleTableGlobalize3.locale
      assert_equal :de, locale
    end
    assert_equal :en, SingleTableGlobalize3.locale
  end

  test 'with_locales calls block once with each locale given temporarily set' do
    locales = SingleTableGlobalize3.with_locales :en, [:de, :fr] do |locale|
      assert_equal locale, SingleTableGlobalize3.locale
      locale
    end
    assert_equal [:en, :de, :fr], locales
  end

  test "attribute saving goes by content locale and not global locale" do
    SingleTableGlobalize3.locale = :de
    assert_equal :en, I18n.locale
    Post.create :title => 'foo'
    assert_equal :de, Post.first.translations.first.locale
  end

  test "attribute loading goes by content locale and not global locale" do
    post = Post.create(:title => 'title')
    assert_translated Post.first, :en, :title, 'title'

    SingleTableGlobalize3.locale = :de
    post.update_attributes(:title => 'Titel')

    assert_translated Post.first, :en, :title, 'title'
    assert_translated Post.first, :de, :title, 'Titel'
  end
end
