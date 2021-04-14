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
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

/// Виджет поиска
class SearchBar extends StatefulWidget {
  final bool onlyPressing;
  final VoidCallback callbackPressing;
  final VoidCallback callbackCancelSearch;
  final VoidCallback callbackChangedFilters;
  final VoidCallback callbackCanceledFilters;

  SearchBar({
    required this.onlyPressing,
    required this.callbackPressing,
    required this.callbackCancelSearch,
    required this.callbackChangedFilters,
    required this.callbackCanceledFilters,
  });

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();
  final _subject = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    _textController.text = context.read<SightProvider>().searchSights.previousSearchString;
    _textController.addListener(_trackingSearchString);
    _subject.debounceTime(pauseForSearches).listen((s) => _startSearchAfterPause(s));
  }

  @override
  void dispose() {
    _textController.dispose();
    _subject.close();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final bool _isDark = context.watch<CurrentTheme>().isDark;
    bool _isClickingOnSuffixIcon = false;

    return Container(
//      padding: const EdgeInsets.only(bottom: basicBorderSize),
      decoration: BoxDecoration(
        color: _isDark ? darkDarkerBackgroundColor : lightDarkerBackgroundColor,
        borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
      ),
      child: TextField(
        readOnly: widget.onlyPressing ? true : false,
        controller: widget.onlyPressing ? null : _textController,
        onTap: () {
          if (!_isClickingOnSuffixIcon && widget.onlyPressing) widget.callbackPressing();
          _isClickingOnSuffixIcon = false;
        },
        onChanged: (value) {},
        onEditingComplete: () {},
        textAlignVertical: TextAlignVertical.center,
        style: _isDark ? darkMainTextFieldStyle : lightMainTextFieldStyle,
        cursorColor: _isDark ? darkElementPrimaryColor : lightElementPrimaryColor,
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
                  _isClickingOnSuffixIcon = true;
                  if (!widget.onlyPressing) {
                    _textController.clear();
                    FocusScope.of(context).unfocus();
                    widget.callbackCancelSearch();
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => context.read<Web>().isWeb ? WebWrapper(Filters()) : Filters(),
                      ),
                    ).then((needRefresh) {
                      if (needRefresh != null && needRefresh)
                        widget.callbackChangedFilters();
                      else
                        widget.callbackCanceledFilters();
                    });
                  }
                },
                icon: Icon(widget.onlyPressing ? filtersIcon : Icons.cancel),
                color: widget.onlyPressing ? bigGreenButtonColor : null,
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
}
