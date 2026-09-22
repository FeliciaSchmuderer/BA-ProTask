import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/todoList_startscreen/todo_item.dart';
import 'package:protask_app/todo_questionnaire/todo_questionnaire_screen.dart';

// navigation animation for TodoQuestionnaire
class TodoQuestionnaireRoute {
  static Route<void> create({TodoItem? todo}) {
    return PageRouteBuilder(
      // animation
      transitionDuration: const Duration(milliseconds: 250),
      reverseTransitionDuration: const Duration(milliseconds: 200),

      // builds questionnaire screen with rounded corners
      pageBuilder: (context, animation, secondaryAnimation) {
        return Material(
          color: AppThemeConstants.backgroundColor,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(40),
            ),
            child: TodoQuestionnaireScreen(
              todo: todo,
            ),
          ),
        );
      },

      // slides questionnaire in from the bottom
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          ),
        );

        return SlideTransition(
          position: slideAnimation,
          child: child,
        );
      },
    );
  }
}
