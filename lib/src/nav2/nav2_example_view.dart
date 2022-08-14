import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;

  Book(this.title, this.author);
}

class BookPageView extends StatefulWidget {
  const BookPageView({super.key});

  static MaterialPage page() {
    return const MaterialPage(
        name: routeName, key: ValueKey(routeName), child: BookPageView());
  }

  static const routeName = "BookPageView";

  @override
  State<BookPageView> createState() => _BookPageViewState();
}

class _BookPageViewState extends State<BookPageView> {
  Book? _selectedBook;

  List<Book> books = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ];

  @override
  Widget build(BuildContext context) {
    return BooksListScreen(
      books: books,
      onTapped: _handleSelectBook,
    );

    // return Navigator(
    //   pages: [
    //     MaterialPage(
    //         key: ValueKey('booklistPage'),
    //         child: BooksListScreen(
    //           books: books,
    //           onTapped: _handleSelectBook,
    //         )),
    //     if (_selectedBook != null) BookDetailPage(book: _selectedBook)
    //   ],
    //   onPopPage: (route, result) {
    //     if (!route.didPop(result)) {
    //       //
    //       return false;
    //     }
    //     setState(() {
    //       _selectedBook = null;
    //     });

    //     return true;
    //   },
    // );
  }

  void _handleSelectBook(Book book) {
    setState(() {
      _selectedBook = book;
    });
  }
}

class BookDetailPage extends Page {
  final Book? book;

  BookDetailPage({
    this.book,
  }) : super(key: ValueKey(book));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
        settings: this,
        pageBuilder: (context, animation, secondaryAnimation) {
          final tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero);
          final curveTween = CurveTween(curve: Curves.easeInOut);
          return SlideTransition(
            position: animation.drive(curveTween).drive(tween),
            child: BookDetailScreen(
              key: ValueKey(book),
              book: book,
            ),
          );
        });
  }
}

class BookDetailScreen extends StatelessWidget {
  final Book? book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(book!.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (book != null) ...[
              Text(book!.title, style: Theme.of(context).textTheme.headline6),
              Text(book!.author, style: Theme.of(context).textTheme.subtitle1),
            ],
          ],
        ),
      ),
    );
  }
}

class BooksListScreen extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onTapped;

  const BooksListScreen(
      {super.key, required this.books, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BookList'),
        ),
        body: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            var book = books[index];
            return ListTile(
              title: Text(book.title),
              subtitle: Text(book.author),
              onTap: () => onTapped(book),
            );
          },
        ));
  }
}

class BookRoutePath {
  final int? id;
  final bool isUnknown;

  BookRoutePath.home()
      : id = null,
        isUnknown = false;

  BookRoutePath.details(this.id) : isUnknown = false;

  BookRoutePath.unknown()
      : id = null,
        isUnknown = true;

  bool get isHomePage => id == null;

  bool get isDetailsPage => id != null;
}
