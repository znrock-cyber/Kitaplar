import 'package:flutter/material.dart';
import 'privacy_policy_screen.dart';
import 'license_screen.dart';
import 'secret_screen.dart';
import 'browser_screen.dart';

class BookHomeScreen extends StatefulWidget {
  @override
  _BookHomeScreenState createState() => _BookHomeScreenState();
}

class _BookHomeScreenState extends State<BookHomeScreen> {
  int _selectedIndex = 0;
  String _searchQuery = '';
  String _selectedCategory = 'All';
  List<String> _favoriteBooks = [];

  final List<Map<String, dynamic>> books = [
    // Telifsiz Klasik Eserler (Project Gutenberg)
    {
      'title': 'Pride and Prejudice',
      'author': 'Jane Austen',
      'description':
          'A timeless romance about love, class, and social expectations',
      'rating': 4.9,
      'pages': 432,
      'genre': 'Classic',
      'color': Colors.pink,
      'image': 'https://covers.openlibrary.org/b/id/8225261-L.jpg',
      'content':
          'Elizabeth Bennet navigates the complex world of 19th-century English society, where first impressions can be deceiving and true love requires looking beyond social prejudices. A witty and insightful exploration of marriage, money, and morality.'
    },
    {
      'title': 'The Adventures of Sherlock Holmes',
      'author': 'Arthur Conan Doyle',
      'description': 'The legendary detective\'s most famous cases',
      'rating': 4.8,
      'pages': 307,
      'genre': 'Mystery',
      'color': Colors.indigo,
      'image': 'https://covers.openlibrary.org/b/id/8091016-L.jpg',
      'content':
          'Join the brilliant detective Sherlock Holmes and his loyal companion Dr. Watson as they solve the most perplexing mysteries in Victorian London. From "A Scandal in Bohemia" to "The Adventure of the Speckled Band," these stories showcase Holmes\' unparalleled deductive abilities.'
    },
    {
      'title': 'Alice\'s Adventures in Wonderland',
      'author': 'Lewis Carroll',
      'description': 'A whimsical journey down the rabbit hole',
      'rating': 4.7,
      'pages': 200,
      'genre': 'Fantasy',
      'color': Colors.purple,
      'image': 'https://covers.openlibrary.org/b/id/8091017-L.jpg',
      'content':
          'Follow young Alice as she tumbles down a rabbit hole into a fantastical world filled with peculiar characters like the Cheshire Cat, the Mad Hatter, and the Queen of Hearts. A beloved tale that has captivated readers for generations.'
    },
    {
      'title': 'The Great Gatsby',
      'author': 'F. Scott Fitzgerald',
      'description': 'The quintessential American novel of the Jazz Age',
      'rating': 4.6,
      'pages': 180,
      'genre': 'Classic',
      'color': Colors.amber,
      'image': 'https://covers.openlibrary.org/b/id/8091018-L.jpg',
      'content':
          'Set in the summer of 1922, this masterpiece explores themes of wealth, love, idealism, and moral decay in the American Dream through the eyes of narrator Nick Carraway and his mysterious neighbor Jay Gatsby.'
    },
    {
      'title': 'Frankenstein',
      'author': 'Mary Shelley',
      'description': 'The original science fiction horror story',
      'rating': 4.5,
      'pages': 280,
      'genre': 'Horror',
      'color': Colors.deepOrange,
      'image': 'https://covers.openlibrary.org/b/id/8091019-L.jpg',
      'content':
          'Victor Frankenstein\'s obsession with creating life leads to the birth of a creature that becomes both his greatest achievement and his ultimate downfall. A profound exploration of science, responsibility, and what it means to be human.'
    },
    {
      'title': 'The Picture of Dorian Gray',
      'author': 'Oscar Wilde',
      'description': 'A tale of beauty, corruption, and moral decay',
      'rating': 4.4,
      'pages': 254,
      'genre': 'Classic',
      'color': Colors.teal,
      'image': 'https://covers.openlibrary.org/b/id/8091020-L.jpg',
      'content':
          'Young Dorian Gray wishes that a portrait of himself would age instead of his body. When his wish comes true, he embarks on a life of hedonistic pleasure while his portrait bears the marks of his moral corruption.'
    },
    {
      'title': 'Dracula',
      'author': 'Bram Stoker',
      'description': 'The definitive vampire novel',
      'rating': 4.3,
      'pages': 418,
      'genre': 'Horror',
      'color': Colors.red,
      'image': 'https://covers.openlibrary.org/b/id/8091021-L.jpg',
      'content':
          'Count Dracula\'s attempt to move from Transylvania to England sparks a battle between the vampire and a small group of people led by Professor Van Helsing. The novel that established many vampire tropes still used today.'
    },
    {
      'title': 'The Time Machine',
      'author': 'H.G. Wells',
      'description': 'A pioneering work of science fiction',
      'rating': 4.2,
      'pages': 118,
      'genre': 'Sci-Fi',
      'color': Colors.cyan,
      'image': 'https://covers.openlibrary.org/b/id/8091022-L.jpg',
      'content':
          'An inventor creates a machine that allows him to travel through time, witnessing the far future of humanity. Wells\' exploration of social evolution and class struggle remains remarkably relevant today.'
    },
    {
      'title': 'Jane Eyre',
      'author': 'Charlotte Brontë',
      'description': 'A powerful story of love, independence, and resilience',
      'rating': 4.8,
      'pages': 507,
      'genre': 'Romance',
      'color': Colors.brown,
      'image': 'https://covers.openlibrary.org/b/id/8091023-L.jpg',
      'content':
          'Orphaned Jane Eyre endures a harsh childhood before becoming a governess at Thornfield Hall, where she falls in love with the brooding Mr. Rochester. A groundbreaking novel that challenged Victorian social norms.'
    },
    {
      'title': 'The Adventures of Tom Sawyer',
      'author': 'Mark Twain',
      'description': 'Classic American childhood adventure',
      'rating': 4.6,
      'pages': 274,
      'genre': 'Adventure',
      'color': Colors.green,
      'image': 'https://covers.openlibrary.org/b/id/8091024-L.jpg',
      'content':
          'Follow the mischievous Tom Sawyer as he navigates childhood in a Missouri town along the Mississippi River. From whitewashing fences to treasure hunting, Tom\'s adventures capture the spirit of American boyhood.'
    },
    {
      'title': 'Little Women',
      'author': 'Louisa May Alcott',
      'description': 'The beloved story of the March sisters',
      'rating': 4.7,
      'pages': 449,
      'genre': 'Family',
      'color': Colors.pinkAccent,
      'image': 'https://covers.openlibrary.org/b/id/8091025-L.jpg',
      'content':
          'Follow the lives of the four March sisters - Meg, Jo, Beth, and Amy - as they grow from childhood to womanhood during the American Civil War. A timeless tale of family, love, and personal growth.'
    },
    {
      'title': 'The Strange Case of Dr. Jekyll and Mr. Hyde',
      'author': 'Robert Louis Stevenson',
      'description': 'A chilling exploration of human duality',
      'rating': 4.4,
      'pages': 96,
      'genre': 'Horror',
      'color': Colors.grey,
      'image': 'https://covers.openlibrary.org/b/id/8091026-L.jpg',
      'content':
          'Dr. Jekyll\'s experiments with human nature lead to the creation of his evil alter ego, Mr. Hyde. This psychological thriller explores the dual nature of humanity and the battle between good and evil within us all.'
    },
    // Modern Additions
    {
      'title': 'The Midnight Library',
      'author': 'Matt Haig',
      'description':
          'Between life and death there is a library, and within that library, the shelves go on forever.',
      'rating': 4.8,
      'pages': 288,
      'genre': 'Fiction',
      'color': Colors.deepPurple,
      'image': 'https://covers.openlibrary.org/b/id/8091027-L.jpg',
      'content':
          'Nora Seed finds herself faced with the possibility of changing her life for a new one, following a different career, undoing old breakups, realizing her dreams of becoming a glaciologist; she must search within herself as she travels through the Midnight Library to decide what is truly fulfilling in life, and what makes it worth living in the first place.'
    },
    {
      'title': 'Atomic Habits',
      'author': 'James Clear',
      'description':
          'An Easy & Proven Way to Build Good Habits & Break Bad Ones',
      'rating': 4.9,
      'pages': 320,
      'genre': 'Self-Help',
      'color': Colors.orange,
      'image': 'https://covers.openlibrary.org/b/id/8091028-L.jpg',
      'content':
          'No matter your goals, Atomic Habits offers a proven framework for improving--every day. James Clear, one of the world\'s leading experts on habit formation, reveals practical strategies that will teach you exactly how to form good habits, break bad ones, and master the tiny behaviors that lead to remarkable results.'
    }
  ];

  List<Map<String, dynamic>> get filteredBooks {
    List<Map<String, dynamic>> filtered = books;

    // Kategori filtresi
    if (_selectedCategory != 'All') {
      filtered =
          filtered.where((book) => book['genre'] == _selectedCategory).toList();
    }

    // Arama filtresi
    if (_searchQuery.isNotEmpty && _searchQuery != '1234') {
      filtered = filtered.where((book) {
        return book['title']
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            book['author'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
            book['genre'].toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  void _openBookDetail(Map<String, dynamic> book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailScreen(book: book),
      ),
    );
  }

  void _showFavorites() {
    final favoriteBooksList =
        books.where((book) => _favoriteBooks.contains(book['title'])).toList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Favorite Books',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Container(
            width: double.maxFinite,
            height: 400,
            child: favoriteBooksList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 64,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No favorite books yet',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap the heart icon on any book to add it to favorites',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: favoriteBooksList.length,
                    itemBuilder: (context, index) {
                      final book = favoriteBooksList[index];
                      return ListTile(
                        leading: Container(
                          width: 40,
                          height: 60,
                          decoration: BoxDecoration(
                            color: book['color'].withValues(alpha: 0.8),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: const Icon(
                            Icons.menu_book,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          book['title'],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          book['author'],
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              _favoriteBooks.remove(book['title']);
                            });
                            Navigator.pop(context);
                            _showFavorites();
                          },
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          _openBookDetail(book);
                        },
                      );
                    },
                  ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kitaplar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Dijital Kütüphaneniz',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: BookSearchDelegate(books),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.deepPurple, Colors.purple[300]!],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.auto_stories,
                    size: 50,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'BookShelf',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Your Digital Library',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.red),
              title: Text('Favorites', style: TextStyle(color: Colors.white)),
              trailing: _favoriteBooks.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        _favoriteBooks.length.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )
                  : null,
              onTap: () {
                Navigator.pop(context);
                _showFavorites();
              },
            ),
            Divider(color: Colors.grey[700]),
            ListTile(
              leading: const Icon(Icons.privacy_tip, color: Colors.deepPurple),
              title:
                  Text('Privacy Policy', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.gavel, color: Colors.deepPurple),
              title: Text('License', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LicenseScreen(),
                  ),
                );
              },
            ),
            Divider(color: Colors.grey[700]),
            ListTile(
              leading: Icon(Icons.info, color: Colors.grey[400]),
              title: Text('About', style: TextStyle(color: Colors.white)),
              subtitle: Text('Version 1.0.0',
                  style: TextStyle(color: Colors.grey[400])),
              onTap: () {
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationName: 'Kitaplar',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(Icons.auto_stories,
                      size: 50, color: Colors.deepPurple),
                  children: [
                    const Text(
                        'Kişisel dijital kütüphaneniz, harika kitapları keşfetmek ve okumak için.'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.all(Radius.circular(25)),
            ),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search books, authors, genres...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });

                // Özel kod kontrolü
                if (value == '1234') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecretScreen(),
                    ),
                  );
                }
              },
            ),
          ),
          // Categories
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategoryChip('All', _selectedCategory == 'All'),
                _buildCategoryChip('Classic', _selectedCategory == 'Classic'),
                _buildCategoryChip('Fiction', _selectedCategory == 'Fiction'),
                _buildCategoryChip('Romance', _selectedCategory == 'Romance'),
                _buildCategoryChip('Mystery', _selectedCategory == 'Mystery'),
                _buildCategoryChip('Horror', _selectedCategory == 'Horror'),
                _buildCategoryChip('Sci-Fi', _selectedCategory == 'Sci-Fi'),
                _buildCategoryChip('Fantasy', _selectedCategory == 'Fantasy'),
                _buildCategoryChip(
                    'Adventure', _selectedCategory == 'Adventure'),
                _buildCategoryChip('Family', _selectedCategory == 'Family'),
                _buildCategoryChip(
                    'Self-Help', _selectedCategory == 'Self-Help'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Books Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                return _buildBookCard(book);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey[400],
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 3) {
            // Tarayıcı sekmesi
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BrowserScreen()),
            );
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.library_books),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.web),
            label: 'Tarayıcı',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        onSelected: (bool selected) {
          setState(() {
            _selectedCategory = label;
          });
        },
        backgroundColor: Colors.grey[800],
        selectedColor: Colors.deepPurple,
        checkmarkColor: Colors.white,
      ),
    );
  }

  Widget _buildBookCard(Map<String, dynamic> book) {
    return GestureDetector(
      onTap: () => _openBookDetail(book),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              book['color'].withValues(alpha: 0.8),
              book['color'].withValues(alpha: 0.6),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: book['color'].withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Cover Image
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: book['image'] != null
                        ? Image.network(
                            book['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                ),
                                child: const Icon(
                                  Icons.menu_book,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              );
                            },
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                            ),
                            child: const Icon(
                              Icons.menu_book,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Book Info
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book['title'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book['author'],
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          book['rating'].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Text(
                            book['genre'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookDetailScreen extends StatefulWidget {
  final Map<String, dynamic> book;

  const BookDetailScreen({Key? key, required this.book}) : super(key: key);

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  List<String> _favoriteBooks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: widget.book['color'],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      widget.book['color'],
                      widget.book['color'].withValues(alpha: 0.7),
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.menu_book,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.book['title'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.book['author'],
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating and Info
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        widget.book['rating'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Icon(Icons.book, color: Colors.grey[400], size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.book['pages']} pages',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: widget.book['color'].withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          widget.book['genre'],
                          style: TextStyle(
                            color: widget.book['color'],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Description
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.book['description'],
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Content Preview
                  Text(
                    'Preview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.book['content'],
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BookReaderScreen(book: widget.book),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.book['color'],
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Read Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: widget.book['color']),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_favoriteBooks
                                  .contains(widget.book['title'])) {
                                _favoriteBooks.remove(widget.book['title']);
                              } else {
                                _favoriteBooks.add(widget.book['title']);
                              }
                            });
                          },
                          icon: Icon(
                            _favoriteBooks.contains(widget.book['title'])
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: widget.book['color'],
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookReaderScreen extends StatefulWidget {
  final Map<String, dynamic> book;

  const BookReaderScreen({Key? key, required this.book}) : super(key: key);

  @override
  _BookReaderScreenState createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _pages = [
    "Chapter 1: The Beginning\n\nIt is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife. However little known the feelings or views of such a man may be on his first entering a neighbourhood, this truth is so well fixed in the minds of the surrounding families, that he is considered the rightful property of some one or other of their daughters.\n\n\"My dear Mr. Bennet,\" said his lady to him one day, \"have you heard that Netherfield Park is let at last?\"\n\nMr. Bennet replied that he had not.\n\n\"But it is,\" returned she; \"for Mrs. Long has just been here, and she told me all about it.\"\n\nMr. Bennet made no answer.\n\n\"Do you not want to know who has taken it?\" cried his wife impatiently.\n\n\"You want to tell me, and I have no objection to hearing it.\"\n\nThis was invitation enough.\n\n\"Why, my dear, you must know, Mrs. Long says that Netherfield is taken by a young man of large fortune from the north of England; that he came down on Monday in a chaise and four to see the place, and was so much delighted with it, that he agreed with Mr. Morris immediately; that he is to take possession before Michaelmas, and some of his servants are to be in the house by the end of next week.\"\n\n\"What is his name?\"\n\n\"Bingley.\"\n\n\"Is he married or single?\"\n\n\"Oh! Single, my dear, to be sure! A single man of large fortune; four or five thousand a year. What a fine thing for our girls!\"\n\n\"How so? How can it affect them?\"\n\n\"My dear Mr. Bennet,\" replied his wife, \"how can you be so tiresome! You must know that I am thinking of his marrying one of them.\"",
    "Chapter 2: First Impressions\n\nWhen Jane and Elizabeth were alone, the former, who had been cautious in her praise of Mr. Bingley before, expressed to her sister just how very much she admired him.\n\n\"He is just what a young man ought to be,\" said she, \"sensible, good-humoured, lively; and I never saw such happy manners!—so much ease, with such perfect good breeding!\"\n\n\"He is also handsome,\" replied Elizabeth, \"which a young man ought likewise to be, if he possibly can. His character is thereby complete.\"\n\n\"I was very much flattered by his asking me to dance a second time. I did not expect such a compliment.\"\n\n\"Did not you? I did for you. But that is one great difference between us. Compliments always take you by surprise, and me never. What could be more natural than his asking you again? He could not help seeing that you were about five times as pretty as every other woman in the room. No thanks to his gallantry for that. Well, he certainly is very agreeable, and I give you leave to like him. You have liked many a stupider person.\"\n\n\"Dear Lizzy!\"\n\n\"Oh! you are a great deal too apt, you know, to like people in general. You never see a fault in anybody. All the world are good and agreeable in your eyes. I never heard you speak ill of a human being in your life.\"\n\n\"I would not wish to be hasty in censuring anyone; but I always speak what I think.\"\n\n\"I know you do; and it is that which makes the wonder. With your good sense, to be so honestly blind to the follies and inconsistencies of others! Affectation of candour is common enough—one meets with it everywhere. But to be candid without ostentation or design—to take the good of everybody's character and make it still better, and say nothing of the bad—belongs to you alone.\"",
    "Chapter 3: The Ball\n\nElizabeth's astonishment was beyond expression. She stared, coloured, and remained silent. This he considered sufficient encouragement; and the avowal of all that he felt, and had long felt for her, immediately followed. He spoke well; but there were feelings besides those of the heart to be detailed; and he was not more eloquent on the subject of tenderness than of pride. His sense of her inferiority—of its being a degradation—of the family obstacles which had always opposed to inclination, were dwelt on with a warmth which seemed due to the consequence he was wounding, but was very unlikely to recommend his suit.\n\nIn spite of her deeply-rooted dislike, she could not be insensible to the compliment of such a man's affection, and though her intentions did not vary for an instant, she was at first sorry for the pain he was to receive; till, roused to resentment by his subsequent language, she lost all compassion in anger. She tried, however, to compose herself to answer him with patience, when he should have done. He concluded with representing to her the strength of that attachment which, in spite of all his endeavours, he had found impossible to conquer; and with expressing his hope that it would now be rewarded by her acceptance of his hand. As he said this, she could easily see that he had no doubt of a favourable answer. He spoke of apprehension and anxiety, but his countenance expressed real security. Such a circumstance could only exasperate farther, and, when he ceased, the colour rose into her cheeks, and she said:\n\n\"In such cases as this, it is, I believe, the established mode to express a sense of obligation for the sentiments avowed, however unequally they may be returned. It is natural that obligation should be felt, and if I could feel gratitude, I would now thank you. But I cannot—I have never desired your good opinion, and you have certainly bestowed it most unwillingly.\"",
    "Chapter 4: Understanding\n\n\"You are too generous to trifle with me. If your feelings are still what they were last April, tell me so at once. My affections and wishes are unchanged, but one word from you will silence me on this subject for ever.\"\n\nElizabeth, feeling all the more than common awkwardness and anxiety of his situation, now forced herself to speak; and immediately, though not very fluently, gave him to understand that her sentiments had undergone so material a change, since the period to which he alluded, as to make her receive with gratitude and pleasure his present assurances. The happiness which this reply produced, was such as he had probably never felt before; and he expressed himself on the occasion as sensibly and as warmly as a man violently in love can be supposed to do. Had Elizabeth been able to encounter his eye, she might have seen how well the expression of heartfelt delight, diffused over his face, became him; but, though she could not look, she could listen, and he told her of feelings, which, in proving of what importance she was to him, made his affection every moment more valuable.\n\nThey walked on, without knowing in what direction. There was too much to be thought, and felt, and said, for attention to any other objects. She soon learnt that they were indebted for their present good understanding to the efforts of his aunt, who did call on him in her return through London, and there relate her journey to Longbourn, its motive, and the substance of her conversation with Elizabeth; dwelling emphatically on every expression of the latter which, in her ladyship's apprehension, peculiarly denoted her perverseness and assurance; in the belief that such a relation must assist her endeavours to obtain that promise from her nephew which she had refused to give. But, unluckily for her ladyship, its effect had been exactly contrariwise.\n\n\"It taught me to hope,\" said he, \"as I had scarcely ever allowed myself to hope before. I knew enough of your disposition to be certain that, had you been absolutely, irrevocably decided against me, you would have acknowledged it to Lady Catherine, frankly and openly.\"",
    "Epilogue: Ever After\n\nElizabeth's mind was now relieved from a very heavy weight; and, after half an hour's quiet reflection in her own room, she was able to join the others with tolerable composure. Every thing was too recent for gaiety, but the evening passed tranquilly away; there was no longer anything material to be dreaded, and the comfort of ease and familiarity would come in time.\n\nWhen her mother went up to her dressing-room at night, she followed her, and made the important communication. Its effect was most extraordinary; for on first hearing it, Mrs. Bennet sat quite still, and unable to utter a syllable. Nor was it under many, many minutes that she could comprehend what she heard; though not in general backward to credit what was for the advantage of her family, or that came in the shape of a lover to any of them. She began at length to recover, to fidget about in her chair, get up, sit down again, wonder, and bless herself.\n\n\"Good gracious! Lord bless me! only think! dear me! Mr. Darcy! Who would have thought it! And is it really true? Oh! my sweetest Lizzy! how rich and how great you will be! What pin-money, what jewels, what carriages you will have! Jane's is nothing to it—nothing at all. I am so pleased—so happy. Such a charming man!—so handsome! so tall!—Oh, my dear Lizzy! pray apologise for my having disliked him so much before. I hope he will overlook it. Dear, dear Lizzy. A house in town! Every thing that is charming! Three daughters married! Ten thousand a year! Oh, Lord! What will become of me. I shall go distracted.\"\n\nThis was enough to prove that her approbation need not be doubted: and Elizabeth, rejoicing that such an effusion was heard only by herself, soon went away. But before she had been three minutes in her own room, her mother followed her.\n\n\"My dearest child,\" she cried, \"I can think of nothing else! Ten thousand a year, and very likely more! 'Tis as good as a Lord! And a special licence. You must and shall be married by a special licence. But my dearest love, tell me what dish Mr. Darcy is particularly fond of, that I may have it tomorrow.\""
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.book['title'],
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Text(
                  'Page ${_currentPage + 1} of ${_pages.length}',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
                const Spacer(),
                Text(
                  '${((_currentPage + 1) / _pages.length * 100).round()}%',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 2,
            child: LinearProgressIndicator(
              value: (_currentPage + 1) / _pages.length,
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(widget.book['color']),
            ),
          ),
          // Book Content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _pages[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.8,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Navigation Controls
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _currentPage > 0
                      ? () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                  icon: Icon(
                    Icons.chevron_left,
                    color: _currentPage > 0 ? Colors.white : Colors.grey[600],
                    size: 32,
                  ),
                ),
                Text(
                  '${_currentPage + 1} / ${_pages.length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: _currentPage < _pages.length - 1
                      ? () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                  icon: Icon(
                    Icons.chevron_right,
                    color: _currentPage < _pages.length - 1
                        ? Colors.white
                        : Colors.grey[600],
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> books;

  BookSearchDelegate(this.books);

  @override
  String get searchFieldLabel => 'Search books...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey[400]),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.white),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final results = books.where((book) {
      return book['title'].toLowerCase().contains(query.toLowerCase()) ||
          book['author'].toLowerCase().contains(query.toLowerCase()) ||
          book['genre'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Container(
      color: Colors.black,
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final book = results[index];
          return ListTile(
            leading: Container(
              width: 40,
              height: 60,
              decoration: BoxDecoration(
                color: book['color'].withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.menu_book,
                color: Colors.white,
                size: 20,
              ),
            ),
            title: Text(
              book['title'],
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              book['author'],
              style: TextStyle(color: Colors.grey[400]),
            ),
            trailing: Icon(Icons.arrow_forward_ios,
                color: Colors.grey[400], size: 16),
            onTap: () {
              close(context, book['title']);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailScreen(book: book),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
