// =======================
// PROFESSIONAL UI VERSION (Flutter + Supabase)
// Clean, modern app design
// =======================

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'dart:html' as html;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bdolifxxpnpnonwavhum.supabase.co',
    anonKey: 'Anon Key',
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xfff5f6fa),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          elevation: 0,
        ),
      ),
      home: const LoginPage(),
    );
  }
}





class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final supabase = Supabase.instance.client;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool showPassword = false;

  Future<void> login() async {
    setState(() => isLoading = true);

    try {
      final response = await supabase
          .from('users')
          .select()
          .eq('username', usernameController.text.trim())
          .eq('password', passwordController.text.trim())
          .maybeSingle();

      if (response != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        showError("Wrong Username or Password");
      }
    } catch (e) {
      showError("Login Error");
    }

    setState(() => isLoading = false);
  }

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [

                // 🔥 LOGO
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xffff5252),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: ClipOval(
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5XjYTu8VE9YZq7w4VdqsGORc6S-OM6E8uzg&s",
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // 🔥 BRAND NAME
                const Text(
                  "Afridi ENGLISH & IELTS STUDIO Prepare, Perform, Prosper",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xffff5252),
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 35),

                // USERNAME
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person, color: Color(
                        0xff000000)),
                    labelText: "Username",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // PASSWORD (SHOW/HIDE)
                TextField(
                  controller: passwordController,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Color(0xffff5252)),
                    labelText: "Password",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xFF5252FF),
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5252FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // FOOTER
                const Text(
                  "Dev by JD",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// =======================
// HOME WITH BOTTOM NAV
// =======================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  // ================= PAGES (ADMIN ADDED)
  final pages = [
    const DashboardPage(),
    const StudentsPage(),
    const AttendancePage(),
    const TeachersPage(),
    const AdminPage(), // 👈 FIXED (NOW SHOWS)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),

      // ================= APP BAR (DYNAMIC TITLE)
      appBar: AppBar(
        title: Text(_title()),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),

      // ================= BODY
      body: pages[index],

      // ================= BOTTOM NAV
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
            )
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,

          onTap: (i) => setState(() => index = i),

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "Students",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle),
              label: "Attendance",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Teachers",
            ),
            BottomNavigationBarItem( // 👈 ADMIN BUTTON FIXED
              icon: Icon(Icons.admin_panel_settings),
              label: "Admin",
            ),
          ],
        ),
      ),
    );
  }

  // ================= TITLE CHANGE (PRO TOUCH)
  String _title() {
    switch (index) {
      case 0:
        return "Dashboard";
      case 1:
        return "Students";
      case 2:
        return "Attendance";
      case 3:
        return "Teachers";
      case 4:
        return "Admin Panel";
      default:
        return "Academy";
    }
  }
}

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key});

  @override
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  final supabase = Supabase.instance.client;

  List teachers = [];
  List filteredTeachers = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchTeachers();
  }

  Future fetchTeachers() async {
    final data = await supabase.from('teachers').select().order('created_at');

    setState(() {
      teachers = data;
      filteredTeachers = data;
      loading = false;
    });
  }

  // ================= SEARCH
  void search(String value) {
    final result = teachers.where((t) {
      final name = (t['name'] ?? '').toString().toLowerCase();
      final subject = (t['subject'] ?? '').toString().toLowerCase();
      return name.contains(value.toLowerCase()) ||
          subject.contains(value.toLowerCase());
    }).toList();

    setState(() => filteredTeachers = result);
  }

  // ================= ADD TEACHER
  void showAddTeacher() {
    final name = TextEditingController();
    final subject = TextEditingController();
    final phone = TextEditingController();
    String gender = "Male";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        decoration: const BoxDecoration(
          color: Color(0xfff5f6fa),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 5,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Add Teacher",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),

            const SizedBox(height: 20),

            input(name, "Teacher Name", Icons.person),
            input(subject, "Subject", Icons.book),
            input(phone, "Phone", Icons.phone),

            const SizedBox(height: 10),

            // ================= GENDER
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: DropdownButton<String>(
                value: gender,
                isExpanded: true,
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(value: "Male", child: Text("Male")),
                  DropdownMenuItem(value: "Female", child: Text("Female")),
                  DropdownMenuItem(value: "Other", child: Text("Other")),
                ],
                onChanged: (val) {
                  gender = val!;
                },
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  if (name.text.isEmpty ||
                      subject.text.isEmpty ||
                      phone.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Fill all fields")),
                    );
                    return;
                  }

                  await supabase.from('teachers').insert({
                    'name': name.text,
                    'subject': subject.text,
                    'phone': phone.text,
                    'gender': gender,
                    'created_at': DateTime.now().toIso8601String(),
                  });

                  Navigator.pop(context);
                  fetchTeachers();
                },
                child: const Text("Save Teacher"),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ================= INPUT
  Widget input(TextEditingController c, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.indigo),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ================= CARD (PRO)
  Widget teacherCard(Map t) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade100],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),

        leading: CircleAvatar(
          backgroundColor: Colors.indigo,
          child: Text(
            t['name'] != null ? t['name'][0] : '?',
            style: const TextStyle(color: Colors.white),
          ),
        ),

        title: Text(
          t['name'] ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Subject: ${t['subject'] ?? ''}"),
            Text("Phone: ${t['phone'] ?? ''}"),
            Text("Gender: ${t['gender'] ?? ''}"),
          ],
        ),

        trailing: PopupMenuButton(
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'view', child: Text("View")),
            PopupMenuItem(value: 'delete', child: Text("Delete")),
          ],
          onSelected: (value) async {
            if (value == 'delete') {
              await supabase.from('teachers').delete().eq('id', t['id']);
              fetchTeachers();
            }

            if (value == 'view') {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(t['name']),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Subject: ${t['subject']}"),
                      Text("Phone: ${t['phone']}"),
                      Text("Gender: ${t['gender']}"),
                      const SizedBox(height: 10),
                      Text("Date: ${t['created_at']}"),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Close"),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // ================= UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),

      appBar: AppBar(
        title: const Text("Teachers"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: TeacherSearch(teachers),
              );
            },
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: showAddTeacher,
        child: const Icon(Icons.add),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : filteredTeachers.isEmpty
          ? const Center(child: Text("No Teachers Found"))
          : ListView.builder(
        itemCount: filteredTeachers.length,
        itemBuilder: (_, i) =>
            teacherCard(filteredTeachers[i]),
      ),
    );
  }
}

class TeacherSearch extends SearchDelegate {
  final List teachers;
  final supabase = Supabase.instance.client;

  TeacherSearch(this.teachers);

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.close),
      onPressed: () {
        query = '';
      },
    )
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      close(context, null);
    },
  );

  // ================= FILTER
  List _filter() {
    return teachers.where((t) {
      final name = (t['name'] ?? '').toString().toLowerCase();
      final subject = (t['subject'] ?? '').toString().toLowerCase();
      return name.contains(query.toLowerCase()) ||
          subject.contains(query.toLowerCase());
    }).toList();
  }

  // ================= RESULTS
  @override
  Widget buildResults(BuildContext context) {
    final results = _filter();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (_, i) {
        final t = results[i];

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),

            leading: CircleAvatar(
              backgroundColor: Colors.indigo,
              child: Text(
                t['name'] != null ? t['name'][0] : '?',
                style: const TextStyle(color: Colors.white),
              ),
            ),

            title: Text(
              t['name'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            subtitle: Text("Subject: ${t['subject'] ?? ''}"),

            trailing: PopupMenuButton(
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'view', child: Text("View")),
                PopupMenuItem(value: 'delete', child: Text("Delete")),
              ],
              onSelected: (value) async {
                // ================= VIEW
                if (value == 'view') {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(t['name'] ?? ''),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Subject: ${t['subject']}"),
                          Text("Phone: ${t['phone']}"),
                          Text("Gender: ${t['gender']}"),
                          const SizedBox(height: 10),
                          Text(
                            "Date: ${t['created_at']}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        )
                      ],
                    ),
                  );
                }

                // ================= DELETE
                if (value == 'delete') {
                  await supabase
                      .from('teachers')
                      .delete()
                      .eq('id', t['id']);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Teacher Deleted")),
                  );

                  close(context, null);
                }
              },
            ),
          ),
        );
      },
    );
  }

  // ================= SUGGESTIONS (same UI)
  @override
  Widget buildSuggestions(BuildContext context) {
    final results = _filter();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (_, i) {
        final t = results[i];

        return ListTile(
          leading: const Icon(Icons.person, color: Colors.indigo),
          title: Text(t['name'] ?? ''),
          subtitle: Text(t['subject'] ?? ''),
          onTap: () {
            query = t['name'];
            showResults(context);
          },
        );
      },
    );
  }
}
// =======================
// DASHBOARD (REAL LOOK)
// =======================


class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final supabase = Supabase.instance.client;

  bool loading = true;

  int totalStudents = 0;
  int todayStudents = 0;
  int monthStudents = 0;
  int yearStudents = 0;

  int totalReceived = 0;
  int todayReceived = 0;
  int monthReceived = 0;
  int yearReceived = 0;

  int totalExpense = 0;
  int todayExpense = 0;
  int monthExpense = 0;
  int yearExpense = 0;

  @override
  void initState() {
    super.initState();
    fetchDashboard();
  }

  bool isSameDay(DateTime a, DateTime b) =>
      a.day == b.day && a.month == b.month && a.year == b.year;

  bool isSameMonth(DateTime d) {
    final now = DateTime.now();
    return d.month == now.month && d.year == now.year;
  }

  bool isSameYear(DateTime d) {
    final now = DateTime.now();
    return d.year == now.year;
  }

  Future fetchDashboard() async {
    final students = await supabase.from('students').select();
    final expenses = await supabase.from('expenses').select();

    DateTime now = DateTime.now();

    int tStudents = 0, dStudents = 0, mStudents = 0, yStudents = 0;
    int tReceived = 0, dReceived = 0, mReceived = 0, yReceived = 0;

    int tExp = 0, dExp = 0, mExp = 0, yExp = 0;

    for (var s in students) {
      DateTime created = DateTime.parse(s['created_at']);
      int received = (s['received_money'] ?? 0);

      tStudents++;
      tReceived += received;

      if (isSameDay(created, now)) {
        dStudents++;
        dReceived += received;
      }

      if (isSameMonth(created)) {
        mStudents++;
        mReceived += received;
      }

      if (isSameYear(created)) {
        yStudents++;
        yReceived += received;
      }
    }

    for (var e in expenses) {
      DateTime created = DateTime.parse(e['created_at']);
      int amount = e['amount'] ?? 0;

      tExp += amount;

      if (isSameDay(created, now)) dExp += amount;
      if (isSameMonth(created)) mExp += amount;
      if (isSameYear(created)) yExp += amount;
    }

    setState(() {
      totalStudents = tStudents;
      todayStudents = dStudents;
      monthStudents = mStudents;
      yearStudents = yStudents;

      totalReceived = tReceived;
      todayReceived = dReceived;
      monthReceived = mReceived;
      yearReceived = yReceived;

      totalExpense = tExp;
      todayExpense = dExp;
      monthExpense = mExp;
      yearExpense = yExp;

      loading = false;
    });
  }

  // ================= EXPENSE FORM
  void showExpenseForm() {
    final amount = TextEditingController();
    final purpose = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "ADD EXPENSE",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: amount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Amount",
                  prefixIcon: const Icon(Icons.payments, color: Colors.red),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: purpose,
                decoration: InputDecoration(
                  labelText: "Purpose",
                  prefixIcon:
                  const Icon(Icons.description, color: Colors.red),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14))),
                  onPressed: () async {
                    await supabase.from('expenses').insert({
                      'amount': int.parse(amount.text),
                      'purpose': purpose.text,
                      'created_at': DateTime.now().toIso8601String(),
                    });

                    Navigator.pop(context);
                    fetchDashboard();
                  },
                  child: const Text("SAVE EXPENSE"),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // ================= CARD
  Widget card(String title, IconData icon, int total, int today,
      int month, int year) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xffffebee)],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
              color: Colors.red.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 6))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(icon, color: Colors.red)),
              const Text("LIVE",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 11)),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            "$total",
            style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),

          Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600)),

          const Divider(),

          stat("Today", today),
          stat("Month", month),
          stat("Year", year),
        ],
      ),
    );
  }

  Widget stat(String t, int v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(t,
              style:
              const TextStyle(fontSize: 13, color: Colors.black54)),
          Text("$v",
              style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 13)),
        ],
      ),
    );
  }

  // ================= REPORT CARD (NEW)
  Widget reportCard() {
    int profit = totalReceived - totalExpense;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.red, Colors.deepOrange],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("FINANCIAL REPORT",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),

          const SizedBox(height: 10),

          Text("Students: $totalStudents",
              style: const TextStyle(color: Colors.white, fontSize: 15)),
          Text("Received: $totalReceived",
              style: const TextStyle(color: Colors.white, fontSize: 15)),
          Text("Expenses: $totalExpense",
              style: const TextStyle(color: Colors.white, fontSize: 15)),

          const Divider(color: Colors.white70),

          Text("Net Profit: $profit",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // ================= UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),

      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Afridi ENGLISH & IELTS STUDIO ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: showExpenseForm,
              icon: const Icon(Icons.add_circle_outline))
        ],
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            reportCard(),
            const SizedBox(height: 12),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
                children: [
                  card("Students", Icons.people, totalStudents,
                      todayStudents, monthStudents, yearStudents),

                  card("Fees Received", Icons.payments, totalReceived,
                      todayReceived, monthReceived, yearReceived),

                  card("Expenses", Icons.remove_circle, totalExpense,
                      todayExpense, monthExpense, yearExpense),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  final supabase = Supabase.instance.client;

  List students = [];
  List filteredStudents = [];
  List<Map<String, dynamic>> courses = [];

  bool loading = true;

  final searchController = TextEditingController();

  String safe(v) => v?.toString() ?? '';

  @override
  void initState() {
    super.initState();
    fetchAll();
    searchController.addListener(search);
  }

  // ================= FETCH
  Future fetchAll() async {
    setState(() => loading = true);

    try {
      final studentsData =
      await supabase.from('students').select().order('created_at');

      final coursesData = await supabase.from('courses').select();

      setState(() {
        students = studentsData;
        filteredStudents = studentsData;
        courses = List<Map<String, dynamic>>.from(coursesData);
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      debugPrint("Error: $e");
    }
  }



  // ================= SEARCH
  void search() {
    final value = searchController.text.trim().toLowerCase();

    if (value.isEmpty) {
      setState(() {
        filteredStudents = List.from(students);
      });
      return;
    }

    final result = <Map>[];

    for (final s in students) {
      final name = safe(s['name']).toLowerCase();
      final phone = safe(s['phone']).toLowerCase();

      if (name.contains(value) || phone.contains(value)) {
        result.add(s);
      }
    }

    setState(() {
      filteredStudents = result;
    });
  }

  // ================= VIEW STUDENT (PRO UI)
  void viewStudent(Map s) {
    DateTime? admissionDate =
    DateTime.tryParse(s['created_at']?.toString() ?? '');

    String admissionDateText = admissionDate != null
        ? admissionDate.toLocal().toString().split(' ')[0]
        : "N/A";

    String admissionTimeText = admissionDate != null
        ? admissionDate.toLocal().toString().split(' ')[1].substring(0, 5)
        : "N/A";

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.transparent,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [Color(0xff1e3c72), Color(0xff2a5298)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                children: [
                  // ================= AVATAR =================
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text(
                      safe(s['name']).isNotEmpty ? safe(s['name'])[0] : "S",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    safe(s['name']),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // ================= INFO CARD =================
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        _proRow(Icons.person, "Father", s['father_name']),
                        _proRow(Icons.phone, "Phone", s['phone']),
                        _proRow(Icons.wc, "Gender", s['gender']),
                        _proRow(Icons.class_, "Class", s['class']),
                        _proRow(Icons.calendar_month, "Session", s['session']),
                        _proRow(Icons.access_time, "Time", s['time']),

                        const Divider(height: 25),

                        // ================= ADMISSION DATE + TIME =================
                        _proRow(Icons.date_range, "Admission Date", admissionDateText),
                        _proRow(Icons.access_time, "Admission Time", admissionTimeText),

                        const Divider(height: 25),

                        _proRow(Icons.attach_money, "Fee", "Rs ${s['fee'] ?? 0}"),
                        _proRow(Icons.payments, "Received",
                            "Rs ${s['received_money'] ?? 0}"),

                        _proRow(
                          Icons.warning_amber,
                          "Remaining",
                          "Rs ${(s['fee'] ?? 0) - (s['received_money'] ?? 0)}",
                          valueColor: Colors.red,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // ================= BUTTONS =================
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          icon: const Icon(Icons.picture_as_pdf),
                          label: const Text("PDF"),
                          onPressed: () => generatePdf(s),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          icon: const Icon(Icons.print),
                          label: const Text("PRINT"),
                          onPressed: () => printPdf(s),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// ================= ROW WIDGET =================
  Widget _proRow(IconData icon, String title, dynamic value,
      {Color valueColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.blue),
          const SizedBox(width: 8),
          Text(
            "$title:",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value.toString(),
              style: TextStyle(
                color: valueColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= LOGO
  Future<Uint8List> loadLogo() async {
    final url =
        "https://bdolifxxpnpnonwavhum.supabase.co/storage/v1/object/public/logos/WhatsApp%20Image%202026-05-03%20at%2012.18.19.jpeg";

    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return res.bodyBytes;
    } else {
      throw Exception("Logo load failed");
    }
  }

  // ================= PDF (FIXED FULL DETAIL + LOGO)


  Future<void> generatePdf(Map s) async {
    final pdf = pw.Document();
    final logo = await loadLogo();

    final now = DateTime.now();
    final date =
        "${now.day.toString().padLeft(2, '0')}/"
        "${now.month.toString().padLeft(2, '0')}/"
        "${now.year}";

    String safe(dynamic value) => value?.toString() ?? "";

    pw.Widget buildRow(String left, String right) {
      return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 6),
        child: pw.Row(
          children: [
            pw.Expanded(
              child: pw.Text(left,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.SizedBox(width: 10),
            pw.Expanded(child: pw.Text(right)),
          ],
        ),
      );
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(30),
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [

            // HEADER
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  width: 80,
                  height: 80,
                  child: pw.Image(pw.MemoryImage(logo)),
                ),
                pw.SizedBox(width: 15),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Afridi ENGLISH & IELTS STUDIO",
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        "Prepare, Perform, Prosper",
                        style: pw.TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 20),
            pw.Divider(),

            // TITLE
            pw.Center(
              child: pw.Text(
                "STUDENT RECEIPT",
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),

            pw.SizedBox(height: 20),

            // DETAILS
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(15),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(width: 1),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Column(
                children: [

                  buildRow(
                    "Name: ${safe(s['name'])}",
                    "Father: ${safe(s['father_name'])}",
                  ),

                  buildRow(
                    "Phone: ${safe(s['phone'])}",
                    "Gender: ${safe(s['gender'])}",
                  ),

                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 6),
                    child: pw.Row(
                      children: [
                        pw.Text("Address: ",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold)),
                        pw.Expanded(child: pw.Text(safe(s['address']))),
                      ],
                    ),
                  ),

                  buildRow(
                    "Course: ${safe(s['class'])}",
                    "Session: ${safe(s['session'])}",
                  ),

                  buildRow(
                    "Time: ${safe(s['time'])}",
                    "Fee: Rs ${s['fee'] ?? 0}",
                  ),

                  pw.Divider(),

                  buildRow(
                    "Received: Rs ${s['received_money'] ?? 0}",
                    "Remaining: Rs ${(s['fee'] ?? 0) - (s['received_money'] ?? 0)}",
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 30),

            // FOOTER
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  children: [
                    pw.Text(date),
                    pw.SizedBox(height: 5),
                    pw.Text("Date"),
                    pw.SizedBox(height: 20),
                    pw.Container(width: 100, height: 1),
                  ],
                ),
                pw.Column(
                  children: [
                    pw.Text("Authorized Signature"),
                    pw.SizedBox(height: 25),
                    pw.Container(width: 120, height: 1),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // ================= SAVE =================
    final pdfBytes = await pdf.save();

    if (kIsWeb) {
      // 🌐 WEB
      final blob = html.Blob([pdfBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      html.AnchorElement(href: url)
        ..setAttribute("download", "student_receipt.pdf")
        ..click();

      html.Url.revokeObjectUrl(url);
    } else {
      // 📱 MOBILE
      await Printing.sharePdf(
        bytes: pdfBytes,
        filename: "student_receipt.pdf",
      );
    }
  }

  // ================= PRINT (FIXED FULL)


  Future<void> printPdf(Map s) async {
    final pdf = pw.Document();
    final logo = await loadLogo();

    final now = DateTime.now();
    final date =
        "${now.day.toString().padLeft(2, '0')}/"
        "${now.month.toString().padLeft(2, '0')}/"
        "${now.year}";

    String safe(dynamic value) => value?.toString() ?? "";

    pw.Widget buildRow(String left, String right) {
      return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 6),
        child: pw.Row(
          children: [
            pw.Expanded(
              child: pw.Text(left,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.SizedBox(width: 10),
            pw.Expanded(child: pw.Text(right)),
          ],
        ),
      );
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(30),
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [

            // HEADER
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  width: 80,
                  height: 80,
                  child: pw.Image(pw.MemoryImage(logo)),
                ),
                pw.SizedBox(width: 15),
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Afridi ENGLISH & IELTS STUDIO",
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        "Prepare, Perform, Prosper",
                        style: pw.TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 20),
            pw.Divider(),

            // TITLE
            pw.Center(
              child: pw.Text(
                "STUDENT RECEIPT",
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),

            pw.SizedBox(height: 20),

            // DETAILS
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(15),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(width: 1),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Column(
                children: [

                  buildRow(
                    "Name: ${safe(s['name'])}",
                    "Father: ${safe(s['father_name'])}",
                  ),

                  buildRow(
                    "Phone: ${safe(s['phone'])}",
                    "Gender: ${safe(s['gender'])}",
                  ),

                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 6),
                    child: pw.Row(
                      children: [
                        pw.Text("Address: ",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold)),
                        pw.Expanded(child: pw.Text(safe(s['address']))),
                      ],
                    ),
                  ),

                  buildRow(
                    "Course: ${safe(s['class'])}",
                    "Session: ${safe(s['session'])}",
                  ),

                  buildRow(
                    "Time: ${safe(s['time'])}",
                    "Fee: Rs ${s['fee'] ?? 0}",
                  ),

                  pw.Divider(),

                  buildRow(
                    "Received: Rs ${s['received_money'] ?? 0}",
                    "Remaining: Rs ${(s['fee'] ?? 0) - (s['received_money'] ?? 0)}",
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 30),

            // FOOTER
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  children: [
                    pw.Text(date),
                    pw.SizedBox(height: 5),
                    pw.Text("Date"),
                    pw.SizedBox(height: 20),
                    pw.Container(width: 100, height: 1),
                  ],
                ),
                pw.Column(
                  children: [
                    pw.Text("Signature"),
                    pw.SizedBox(height: 25),
                    pw.Container(width: 120, height: 1),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final pdfBytes = await pdf.save();

    if (kIsWeb) {
      // 🌐 WEB → open PDF (user print manually)
      final blob = html.Blob([pdfBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.window.open(url, "_blank");
    } else {
      // 📱 MOBILE → print dialog
      await Printing.layoutPdf(
        onLayout: (format) async => pdfBytes,
      );
    }
  }
  // ================= ADD STUDENT (PRO + FIXED DROPDOWNS)
  void addStudentForm() {
    final name = TextEditingController();
    final father = TextEditingController();
    final phone = TextEditingController();
    final address = TextEditingController();
    final receivedMoney = TextEditingController();

    String? gender;
    String? selectedClass;
    String? selectedSession;
    String? selectedTime;
    int? selectedFee;

    // ================= FEES GENERATOR
    List<int> generateFees(int baseFee) {
      List<int> fees = [];

      for (int i = baseFee; i >= 1000; i -= 1000) {
        fees.add(i);
      }

      return fees;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xfff5f7ff),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {

            // ================= GET FEES
            List<int> feeList = [];

            if (selectedClass != null &&
                selectedSession != null &&
                selectedTime != null) {

              final course = courses.firstWhere(
                    (e) =>
                e['class'] == selectedClass &&
                    e['session'] == selectedSession &&
                    e['time'] == selectedTime,
                orElse: () => {},
              );

              final baseFee = course['fee'] ?? 0;

              feeList = generateFees(baseFee);
            }

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    const Text(
                      "ADD STUDENT",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ================= TEXTFIELDS

                    _field(name, "Name"),
                    _field(father, "Father"),
                    _field(phone, "Phone"),
                    _field(address, "Address"),

                    // ================= GENDER

                    _dropdown(
                      "Gender",
                      ["Male", "Female", "Other"],
                      gender,
                          (v) {
                        setModalState(() {
                          gender = v;
                        });
                      },
                    ),

                    // ================= CLASS

                    _dropdown(
                      "Class",
                      courses
                          .map((e) => e['class'])
                          .toSet()
                          .toList(),

                      selectedClass,

                          (v) {
                        setModalState(() {

                          selectedClass = v;

                          selectedSession = null;
                          selectedTime = null;
                          selectedFee = null;
                        });
                      },
                    ),

                    // ================= SESSION

                    if (selectedClass != null)
                      _dropdown(
                        "Session",

                        courses
                            .where(
                              (e) =>
                          e['class'] ==
                              selectedClass,
                        )
                            .map((e) => e['session'])
                            .toSet()
                            .toList(),

                        selectedSession,

                            (v) {
                          setModalState(() {

                            selectedSession = v;

                            selectedTime = null;
                            selectedFee = null;
                          });
                        },
                      ),

                    // ================= TIME

                    if (selectedSession != null)
                      _dropdown(
                        "Time",

                        courses
                            .where(
                              (e) =>
                          e['class'] ==
                              selectedClass &&
                              e['session'] ==
                                  selectedSession,
                        )
                            .map((e) => e['time'])
                            .toSet()
                            .toList(),

                        selectedTime,

                            (v) {
                          setModalState(() {

                            selectedTime = v;

                            selectedFee = null;
                          });
                        },
                      ),

                    // ================= FEES

                    if (selectedTime != null)
                      _dropdown(
                        "Fee",

                        feeList,

                        selectedFee,

                            (v) {
                          setModalState(() {
                            selectedFee = v;
                          });
                        },
                      ),

                    // ================= RECEIVED

                    _field(
                      receivedMoney,
                      "Received Money",
                    ),

                    const SizedBox(height: 20),

                    // ================= SAVE BUTTON

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),

                        onPressed: () async {

                          await supabase
                              .from('students')
                              .insert({

                            'name': name.text,

                            'father_name':
                            father.text,

                            'phone': phone.text,

                            'gender': gender,

                            'address':
                            address.text,

                            'class':
                            selectedClass,

                            'session':
                            selectedSession,

                            'time':
                            selectedTime,

                            'fee':
                            selectedFee ?? 0,

                            'received_money':
                            int.tryParse(
                              receivedMoney
                                  .text,
                            ) ??
                                0,

                            'created_at':
                            DateTime.now()
                                .toIso8601String(),
                          });

                          Navigator.pop(context);

                          fetchAll();

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Student Added",
                              ),
                            ),
                          );
                        },

                        child: const Text(
                          "SAVE STUDENT",
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

// ================= TEXTFIELD

  Widget _field(
      TextEditingController c,
      String label,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

// ================= DROPDOWN

  Widget _dropdown(
      String label,
      List items,
      dynamic value,
      Function(dynamic) onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: DropdownButtonFormField(
        value: value,

        items: items.map((e) {

          return DropdownMenuItem(
            value: e,
            child: Text("$e"),
          );

        }).toList(),

        onChanged: onChanged,

        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  // ================= UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Students")),

      floatingActionButton: FloatingActionButton(
        onPressed: addStudentForm,
        child: const Icon(Icons.add),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search student",
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStudents.length,
              itemBuilder: (_, i) {
                var s = filteredStudents[i];
                return Card(
                  child: ListTile(
                    title: Text(safe(s['name'])),
                    subtitle: Text("${safe(s['class'])}"),
                    trailing: Text("Rs ${s['received_money'] ?? 0}"),
                    onTap: () => viewStudent(s),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}// ========================= SEARCH

// =======================
// ATTENDANCE UI
// =======================

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List students = [];

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future fetch() async {
    final data = await supabase.from('students').select();
    setState(() => students = data);
  }

  Future mark(String id, String status) async {
    await supabase.from('attendance').insert({
      'student_id': id,
      'status': status,
      'date': DateTime.now().toIso8601String(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance")),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (_, i) {
          final s = students[i];
          return Card(
            child: ListTile(
              title: Text(s['name']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.check, color: Colors.green), onPressed: () => mark(s['id'], 'present')),
                  IconButton(icon: const Icon(Icons.close, color: Colors.red), onPressed: () => mark(s['id'], 'absent')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// =======================
// FEES UI
// =======================

class FeesPage extends StatefulWidget {
  const FeesPage({super.key});

  @override
  State<FeesPage> createState() => _FeesPageState();
}

class _FeesPageState extends State<FeesPage> {
  List students = [];

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future fetch() async {
    final data = await supabase.from('students').select();
    setState(() => students = data);
  }

  Future pay(String id) async {
    await supabase.from('fees').insert({
      'student_id': id,
      'amount': 1000,
      'status': 'paid',
      'month': DateTime.now().month.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fees")),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (_, i) {
          final s = students[i];
          return Card(
            child: ListTile(
              title: Text(s['name']),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () => pay(s['id']),
                child: const Text("Paid"),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),

      appBar: AppBar(
        title: const Text("Admin Panel"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // ================= ADMIN HEADER
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.indigo, Colors.blue],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.indigo),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Admin Panel",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Welcome back 👋",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ================= MODULES
              adminTile(context, Icons.people, "Manage Students",
                  const StudentsPage()),
              adminTile(context, Icons.school, "Manage Courses",
                  const CoursesPage()),
              adminTile(context, Icons.date_range, "Download Certificate ",
                  const CertifiactePage ()),
              adminTile(context, Icons.payments, "Institute Profile ",
                  const InstitutePage()),
              adminTile(context, Icons.schedule, "Condidates",
                  const CondidatesPage()),
              adminTile(context, Icons.calendar_month, "Class Routine",
                  const RoutinePage()),
              adminTile(context, Icons.download, "Download List",
                  const DownloadPage()),
              adminTile(context, Icons.bar_chart, " Student Reports",
                  const ReportsPage()),
              adminTile(context, Icons.bar_chart, "Fee Reports",
                  const FeeReport()),
              adminTile(context, Icons.bar_chart, "Remaining Fee",
                  const RemainingPage()),
              adminTile(context, Icons.bar_chart, "Report Expenses",
                  const ExpensesPage()),
              adminTile(context, Icons.bar_chart, "Sessions Report",
                  const SessionsPage()),
            ],
          ),
        ),
      ),
    );
  }

  Widget adminTile(
      BuildContext context,
      IconData icon,
      String title,
      Widget page,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.indigo.withOpacity(0.1),
              child: Icon(icon, color: Colors.indigo),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= COURSES


class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final supabase = Supabase.instance.client;

  List courses = [];
  List filtered = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  // ================= FETCH
  Future<void> fetchCourses() async {
    final data = await supabase
        .from('courses')
        .select()
        .order('created_at');

    setState(() {
      courses = data;
      filtered = data;
      loading = false;
    });
  }

  // ================= FEE GENERATOR
  // Example:
  // 8000 => 8000,7000,6000,5000,4000,3000,2000,1000

  List<int> generateFees(int baseFee) {
    List<int> fees = [];

    for (int value = baseFee; value >= 1000; value -= 1000) {
      fees.add(value);
    }

    return fees;
  }

  // ================= SEARCH
  void search(String value) {
    final result = courses.where((c) {
      final cls = (c['class'] ?? '').toString().toLowerCase();
      final session = (c['session'] ?? '').toString().toLowerCase();
      final time = (c['time'] ?? '').toString().toLowerCase();

      return cls.contains(value.toLowerCase()) ||
          session.contains(value.toLowerCase()) ||
          time.contains(value.toLowerCase());
    }).toList();

    setState(() => filtered = result);
  }

  // ================= ADD COURSE
  void showAdd() {
    final classCtrl = TextEditingController();
    final sessionCtrl = TextEditingController();
    final feeCtrl = TextEditingController();
    final timeCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const Text(
              "Add Course",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),

            const SizedBox(height: 20),

            input(
              classCtrl,
              "Class (e.g IELTS)",
              Icons.school,
            ),

            input(
              sessionCtrl,
              "Session",
              Icons.date_range,
            ),

            input(
              feeCtrl,
              "Base Fee",
              Icons.payments,
            ),

            input(
              timeCtrl,
              "Time",
              Icons.access_time,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                ),
                onPressed: () async {

                  if (classCtrl.text.isEmpty ||
                      sessionCtrl.text.isEmpty ||
                      feeCtrl.text.isEmpty ||
                      timeCtrl.text.isEmpty) {
                    return;
                  }

                  await supabase.from('courses').insert({

                    'class': classCtrl.text,

                    'session': sessionCtrl.text,

                    'fee':
                    int.tryParse(feeCtrl.text) ?? 0,

                    'time': timeCtrl.text,

                    'created_at':
                    DateTime.now()
                        .toIso8601String(),
                  });

                  Navigator.pop(context);

                  fetchCourses();

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Course Added",
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Save Course",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ================= INPUT
  Widget input(
      TextEditingController c,
      String label,
      IconData icon,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: TextField(
        controller: c,
        keyboardType: label.contains("Fee")
            ? TextInputType.number
            : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: Colors.indigo,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ================= COURSE CARD
  Widget courseCard(Map c) {

    final baseFee = c['fee'] ?? 0;

    final fees = generateFees(baseFee);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(0.06),
            blurRadius: 8,
          )
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          // ================= TOP ROW

          Row(
            children: [

              const CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Icon(
                  Icons.school,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  c['class'] ?? '',

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),

              // ================= DELETE BUTTON

              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),

                onPressed: () async {

                  final confirm =
                  await showDialog(

                    context: context,

                    builder: (_) => AlertDialog(

                      title:
                      const Text(
                        "Delete Course",
                      ),

                      content:
                      const Text(
                        "Are you sure you want to delete this course?",
                      ),

                      actions: [

                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                              false,
                            );
                          },
                          child:
                          const Text(
                            "Cancel",
                          ),
                        ),

                        ElevatedButton(
                          style:
                          ElevatedButton
                              .styleFrom(
                            backgroundColor:
                            Colors.red,
                          ),

                          onPressed: () {
                            Navigator.pop(
                              context,
                              true,
                            );
                          },

                          child:
                          const Text(
                            "Delete",
                          ),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {

                    await supabase
                        .from('courses')
                        .delete()
                        .eq(
                      'id',
                      c['id'],
                    );

                    fetchCourses();

                    ScaffoldMessenger.of(
                        context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Course Deleted",
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            "Session: ${c['session']}",
          ),

          Text(
            "Time: ${c['time']}",
          ),

          Text(
            "Base Fee: ${c['fee']}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          // ================= FEES

          const Text(
            "Available Fees",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),

          const SizedBox(height: 8),

          Wrap(
            spacing: 6,
            runSpacing: 6,

            children: fees.map((f) {

              return Chip(

                label: Text(
                  "$f",

                  style: const TextStyle(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                backgroundColor:
                Colors.indigo.shade50,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ================= UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      const Color(0xfff5f6fa),

      appBar: AppBar(
        title: const Text("Courses"),
        backgroundColor: Colors.indigo,
      ),

      floatingActionButton:
      FloatingActionButton(
        onPressed: showAdd,
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
      ),

      body: loading
          ? const Center(
        child:
        CircularProgressIndicator(),
      )
          : filtered.isEmpty
          ? const Center(
        child: Text(
          "No Courses Found",
        ),
      )
          : ListView.builder(
        itemCount:
        filtered.length,

        itemBuilder: (_, i) =>
            courseCard(
              filtered[i],
            ),
      ),
    );
  }
}
// ================= SESSIONS


class CertifiactePage extends StatefulWidget {
  const CertifiactePage({super.key});

  @override
  State<CertifiactePage> createState() => _CertifiactePageState();
}

class _CertifiactePageState extends State<CertifiactePage> {
  final supabase = Supabase.instance.client;

  List students = [];
  List filtered = [];

  Map<String, dynamic>? institute;   // ⭐ ADD INSTITUTE

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  // ================= FETCH ALL
  Future fetchAll() async {
    await fetchStudents();
    await fetchInstitute();
  }

  // ================= STUDENTS
  Future fetchStudents() async {
    final data = await supabase.from('students').select();

    setState(() {
      students = data;
      filtered = data;
    });
  }

  // ================= INSTITUTE
  Future fetchInstitute() async {
    final res = await supabase
        .from('institute_profile')
        .select()
        .maybeSingle();

    setState(() {
      institute = res;
    });
  }

  // ================= SEARCH
  void search(String value) {
    final v = value.toLowerCase();

    setState(() {
      filtered = students.where((s) {
        return (s['name'] ?? '')
            .toString()
            .toLowerCase()
            .contains(v);
      }).toList();
    });
  }

  // ================= CERTIFICATE


  Future<void> generateCertificate(
      Map student, [
        Map? institute,
      ]) async {

    final pdf = pw.Document();

    final s = Map<String, dynamic>.from(student);

    final inst = institute != null
        ? Map<String, dynamic>.from(institute)
        : {};

    String safe(value) => value?.toString() ?? "";

    final now = DateTime.now();

    final date =
        "${now.day.toString().padLeft(2, '0')}/"
        "${now.month.toString().padLeft(2, '0')}/"
        "${now.year}";

    final qrData = """
INSTITUTE: ${safe(inst['name'])}
STUDENT: ${safe(s['name'])}
FATHER: ${safe(s['father_name'])}
COURSE: ${safe(s['class'])}
PHONE: ${safe(s['phone'])}
DATE: $date
""";

    pdf.addPage(

      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,

        margin: const pw.EdgeInsets.all(20),

        build: (context) {

          return pw.Container(

            decoration: pw.BoxDecoration(

              border: pw.Border.all(
                color: PdfColors.deepOrange,
                width: 8,
              ),
            ),

            child: pw.Container(

              margin: const pw.EdgeInsets.all(10),

              decoration: pw.BoxDecoration(

                border: pw.Border.all(
                  color: PdfColors.amber,
                  width: 3,
                ),

                gradient: const pw.LinearGradient(
                  colors: [
                    PdfColors.white,
                    PdfColors.orange50,
                  ],
                ),
              ),

              child: pw.Padding(

                padding: const pw.EdgeInsets.all(35),

                child: pw.Column(

                  mainAxisAlignment:
                  pw.MainAxisAlignment.spaceBetween,

                  children: [

                    // ================= HEADER =================

                    pw.Column(

                      children: [

                        pw.Text(

                          safe(inst['name']).isEmpty
                              ? "AFRIDI ACADEMY"
                              : safe(inst['name']).toUpperCase(),

                          style: pw.TextStyle(
                            fontSize: 34,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.deepOrange,
                            letterSpacing: 3,
                          ),
                        ),

                        pw.SizedBox(height: 8),

                        pw.Text(

                          safe(inst['address']).isEmpty
                              ? "Academy Management System"
                              : safe(inst['address']),

                          style: pw.TextStyle(
                            fontSize: 12,
                            color: PdfColors.grey700,
                          ),
                        ),

                        pw.SizedBox(height: 25),

                        pw.Container(

                          padding: const pw.EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),

                          decoration: pw.BoxDecoration(

                            color: PdfColors.deepOrange,

                            borderRadius:
                            pw.BorderRadius.circular(10),
                          ),

                          child: pw.Text(

                            "CERTIFICATE OF COMPLETION",

                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 24,
                              fontWeight: pw.FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // ================= BODY =================

                    pw.Column(

                      children: [

                        pw.Text(

                          "THIS CERTIFICATE IS PROUDLY PRESENTED TO",

                          style: pw.TextStyle(
                            fontSize: 14,
                            letterSpacing: 2,
                            color: PdfColors.grey700,
                          ),
                        ),

                        pw.SizedBox(height: 25),

                        pw.Text(

                          safe(s['name']).toUpperCase(),

                          style: pw.TextStyle(
                            fontSize: 42,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.deepOrange,
                          ),
                        ),

                        pw.SizedBox(height: 10),

                        pw.Container(
                          width: 400,
                          height: 2,
                          color: PdfColors.amber,
                        ),

                        pw.SizedBox(height: 20),

                        pw.Text(

                          "S/O ${safe(s['father_name'])}",

                          style: pw.TextStyle(
                            fontSize: 15,
                            color: PdfColors.grey800,
                          ),
                        ),

                        pw.SizedBox(height: 25),

                        pw.Text(

                          "has successfully completed the professional course of",

                          style: pw.TextStyle(
                            fontSize: 15,
                            color: PdfColors.grey800,
                          ),
                        ),

                        pw.SizedBox(height: 20),

                        pw.Container(

                          padding:
                          const pw.EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 12,
                          ),

                          decoration: pw.BoxDecoration(

                            border: pw.Border.all(
                              color: PdfColors.amber,
                              width: 2,
                            ),

                            borderRadius:
                            pw.BorderRadius.circular(10),
                          ),

                          child: pw.Text(

                            safe(s['class']).toUpperCase(),

                            style: pw.TextStyle(
                              fontSize: 22,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.amber900,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),

                        pw.SizedBox(height: 30),

                        pw.Text(

                          "We appreciate your dedication and wish you a bright and successful future.",

                          textAlign: pw.TextAlign.center,

                          style: pw.TextStyle(
                            fontSize: 13,
                            color: PdfColors.grey700,
                            lineSpacing: 3,
                          ),
                        ),
                      ],
                    ),

                    // ================= FOOTER =================

                    pw.Row(

                      mainAxisAlignment:
                      pw.MainAxisAlignment.spaceBetween,

                      crossAxisAlignment:
                      pw.CrossAxisAlignment.end,

                      children: [

                        // DATE

                        pw.Column(

                          children: [

                            pw.Text(

                              date,

                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight:
                                pw.FontWeight.bold,
                              ),
                            ),

                            pw.SizedBox(height: 5),

                            pw.Container(
                              width: 120,
                              height: 1.5,
                              color: PdfColors.black,
                            ),

                            pw.SizedBox(height: 5),

                            pw.Text(

                              "DATE",

                              style: pw.TextStyle(
                                fontSize: 11,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),

                        // QR CODE

                        pw.Column(

                          children: [

                            pw.BarcodeWidget(
                              data: qrData,
                              barcode:
                              pw.Barcode.qrCode(),
                              width: 90,
                              height: 90,
                            ),

                            pw.SizedBox(height: 5),

                            pw.Text(

                              "Verification QR",

                              style: pw.TextStyle(
                                fontSize: 10,
                                color: PdfColors.grey700,
                              ),
                            ),
                          ],
                        ),

                        // SIGNATURE

                        pw.Column(

                          children: [

                            pw.Text(

                              "Director Signature",

                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight:
                                pw.FontWeight.bold,
                              ),
                            ),

                            pw.SizedBox(height: 25),

                            pw.Container(
                              width: 160,
                              height: 1.5,
                              color: PdfColors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    // ================= SAVE PDF =================

    final pdfBytes = await pdf.save();

    final blob = html.Blob(
      [pdfBytes],
      'application/pdf',
    );

    final url =
    html.Url.createObjectUrlFromBlob(blob);

    html.window.open(url, "_blank");
  }
  // ================= CARD
  Widget studentCard(Map s) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(s['name'] ?? ''),
        subtitle: Text("Class: ${s['class']}"),
        trailing: ElevatedButton(
          onPressed: () => generateCertificate(s),
          child: const Text("Generate"),
        ),
      ),
    );
  }

  // ================= UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Certificates"),
        backgroundColor: Colors.indigo,
      ),

      body: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (_, i) => studentCard(filtered[i]),
      ),
    );
  }
}// ================= FEE

class InstitutePage extends StatefulWidget {
  const InstitutePage({super.key});

  @override
  State<InstitutePage> createState() => _InstitutePageState();
}

class _InstitutePageState extends State<InstitutePage> {
  final supabase = Supabase.instance.client;

  Map<String, dynamic>? institute;
  List students = [];

  bool loading = true;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadAll();
  }

  // ================= LOAD DATA
  Future<void> loadAll() async {
    await fetchInstitute();
    await fetchStudents();

    setState(() => loading = false);
  }

  Future<void> fetchInstitute() async {
    final res = await supabase
        .from('institute_profile')
        .select()
        .maybeSingle();

    institute = res;
  }

  Future<void> fetchStudents() async {
    final res = await supabase.from('students').select();
    students = res;
  }

  // ================= SAVE INSTITUTE
  Future<void> saveInstitute() async {
    final data = {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'address': addressController.text.trim(),
    };

    if (institute == null) {
      await supabase.from('institute_profile').insert(data);
    } else {
      await supabase
          .from('institute_profile')
          .update(data)
          .eq('id', institute!['id']);
    }

    Navigator.pop(context);
    await loadAll();
  }

  // ================= OPEN FORM
  void openForm() {
    if (institute != null) {
      nameController.text = institute!['name'] ?? '';
      emailController.text = institute!['email'] ?? '';
      phoneController.text = institute!['phone'] ?? '';
      addressController.text = institute!['address'] ?? '';
    } else {
      nameController.clear();
      emailController.clear();
      phoneController.clear();
      addressController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Institute Name"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
            ),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: "Address"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveInstitute,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                minimumSize: const Size(double.infinity, 45),
              ),
              child: const Text("Save"),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ================= INSTITUTE CARD
  Widget instituteCard() {
    if (institute == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text("No Institute Added"),
        ),
      );
    }

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const Icon(Icons.school,
                size: 50, color: Colors.indigo),

            const SizedBox(height: 10),

            Text(
              institute!['name']?.toString() ?? '',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.email, size: 18),
                const SizedBox(width: 8),
                Text(institute!['email']?.toString() ?? '-'),
              ],
            ),

            Row(
              children: [
                const Icon(Icons.phone, size: 18),
                const SizedBox(width: 8),
                Text(institute!['phone']?.toString() ?? '-'),
              ],
            ),

            Row(
              children: [
                const Icon(Icons.location_on, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    institute!['address']?.toString() ?? '-',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= STUDENT CARD (FIXED INDEX ERROR)
  Widget studentCard(Map s) {
    String name = s['name']?.toString() ?? '';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            name.isNotEmpty ? name[0].toUpperCase() : '?',
          ),
        ),
        title: Text(name.isNotEmpty ? name : 'No Name'),
        subtitle: Text(
          "Class: ${s['class']?.toString() ?? '-'} | Phone: ${s['phone']?.toString() ?? '-'}",
        ),
      ),
    );
  }

  // ================= UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Institute Dashboard"),
        backgroundColor: Colors.indigo,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: openForm,
        child: const Icon(Icons.add),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [

            // INSTITUTE
            instituteCard(),

            const SizedBox(height: 20),

            const Text(
              "Students",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ...students.map((s) => studentCard(s)),
          ],
        ),
      ),
    );
  }
}
// ================= TIME


// ================= ROUTINE


class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  final supabase = Supabase.instance.client;

  List teachers = [];
  List routines = [];
  List filtered = [];

  bool loading = true;

  String? selectedTeacher;
  String? selectedSubject;
  String? selectedDay;
  String? selectedTime;

  List<String> subjectsList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // ================= FETCH
  Future<void> fetchData() async {
    setState(() => loading = true);

    final teacherData = await supabase.from('teachers').select();
    final routineData =
    await supabase.from('routine').select().order('created_at');

    setState(() {
      teachers = teacherData;
      routines = routineData;
      filtered = routineData;
      loading = false;
    });
  }

  // ================= SEARCH
  void search(String value) {
    final v = value.toLowerCase();

    setState(() {
      filtered = routines.where((r) {
        return (r['teacher'] ?? '').toString().toLowerCase().contains(v) ||
            (r['day'] ?? '').toString().toLowerCase().contains(v);
      }).toList();
    });
  }

  // ================= TEACHER SELECT
  void onTeacherSelect(String? value) {
    selectedTeacher = value;
    selectedSubject = null;
    subjectsList = [];

    final teacher = teachers.firstWhere(
          (t) => t['name'].toString() == value,
      orElse: () => {},
    );

    if (teacher.isNotEmpty && teacher['subject'] != null) {
      subjectsList = teacher['subject']
          .toString()
          .split(',')
          .map((e) => e.trim())
          .toList();
    }

    setState(() {});
  }

  // ================= SAVE
  Future<void> saveRoutine() async {
    if (selectedTeacher == null ||
        selectedSubject == null ||
        selectedDay == null ||
        selectedTime == null ||
        selectedTime!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fill all fields")),
      );
      return;
    }

    await supabase.from('routine').insert({
      'teacher': selectedTeacher,
      'subjects': [selectedSubject],
      'day': selectedDay,
      'time': selectedTime,
      'created_at': DateTime.now().toIso8601String(),
    });

    Navigator.pop(context);
    fetchData();
  }

  // ================= DELETE
  Future<void> deleteRoutine(int id) async {
    await supabase.from('routine').delete().eq('id', id);
    fetchData();
  }

  // ================= VIEW (PRO)
  void viewRoutine(Map r) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Routine Detail",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo)),

              const SizedBox(height: 15),

              info("Teacher", r['teacher']),
              info("Day", r['day']),
              info("Time", r['time']),
              info("Subjects", (r['subjects'] ?? []).join(", ")),
            ],
          ),
        ),
      ),
    );
  }

  Widget info(String t, dynamic v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text("$t: ",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.indigo)),
          Expanded(child: Text("$v")),
        ],
      ),
    );
  }

  // ================= PDF
  Future<void> generateWeeklyPdf() async {
    final pdf = pw.Document();

    Map<String, List> week = {
      "Monday": [],
      "Tuesday": [],
      "Wednesday": [],
      "Thursday": [],
      "Friday": [],
      "Saturday": [],
    };

    for (var r in routines) {
      if (week.containsKey(r['day'])) {
        week[r['day']]!.add(r);
      }
    }

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Container(
            padding: const pw.EdgeInsets.all(15),
            decoration: pw.BoxDecoration(
              gradient: pw.LinearGradient(
                colors: [PdfColors.indigo, PdfColors.blue],
              ),
            ),
            child: pw.Center(
              child: pw.Text("Weekly Routine",
                  style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 22,
                      fontWeight: pw.FontWeight.bold)),
            ),
          ),
          pw.SizedBox(height: 20),

          ...week.entries.map((e) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(e.key,
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold)),
                ...e.value.map((r) => pw.Text(
                    "${r['time']} - ${r['teacher']} (${(r['subjects'] ?? []).join(", ")})")),
                pw.Divider()
              ],
            );
          })
        ],
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  // ================= WEEK VIEW
  void showWeeklyView() {
    Map<String, List> week = {
      "Monday": [],
      "Tuesday": [],
      "Wednesday": [],
      "Thursday": [],
      "Friday": [],
      "Saturday": [],
    };

    for (var r in routines) {
      if (week.containsKey(r['day'])) {
        week[r['day']]!.add(r);
      }
    }

    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(15),
          height: 520,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Weekly Routine",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                    onPressed: generateWeeklyPdf,
                  )
                ],
              ),
              const Divider(),

              Expanded(
                child: ListView(
                  children: week.entries.map((e) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.key,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold)),
                        ...e.value.map((r) => Text(
                            "${r['time']} - ${r['teacher']} (${(r['subjects'] ?? []).join(", ")})")),
                        const Divider(),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= FORM
  void showAddForm() {
    final timeController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  dropdown(
                    "Teacher",
                    teachers.map((t) => t['name']).toList(),
                    selectedTeacher,
                        (v) => setStateModal(() => onTeacherSelect(v)),
                  ),
                  dropdown(
                    "Subject",
                    subjectsList,
                    selectedSubject,
                        (v) => setStateModal(() => selectedSubject = v),
                  ),
                  dropdown(
                    "Day",
                    ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],
                    selectedDay,
                        (v) => setStateModal(() => selectedDay = v),
                  ),
                  TextField(
                    controller: timeController,
                    decoration: const InputDecoration(labelText: "Time"),
                    onChanged: (v) => selectedTime = v,
                  ),
                  ElevatedButton(onPressed: saveRoutine, child: const Text("Save"))
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ================= DROPDOWN
  Widget dropdown(String hint, List items, String? value, Function(String?) onChanged) {
    return DropdownButton<String>(
      value: value,
      hint: Text(hint),
      isExpanded: true,
      items: items.map<DropdownMenuItem<String>>((e) {
        return DropdownMenuItem(value: e.toString(), child: Text(e.toString()));
      }).toList(),
      onChanged: onChanged,
    );
  }

  // ================= CARD (PRO)
  Widget routineCard(Map r) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xffeef1ff)],
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5))
        ],
      ),
      child: ListTile(
        title: Text("${r['day']} | ${r['time']}"),
        subtitle: Text("${r['teacher']}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: const Icon(Icons.visibility, color: Colors.indigo),
                onPressed: () => viewRoutine(r)),
            IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteRoutine(r['id'])),
          ],
        ),
      ),
    );
  }

  // ================= UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Routine"),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: showWeeklyView,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddForm,
        child: const Icon(Icons.add),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search...",
              ),
              onChanged: search,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, i) => routineCard(filtered[i]),
            ),
          ),
        ],
      ),
    );
  }
}
// ================= DOWNLOAD


class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  final supabase = Supabase.instance.client;

  List courses = [];
  List students = [];
  List filtered = [];

  String? selectedClass;
  String? selectedTime;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // ================= FETCH
  Future<void> fetchData() async {
    setState(() => loading = true);

    final courseData = await supabase.from('courses').select();
    final studentData = await supabase.from('students').select();

    setState(() {
      courses = courseData;
      students = studentData;
      filtered = [];
      loading = false;
    });
  }

  // ================= FILTER STUDENTS
  void searchStudents() {
    setState(() {
      filtered = students.where((s) {
        return s['class'] == selectedClass &&
            s['time'] == selectedTime;
      }).toList();
    });
  }

  // ================= PDF EXPORT
  Future<void> exportPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Students Report",
                style: pw.TextStyle(
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),

              pw.Text("Class: $selectedClass"),
              pw.Text("Time: $selectedTime"),

              pw.SizedBox(height: 20),

              pw.Table.fromTextArray(
                headers: ["Name", "Class", "Time"],
                data: filtered.map((s) {
                  return [
                    s['name'] ?? '',
                    s['class'] ?? '',
                    s['time'] ?? '',
                  ];
                }).toList(),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  // ================= DROPDOWN CLASS (FROM DB)
  List getClassList() {
    return courses.map((e) => e['class']).toSet().toList();
  }

  // ================= DROPDOWN TIME (FROM DB)
  List getTimeList() {
    if (selectedClass == null) return [];
    return courses
        .where((c) => c['class'] == selectedClass)
        .map((e) => e['time'])
        .toSet()
        .toList();
  }

  // ================= UI CARD
  Widget studentCard(Map s) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(s['name'] ?? ''),
        subtitle: Text("Class: ${s['class']} | Time: ${s['time']}"),
      ),
    );
  }

  // ================= DROPDOWN
  Widget dropdown(
      String hint,
      List items,
      String? value,
      Function(String?) onChanged,
      ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        hint: Text(hint),
        underline: const SizedBox(),
        items: items.map<DropdownMenuItem<String>>((e) {
          return DropdownMenuItem(
            value: e.toString(),
            child: Text(e.toString()),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  // ================= UI
  @override
  Widget build(BuildContext context) {
    final classList = getClassList();
    final timeList = getTimeList();

    return Scaffold(
      backgroundColor: const Color(0xfff5f7ff),

      appBar: AppBar(
        title: const Text("Download Reports"),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: exportPdf,
          )
        ],
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          const SizedBox(height: 10),

          // ================= CLASS (FROM DB)
          dropdown(
            "Select Class",
            classList,
            selectedClass,
                (v) {
              setState(() {
                selectedClass = v;
                selectedTime = null;
                filtered = [];
              });
            },
          ),

          // ================= TIME (FROM DB)
          dropdown(
            "Select Time",
            timeList,
            selectedTime,
                (v) {
              setState(() => selectedTime = v);
            },
          ),

          // ================= SEARCH BUTTON
          ElevatedButton.icon(
            onPressed: searchStudents,
            icon: const Icon(Icons.search),
            label: const Text("Search Students"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
            ),
          ),

          const SizedBox(height: 10),

          // ================= RESULT
          Expanded(
            child: filtered.isEmpty
                ? const Center(
              child: Text("No Students Found"),
            )
                : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, i) =>
                  studentCard(filtered[i]),
            ),
          ),
        ],
      ),
    );
  }
}
// ================= REPORTS


class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final supabase = Supabase.instance.client;

  List students = [];
  List teachers = [];
  List filteredStudents = [];
  List filteredTeachers = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  Future fetchReports() async {
    final studentData = await supabase.from('students').select();
    final teacherData = await supabase.from('teachers').select();

    setState(() {
      students = studentData;
      teachers = teacherData;
      filteredStudents = studentData;
      filteredTeachers = teacherData;
      loading = false;
    });
  }

  // ================= SEARCH
  void search(String value) {
    final v = value.toLowerCase();

    setState(() {
      filteredStudents = students.where((s) {
        return (s['name'] ?? '')
            .toString()
            .toLowerCase()
            .contains(v) ||
            (s['phone'] ?? '').toString().contains(value);
      }).toList();

      filteredTeachers = teachers.where((t) {
        return (t['name'] ?? '')
            .toString()
            .toLowerCase()
            .contains(v);
      }).toList();
    });
  }

  // ================= BEAUTIFUL VIEW
  void viewDetail(Map data, bool isStudent) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              colors: [Colors.white, Color(0xfff3f6ff)],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person, size: 50, color: Colors.indigo),
              const SizedBox(height: 10),

              Text(
                data['name'] ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Divider(),

              if (isStudent) ...[
                info("Class", data['class']),
                info("Session", data['session']),
                info("Time", data['time']),
                info("Fee", data['fee']),
                info("Phone", data['phone']),
              ] else ...[
                info("Subject", data['subject']),
                info("Salary", data['salary']),
                info("Timing", data['timing']),
              ],

              const SizedBox(height: 15),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                ),
                onPressed: () => generatePdf(data, isStudent),
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text("Export PDF"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget info(String t, dynamic v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$t: ",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text("$v")),
        ],
      ),
    );
  }

  // ================= PDF GENERATOR (PRO DESIGN)
  Future generatePdf(Map data, bool isStudent) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [

                // HEADER DESIGN
                pw.Container(
                  padding: const pw.EdgeInsets.all(12),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromInt(0xff3f51b5),
                    borderRadius: pw.BorderRadius.circular(10),
                  ),
                  child: pw.Text(
                    "Academy Report",
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),

                pw.SizedBox(height: 20),

                pw.Text(
                  data['name'] ?? '',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),

                pw.Divider(),

                if (isStudent) ...[
                  pdfRow("Class", data['class']),
                  pdfRow("Session", data['session']),
                  pdfRow("Time", data['time']),
                  pdfRow("Fee", data['fee']),
                  pdfRow("Phone", data['phone']),
                ] else ...[
                  pdfRow("Subject", data['subject']),
                  pdfRow("Salary", data['salary']),
                  pdfRow("Timing", data['timing']),
                ],

                pw.SizedBox(height: 20),

                pw.Text(
                  "Generated by Academy System",
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  pw.Widget pdfRow(String t, dynamic v) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        children: [
          pw.Text("$t: ",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text("$v"),
        ],
      ),
    );
  }

  // ================= CARD UI
  Widget card(Map data, bool isStudent) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: ListTile(
        title: Text(data['name'] ?? ''),
        subtitle: Text(isStudent
            ? "${data['class']} | ${data['session']}"
            : "${data['subject']}"),
        trailing: IconButton(
          icon: const Icon(Icons.visibility, color: Colors.indigo),
          onPressed: () => viewDetail(data, isStudent),
        ),
      ),
    );
  }

  // ================= UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7ff),

      appBar: AppBar(
        title: const Text("Reports"),
        backgroundColor: Colors.indigo,
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [

          // 🔍 SEARCH BOX
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: search,
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              children: [

                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Students",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),

                ...filteredStudents
                    .map((s) => card(s, true)),

                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Teachers",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),

                ...filteredTeachers
                    .map((t) => card(t, false)),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class CondidatesPage extends StatefulWidget {
  const CondidatesPage({super.key});

  @override
  State<CondidatesPage> createState() => _CondidatesPageState();
}

class _CondidatesPageState extends State<CondidatesPage> {
  final supabase = Supabase.instance.client;

  bool isLoggedIn = false;

  final passController = TextEditingController();
  bool loginLoading = false;

  List students = [];
  List filteredStudents = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
  }

  // ================= LOGIN
  Future login() async {
    setState(() => loginLoading = true);

    final res = await supabase
        .from('signin_db')
        .select()
        .eq('password', passController.text)
        .maybeSingle();

    setState(() => loginLoading = false);

    if (res != null) {
      setState(() => isLoggedIn = true);
      fetchStudents();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Wrong Password ❌")),
      );
    }
  }

  // ================= FETCH
  Future fetchStudents() async {
    final data = await supabase.from('students').select();

    setState(() {
      students = data;
      filteredStudents = data;
      loading = false;
    });
  }

  // ================= SEARCH (SAFE)
  void search(String value) {
    final v = value.toLowerCase();

    setState(() {
      filteredStudents = students.where((s) {
        return (s['name'] ?? '').toString().toLowerCase().contains(v) ||
            (s['subject'] ?? '').toString().toLowerCase().contains(v) ||
            (s['class'] ?? '').toString().toLowerCase().contains(v) ||
            (s['phone'] ?? '').toString().contains(v);
      }).toList();
    });
  }

  // ================= DELETE
  Future deleteStudent(dynamic id) async {
    await supabase.from('students').delete().eq('id', id);
    fetchStudents();
  }

  // ================= LOGIN UI
  Widget loginUI() {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock, size: 80, color: Colors.indigo),
              const SizedBox(height: 20),
              const Text(
                "Admin Login",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: loginLoading ? null : login,
                child: loginLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= SAFE CARD (FIXED ERROR HERE)
  Widget studentCard(Map s) {
    String name = (s['name'] ?? '').toString();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: const TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  name.isEmpty ? '-' : name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteStudent(s['id']),
              ),
            ],
          ),

          const SizedBox(height: 10),

          info("Subject", s['subject']),
          info("Class", s['class']),
          info("Phone", s['phone']),
        ],
      ),
    );
  }

  // ================= INFO ROW (SAFE)
  Widget info(String t, dynamic v) {
    return Row(
      children: [
        Text(
          "$t: ",
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.indigo),
        ),
        Expanded(child: Text("${v ?? '-'}")),
      ],
    );
  }

  // ================= MAIN UI
  Widget mainUI() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Management"),
        backgroundColor: Colors.indigo,

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: search,
              decoration: InputDecoration(
                hintText: "Search (subject, class, name)",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: filteredStudents.length,
        itemBuilder: (_, i) => studentCard(filteredStudents[i]),
      ),
    );
  }

  // ================= ROOT
  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? mainUI() : loginUI();
  }
}




class FeeReport extends StatefulWidget {
  const FeeReport({super.key});

  @override
  State<FeeReport> createState() => _FeeReportState();
}

class _FeeReportState extends State<FeeReport> {
  final supabase = Supabase.instance.client;

  Map<int, double> monthlyData = {}; // 1-12 months
  bool isLoading = true;

  int selectedYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    fetchYearlyData();
  }

  Future<void> fetchYearlyData() async {
    try {
      DateTime start = DateTime(selectedYear, 1, 1);
      DateTime end = DateTime(selectedYear + 1, 1, 1);

      final response = await supabase
          .from('students')
          .select('fee, created_at')
          .gte('created_at', start.toIso8601String())
          .lt('created_at', end.toIso8601String());

      Map<int, double> temp = {
        for (int i = 1; i <= 12; i++) i: 0.0
      };

      for (var item in response) {
        DateTime date = DateTime.parse(item['created_at']);
        int month = date.month;

        double fee = 0.0;
        var feeValue = item['fee'];

        if (feeValue is num) {
          fee = feeValue.toDouble();
        } else {
          fee = double.tryParse(feeValue.toString()) ?? 0.0;
        }

        temp[month] = temp[month]! + fee;
      }

      setState(() {
        monthlyData = temp;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() => isLoading = false);
    }
  }

  // 🔵 BAR CHART
  Widget buildBarChart() {
    return SizedBox(
      height: 250,
      child: BarChart(
        BarChartData(
          barGroups: monthlyData.entries.map((e) {
            return BarChartGroupData(
              x: e.key,
              barRods: [
                BarChartRodData(toY: e.value, width: 12),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  // 🟢 PIE CHART
  Widget buildPieChart() {
    return SizedBox(
      height: 250,
      child: PieChart(
        PieChartData(
          sections: monthlyData.entries
              .where((e) => e.value > 0)
              .map((e) {
            return PieChartSectionData(
              value: e.value,
              title: DateFormat.MMM().format(DateTime(0, e.key)),
              radius: 60,
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fee Report"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // 🔽 YEAR DROPDOWN
            DropdownButton<int>(
              value: selectedYear,
              items: List.generate(5, (index) {
                int year = DateTime.now().year - index;
                return DropdownMenuItem(
                  value: year,
                  child: Text("$year"),
                );
              }),
              onChanged: (value) {
                selectedYear = value!;
                isLoading = true;
                setState(() {});
                fetchYearlyData();
              },
            ),

            const SizedBox(height: 20),

            // 📊 BAR CHART
            const Text("Monthly Fee (Bar Chart)",
                style:
                TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            buildBarChart(),

            const SizedBox(height: 20),

            // 🟢 PIE CHART
            const Text("Distribution (Pie Chart)",
                style:
                TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            buildPieChart(),

            const SizedBox(height: 20),

            // 📋 MONTH LIST
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 12,
              itemBuilder: (context, index) {
                int month = index + 1;
                double fee = monthlyData[month] ?? 0;

                return ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: Text(
                    DateFormat.MMMM().format(DateTime(0, month)),
                  ),
                  trailing: Text(
                    "Rs. ${fee.toStringAsFixed(0)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}




class RemainingPage extends StatefulWidget {
  const RemainingPage({super.key});

  @override
  State<RemainingPage> createState() => _RemainingPageState();
}

class _RemainingPageState extends State<RemainingPage> {
  final supabase = Supabase.instance.client;

  List students = [];
  List filtered = [];

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  // ================= FETCH DATA
  Future fetchStudents() async {
    final data = await supabase.from('students').select();

    setState(() {
      students = data;

      filtered = students.where((s) {
        int fee = (s['fee'] ?? 0);
        int paid = (s['received_money'] ?? 0);
        return fee > paid; // only remaining
      }).toList();
    });
  }

  // ================= SEARCH
  void search(String value) {
    setState(() {
      filtered = students.where((s) {
        int fee = (s['fee'] ?? 0);
        int paid = (s['received_money'] ?? 0);

        return fee > paid &&
            (s['name'] ?? '')
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase());
      }).toList();
    });
  }

  // ================= TOGGLE PAID / UNPAID WITH POPUP
  void togglePayment(Map s) {
    int fee = (s['fee'] ?? 0);
    int paid = (s['received_money'] ?? 0);
    bool isPaid = paid >= fee;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(isPaid ? "Mark as Unpaid?" : "Mark as Paid?"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Name: ${s['name']}"),
            Text("Class: ${s['class']}"),
            Text("Fee: $fee"),
            Text("Paid: $paid"),
            Text("Remaining: ${fee - paid}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isPaid ? Colors.red : Colors.green,
            ),
            onPressed: () async {
              Navigator.pop(context);

              await supabase.from('students').update({
                'received_money': isPaid ? 0 : fee,
              }).eq('id', s['id']);

              fetchStudents();
            },
            child: Text(isPaid ? "Mark Unpaid" : "Mark Paid"),
          ),
        ],
      ),
    );
  }

  // ================= CARD UI
  Widget studentCard(Map s) {
    int fee = (s['fee'] ?? 0);
    int paid = (s['received_money'] ?? 0);
    int remaining = fee - paid;

    bool isPaid = remaining <= 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // HEADER
          Row(
            children: [
              CircleAvatar(
                backgroundColor: isPaid ? Colors.green : Colors.red,
                child: Text(
                  (s['name'] ?? '').isNotEmpty ? s['name'][0] : "?",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  s['name'] ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // DETAILS
          Text("Class: ${s['class'] ?? ''}"),
          Text("Fee: $fee"),
          Text("Paid: $paid"),

          Text(
            "Remaining: $remaining",
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            isPaid ? "PAID ✔" : "UNPAID ❌",
            style: TextStyle(
              color: isPaid ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                isPaid ? Colors.red : Colors.green,
              ),
              icon: Icon(isPaid ? Icons.undo : Icons.check),
              label: Text(isPaid ? "Mark Unpaid" : "Mark Paid"),
              onPressed: () => togglePayment(s),
            ),
          )
        ],
      ),
    );
  }

  // ================= UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Remaining Fee"),
        backgroundColor: Colors.indigo,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: search,
              decoration: InputDecoration(
                hintText: "Search student...",
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),

      body: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (_, i) => studentCard(filtered[i]),
      ),
    );
  }
}



class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final supabase = Supabase.instance.client;

  List expenses = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchExpenses();
  }

  Future fetchExpenses() async {
    final data = await supabase
        .from('expenses')
        .select()
        .order('created_at', ascending: false);

    setState(() {
      expenses = data;
      loading = false;
    });
  }

  Future deleteExpense(int id) async {
    await supabase.from('expenses').delete().eq('id', id);
    fetchExpenses();
  }

  // ================= PIE CHART DATA
  Map<String, double> getPieData() {
    Map<String, double> map = {};

    for (var e in expenses) {
      String key = e['purpose'] ?? "Other";
      double value = (e['amount'] ?? 0).toDouble();

      map[key] = (map[key] ?? 0) + value;
    }

    return map;
  }

  // ================= MONTHLY GRAPH DATA
  List<FlSpot> getMonthlyData() {
    Map<int, double> monthMap = {};

    for (var e in expenses) {
      DateTime date = DateTime.parse(e['created_at']);
      int month = date.month;
      double amount = (e['amount'] ?? 0).toDouble();

      monthMap[month] = (monthMap[month] ?? 0) + amount;
    }

    return List.generate(12, (i) {
      return FlSpot(i.toDouble(), (monthMap[i + 1] ?? 0));
    });
  }

  // ================= EXPENSE CARD
  Widget expenseCard(Map e) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.remove_circle, color: Colors.red, size: 30),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e['purpose'] ?? "",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat("dd MMM yyyy").format(
                    DateTime.parse(e['created_at']),
                  ),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          Text(
            "Rs ${e['amount']}",
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red),
          ),

          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => deleteExpense(e['id']),
          )
        ],
      ),
    );
  }

  // ================= PIE CHART
  Widget pieChart() {
    final data = getPieData();

    return SizedBox(
      height: 220,
      child: PieChart(
        PieChartData(
          sections: data.entries.map((e) {
            return PieChartSectionData(
              value: e.value,
              title: e.key,
              radius: 60,
              color: Colors.redAccent,
            );
          }).toList(),
        ),
      ),
    );
  }

  // ================= LINE CHART
  Widget lineChart() {
    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(show: false),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: getMonthlyData(),
              isCurved: true,
              color: Colors.red,
              barWidth: 3,
              dotData: FlDotData(show: false),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double total = expenses.fold(
        0, (sum, e) => sum + (e['amount'] ?? 0));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Expense Report"),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [

            // ================= TOTAL CARD
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.deepOrange],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Expenses",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Rs $total",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ================= PIE CHART
            const Text("Expense Breakdown",
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            pieChart(),

            const SizedBox(height: 10),

            // ================= LINE CHART
            const Text("Monthly Trend",
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            lineChart(),

            const SizedBox(height: 10),

            // ================= LIST
            const Text("All Expenses",
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: expenses.length,
              itemBuilder: (context, i) {
                return expenseCard(expenses[i]);
              },
            ),
          ],
        ),
      ),
    );
  }
}


class SessionsPage extends StatefulWidget {
  const SessionsPage({super.key});

  @override
  State<SessionsPage> createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  final supabase = Supabase.instance.client;

  List students = [];
  List filtered = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // ================= FETCH
  Future fetchData() async {
    final data = await supabase.from('students').select();

    setState(() {
      students = data;
      filtered = data;
      loading = false;
    });
  }

  // ================= SEARCH
  void search(String value) {
    setState(() {
      filtered = students.where((s) {
        return (s['name'] ?? '')
            .toString()
            .toLowerCase()
            .contains(value.toLowerCase());
      }).toList();
    });
  }

  // ================= PARSE SESSION (MONTHS / YEAR)
  int parseSessionMonths(String session) {
    session = session.toLowerCase();

    if (session.contains("year")) {
      // 1 year = 12 months
      return 12;
    }

    // Example: "2 months", "5 months"
    final number = RegExp(r'\d+').firstMatch(session);
    if (number != null) {
      return int.parse(number.group(0)!);
    }

    return 1; // default
  }

  // ================= END DATE CALCULATION
  DateTime getEndDate(DateTime start, int months) {
    return DateTime(start.year, start.month + months, start.day);
  }

  // ================= STATUS
  bool isEnded(Map s) {
    try {
      DateTime start = DateTime.parse(s['start_date'].toString());
      int months = parseSessionMonths(s['session'] ?? "1 month");

      DateTime end = getEndDate(start, months);

      return DateTime.now().isAfter(end);
    } catch (e) {
      return false;
    }
  }

  // ================= CARD UI
  Widget studentCard(Map s) {
    DateTime start =
        DateTime.tryParse(s['start_date'] ?? '') ?? DateTime.now();

    int months = parseSessionMonths(s['session'] ?? "1 month");

    DateTime end = getEndDate(start, months);

    bool ended = isEnded(s);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // NAME + STATUS
          Row(
            children: [
              CircleAvatar(
                backgroundColor: ended ? Colors.red : Colors.green,
                child: Text(
                  (s['name'] ?? '').isNotEmpty ? s['name'][0] : '?',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  s['name'] ?? '',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: ended ? Colors.red : Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  ended ? "Completed" : "Active",
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),

          const SizedBox(height: 10),

          // DETAILS
          Text("Class: ${s['class'] ?? ''}"),
          Text("Session: ${s['session'] ?? ''}"),
          Text("Time: ${s['time'] ?? ''}"),

          const Divider(),

          // START DATE
          Text(
            "Start Date: ${start.toLocal().toString().split(' ')[0]}",
          ),

          // END DATE
          Text(
            "End Date: ${end.toLocal().toString().split(' ')[0]}",
          ),

          const SizedBox(height: 6),

          Text(
            ended ? "Session Finished" : "Session Running",
            style: TextStyle(
              color: ended ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ================= UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sessions Report"),
        backgroundColor: Colors.indigo,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: search,
              decoration: InputDecoration(
                hintText: "Search student...",
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (_, i) => studentCard(filtered[i]),
      ),
    );
  }
}
