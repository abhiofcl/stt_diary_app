import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiaryCard extends StatelessWidget {
  const DiaryCard({super.key, required this.note});
  final note;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.parse(note.date);
    // String formattedDate = DateFormat('MMM').format(now);
    String day = DateFormat('dd').format(now);
    String monthName = DateFormat('MMMM').format(now);
    String year = DateFormat('yyyy').format(now);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Theme.of(context).primaryColor.withOpacity(.6),
            spreadRadius: 2,
            blurRadius: 5,
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      monthName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      day,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      year,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    note.content,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
