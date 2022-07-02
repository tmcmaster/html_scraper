import 'package:html/dom.dart';

/// TODO: need to migrate to using this DocumentParser in the PageParser.
class ElementParser {
  final Element? _element;

  ElementParser(this._element);

  static ElementParser query(Document document) {
    return ElementParser(document.body);
  }

  ElementParser selectNthChild(String tagName, int index) {
    if (_element == null) return this;
    final children = _element!.children.where((element) => element.localName == tagName).toList();
    if (children.length < index) return ElementParser(null);
    return ElementParser(children[index - 1]);
  }

  ElementParser select(String querySelector) {
    if (_element == null) return this;
    final element = _element!.querySelector(querySelector);
    // print('select = $element');
    return ElementParser(element);
  }

  HtmlListParser selectAll(String querySelector) {
    if (_element == null) return HtmlListParser([]);
    final elements = _element!.querySelectorAll(querySelector);
    // print('selectAll = $elements');
    return HtmlListParser(elements);
  }

  HtmlListParser selectTag(String querySelector) {
    if (_element == null) return HtmlListParser([]);
    final elements = _element!.getElementsByTagName(querySelector);
    // print('selectAll = $elements');
    return HtmlListParser(elements);
  }

  String? innerHTML() {
    if (_element == null) null;
    return (_element == null ? null : _element!.innerHtml);
  }

  Element? element() {
    return _element;
  }

  String? innerHtml() {
    return (_element == null ? null : _element!.innerHtml);
  }

  String? outerHtml() {
    return (_element == null ? null : _element!.outerHtml);
  }

  String? text({
    bool trim = false,
    bool removeFormatString = false,
  }) {
    final value = (_element == null ? null : _element!.text);
    return trim ? _trimString(value, removeFormatString) : value;
  }

  String? href() {
    return attribute('href');
  }

  String? src() {
    return attribute('src');
  }

  String? attribute(String attribute) {
    return _element == null
        ? null
        : _element!.attributes.containsKey(attribute)
            ? _element!.attributes[attribute]
            : null;
  }

  String? _trimString(String? value, bool removeFormatString) {
    if (value == null) return null;
    final cleanedString = removeFormatString ? value.replaceAll('\n', '').replaceAll('\t', '') : value;
    return cleanedString.trimLeft().trim();
  }
}

class HtmlListParser {
  final List<Element> _elements;
  HtmlListParser(this._elements);

  void forEach(dynamic Function(ElementParser elementParser) processor) {
    _elements.forEach((element) => processor(ElementParser(element)));
  }

  List<Element> elements() {
    return _elements;
  }

  String? innerHtml() {
    if (_elements.isEmpty) return null;
    return _elements.map((element) => element.innerHtml).toList().join();
  }

  String? outerHtml() {
    if (_elements.isEmpty) return null;
    return _elements.map((element) => element.outerHtml).toList().join();
  }
}
