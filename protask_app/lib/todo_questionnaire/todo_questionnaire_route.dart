import 'package:flutter/material.dart';
import 'package:protask_app/constants/app_theme_constants.dart';
import 'package:protask_app/todo_questionnaire/todo_questionnaire_screen.dart';

// navigation animation to TodoQuestionnaire
class TodoQuestionnaireRoute {
  static Route<void> create() {
    return PageRouteBuilder(
      
      
      transitionDuration: const Duration(milliseconds: 250),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Material(color: AppThemeConstants.backgroundColor,
        
        
        child: const ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
          child: TodoQuestionnaireScreen(),
        ),
        );
      },
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
