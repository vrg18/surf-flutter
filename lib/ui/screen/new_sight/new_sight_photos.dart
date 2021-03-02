import 'dart:math';

import 'package:flutter/material.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/sizes.dart';

/// Горизонтальный список с фотками нового места
class NewSightPhotos extends StatefulWidget {
  final List<String> _photos;

  NewSightPhotos(this._photos);

  @override
  _NewSightPhotosState createState() => _NewSightPhotosState();
}

class _NewSightPhotosState extends State<NewSightPhotos> {
  final Map<String, bool> _isDrag = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(basicBorderSize),
      child: SizedBox(
        height: photoSizeOfNewSight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget._photos.length + 1,
          itemBuilder: (_, index) {
            if (index == 0) return _largeAddButton();
            return _photoContainer(index - 1);
          },
          separatorBuilder: (_, index) => _dragTarget(index),
        ),
      ),
    );
  }

  // Кнопка добавления фото
  Widget _largeAddButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => _addPhoto(),
          child: Container(
            width: photoSizeOfNewSight,
            height: photoSizeOfNewSight,
            decoration: BoxDecoration(
              border: Border.all(
                color: bigGreenButtonColor,
              ),
              borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
            ),
            child: Icon(
              Icons.add,
              size: 48,
              color: bigGreenButtonColor,
            ),
          ),
        ),
      ),
    );
  }

  // Draggable над фото
  Widget _photoContainer(int index) {
    String _photo = widget._photos[index];
    ValueKey _key = ValueKey(_photo);
    if (!_isDrag.containsKey(_photo)) _isDrag[_photo] = false;

    return Draggable<int>(
      data: index,
      axis: Axis.horizontal,
      onDragStarted: () => setState(() => _isDrag[_photo] = true),
      onDragEnd: (value) {
        setState(() => _isDrag[_photo] = false);
        print(value);
      },
      child: _isDrag[_photo]! ? const SizedBox(width: photoSizeOfNewSight) : _onePhoto(_key, index, _photo),
      feedback: _onePhoto(_key, index, _photo),
    );
  }

  // Само фото
  Widget _onePhoto(ValueKey key, int index, String photo) {
    return Dismissible(
      key: key,
      direction: DismissDirection.vertical,
      onDismissed: (_) => _deletePhoto(index),
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            width: photoSizeOfNewSight,
            height: photoSizeOfNewSight,
            decoration: BoxDecoration(
              color: Color(int.parse(photo, radix: 16)).withOpacity(1.0),
              borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cornerRadiusOfSightCard),
              child: SizedBox(
                width: 48,
                child: MaterialButton(
                  onPressed: () => _deletePhoto(index),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  height: 48,
                  child: Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Виджет-приемник при перетаскивании
  Widget _dragTarget(int destination) {
    return DragTarget<int>(
      builder: (_, __, ___) => SizedBox(
        width: basicBorderSize,
      ),
      onAccept: (source) => _movePhoto(source, source >= destination ? destination : destination - 1),
    );
  }

  // Добавление фото в список
  void _addPhoto() {
    setState(() =>
        widget._photos.add(Random().nextInt(0xFFFFFF).toRadixString(16))); // todo временно цветная заглушка вместо фото
  }

  // Удаление фото из списка
  void _deletePhoto(int index) {
    setState(() => widget._photos.removeAt(index));
  }

  // Перемещение фото в списке
  void _movePhoto(int source, int destination) {
    setState(() => widget._photos.insert(destination, widget._photos.removeAt(source)));
  }
}
