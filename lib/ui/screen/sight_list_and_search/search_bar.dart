import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/provider/current_theme.dart';
import 'package:places/data/provider/is_web.dart';
import 'package:places/data/provider/sight_provider.dart';
import 'package:places/data/res/magnitudes.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/filters/filters.dart';
import 'package:places/ui/screen/web_wrapper.dart';
import 'package:places/ui/screen/widgets/slide_on_right_route.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

/// Виджет поиска
class SearchBar extends StatefulWidget {
  final VoidCallback? callbackPressing;
  final VoidCallback? callbackCancelSearch;
  final VoidCallback? callbackChangedFilters;
  final VoidCallback? callbackCanceledFilters;

  SearchBar({
    this.callbackPressing,
    this.callbackCancelSearch,
    this.callbackChangedFilters,
    this.callbackCanceledFilters,
  });

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late final TextEditingController _textController;
  late final PublishSubject<String> _subject;
  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textController.text = context.read<SightProvider>().searchSights.previousSearchString;
    _textController.addListener(_trackingSearchString);
    _subject = PublishSubject<String>();
    _subscription = _subject.debounceTime(pauseForSearches).listen((s) => _startSearchAfterPause(s));
  }

  @override
  void dispose() {
    _subscription.cancel();
    _subject.close();
    _textController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final bool isDark = context.watch<CurrentTheme>().isDark;
    bool isClickingOnSuffixIcon = false;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? darkDarkerBackgroundColor : lightDarkerBackgroundColor,
        borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
      ),
      child: TextField(
        readOnly: widget.callbackPressing != null ? true : false,
        controller: widget.callbackPressing != null ? null : _textController,
        onTap: () {
          if (!isClickingOnSuffixIcon && widget.callbackPressing != null) widget.callbackPressing!();
          isClickingOnSuffixIcon = false;
        },
        onChanged: (value) {},
        onEditingComplete: () {},
        textAlignVertical: TextAlignVertical.center,
        style: isDark ? darkMainTextFieldStyle : lightMainTextFieldStyle,
        cursorColor: isDark ? darkElementPrimaryColor : lightElementPrimaryColor,
        autofocus: false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 8),
          hintText: letteringSearch,
          hintStyle: addSightSectionLabelAndHintTextStyle,
          border: InputBorder.none,
          prefixIcon: Icon(
            searchIcon,
            color: translucent56TertiaryColor,
          ),
          suffixIcon: ClipRRect(
            borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
            child: Material(
              type: MaterialType.transparency,
              child: IconButton(
                onPressed: () {
                  isClickingOnSuffixIcon = true;
                  _clickingOnSuffixIcon();
                },
                icon: Icon(widget.callbackPressing != null ? filtersIcon : Icons.cancel),
                color: widget.callbackPressing != null
                    ? bigGreenButtonColor
                    : isDark
                        ? darkElementPrimaryColor
                        : lightElementPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Метод "слушает" TextField и запускает debounce в Stream для "ловли" паузы при вводе строки поиска
  void _trackingSearchString() {
    _subject.add(_textController.text.trim());
  }

  /// Если пауза при вводе строки "поймана", инициируется поиск по строке
  /// и добавление результата поиска в Stream для отработки StreamBuilder
  void _startSearchAfterPause(String searchString) {
    print('Получили строку для поиска "$searchString"');
    context.read<SightProvider>().startingNewSearch(searchString);
  }

  /// Обработка нажатия на иконку-суфикс "Фильтры" или "Очистить"
  void _clickingOnSuffixIcon() {
    if (widget.callbackPressing == null) {
      _textController.clear();
      widget.callbackCancelSearch!();
    } else {
      Navigator.push(
        context,
        SlideOnRightRoute(page: context.read<Web>().isWeb ? WebWrapper(Filters()) : Filters()),
      ).then((needRefresh) {
        if (needRefresh != null && needRefresh)
          widget.callbackChangedFilters!();
        else
          widget.callbackCanceledFilters!();
      });
    }
  }
}
