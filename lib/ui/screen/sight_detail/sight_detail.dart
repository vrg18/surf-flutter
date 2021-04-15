import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/provider/current_theme.dart';
import 'package:places/data/provider/is_web.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';
import 'package:places/ui/res/strings.dart';
import 'package:places/ui/screen/buttons/big_green_button.dart';
import 'package:places/ui/screen/buttons/universal_white_button.dart';
import 'package:places/ui/screen/sight_detail/sight_detail_description.dart';
import 'package:places/ui/screen/sight_detail/sight_detail_photo.dart';
import 'package:provider/provider.dart';

/// Экран детализации места
class SightDetail extends StatelessWidget {
  final Sight _sight;

  SightDetail(this._sight);

  @override
  Widget build(BuildContext context) {
    bool _isDark = context.watch<CurrentTheme>().isDark;

    return OrientationBuilder(
      builder: (_, orientation) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                orientation == Orientation.portrait || _isDark ? Brightness.light : Brightness.dark,
          ),
        );
        return LayoutBuilder(
          builder: (_, constraints) {
            int itemCount = _sight.photos.length;
            double indicatorWidth = orientation == Orientation.portrait
                ? constraints.maxWidth / itemCount
                : constraints.maxWidth / itemCount / 2;

            return orientation == Orientation.portrait
                ? Scaffold(
                    body: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          title: Padding(
                            padding: EdgeInsets.only(top: context.read<Web>().isWeb ? additionalPaddingAboveTopBar : 0),
                            child: _pressBack(context, _isDark),
                          ),
                          expandedHeight: constraints.maxHeight / 2,
                          flexibleSpace: SightDetailPhoto(_sight.photos, indicatorWidth),
                        ),
                        SliverToBoxAdapter(child: SightDetailDescription(_sight)),
                      ],
                    ),
                    bottomNavigationBar: _bottomWithButtons(_isDark),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            SightDetailPhoto(_sight.photos, indicatorWidth),
                            Positioned(
                              top: 32,
                              left: 16,
                              child: _pressBack(context, _isDark),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Scaffold(
                          body: Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: SingleChildScrollView(
                              child: SightDetailDescription(_sight),
                            ),
                          ),
                          bottomNavigationBar: _bottomWithButtons(_isDark),
                        ),
                      ),
                    ],
                  );
          },
        );
      },
    );
  }

  /// Кнопка назад
  Widget _pressBack(BuildContext context, bool isDark) {
    return SizedBox(
      width: 36,
      height: 36,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: isDark ? darkMainBackgroundColor : lightMainBackgroundColor,
          child: InkWell(
            onTap: () {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
              ));
              Navigator.pop(context);
            },
            child: Icon(
              Icons.chevron_left,
              color: isDark ? darkElementPrimaryColor : lightElementPrimaryColor,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }

  /// Подвал с кнопками
  Padding _bottomWithButtons(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(basicBorderSize),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _rowBigGreenButton(),
          const SizedBox(height: 12),
          Divider(color: lightDarkerBackgroundColor),
          _rowToScheduleAndFavorite(isDark),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  /// Большая зеленая кнопка
  Widget _rowBigGreenButton() {
    return BigGreenButton(
      label: buttonLabelBuildRoute,
      iconData: Icons.near_me_outlined,
      toConsole: buildRoutePress,
    );
  }

  /// Строка с кнопками "Запланировать" и "В избранное"
  Widget _rowToScheduleAndFavorite(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        UniversalWhiteButton(
          label: buttonLabelToSchedule,
          isDark: isDark,
          isActive: false,
          iconData: Icons.today,
          toConsole: toSchedulePress,
        ),
        UniversalWhiteButton(
          label: buttonLabelToFavorites,
          isDark: isDark,
          iconData: Icons.favorite_border,
          toConsole: toFavoritesPress,
        ),
      ],
    );
  }
}
