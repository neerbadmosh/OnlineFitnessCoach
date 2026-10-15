package com.fitness.tracker.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fitness.tracker.model.User;
import com.fitness.tracker.model.Workout;
import com.fitness.tracker.service.WorkoutService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/workout")
public class WorkoutController {

	@Autowired
	private WorkoutService workoutService;

	// ==================== LOG WORKOUT ====================

	// Show log workout form
	@GetMapping("/log")
	public String showLogWorkoutForm(HttpSession session, Model model) {
		// Check if user is logged in
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		if (loggedInUser == null) {
			return "redirect:/login";
		}

		model.addAttribute("workout", new Workout());
		return "log-workout";
	}

	// Handle workout submission
	@PostMapping("/log")
	public String logWorkout(@Valid @ModelAttribute("workout") Workout workout, BindingResult result,
			HttpSession session, Model model, RedirectAttributes redirectAttributes) {

		// Check if user is logged in
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		if (loggedInUser == null) {
			return "redirect:/login";
		}

		// Check for validation errors
		if (result.hasErrors()) {
			return "log-workout";
		}

		try {
			// Set the user
			workout.setUser(loggedInUser);

			// Save workout
			workoutService.saveWorkout(workout);

			// Add success message
			redirectAttributes.addFlashAttribute("successMessage", "✅ Workout logged successfully!");

			return "redirect:/workout/history";

		} catch (Exception e) {
			model.addAttribute("errorMessage", "❌ Failed to log workout. Please try again.");
			e.printStackTrace(); // For debugging
			return "log-workout";
		}
	}

	// ==================== WORKOUT HISTORY ====================

	// Show workout history
	@GetMapping("/history")
	public String showWorkoutHistory(HttpSession session, Model model) {
		// Check if user is logged in
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		if (loggedInUser == null) {
			return "redirect:/login";
		}

		// Get all workouts for user
		List<Workout> workouts = workoutService.getAllWorkoutsByUser(loggedInUser);

		model.addAttribute("workouts", workouts);
		model.addAttribute("totalWorkouts", workouts.size());

		return "workout-history";
	}

	// ==================== VIEW WORKOUT ====================

	// View single workout details
	@GetMapping("/view/{id}")
	public String viewWorkout(@PathVariable("id") Long workoutId, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {

		// Check if user is logged in
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		if (loggedInUser == null) {
			return "redirect:/login";
		}

		// Get workout by ID
		Optional<Workout> workoutOpt = workoutService.getWorkoutById(workoutId);

		if (workoutOpt.isPresent()) {
			Workout workout = workoutOpt.get();

			// Security check: Verify workout belongs to logged-in user
			if (!workout.getUser().getUserId().equals(loggedInUser.getUserId())) {
				redirectAttributes.addFlashAttribute("errorMessage",
						"⚠️ You don't have permission to view this workout.");
				return "redirect:/workout/history";
			}

			// Add workout to model
			model.addAttribute("workout", workout);
			return "workout-detail";

		} else {
			// Workout not found
			redirectAttributes.addFlashAttribute("errorMessage", "❌ Workout not found.");
			return "redirect:/workout/history";
		}
	}

	// ==================== EDIT WORKOUT ====================

	// Show edit workout form
	@GetMapping("/edit/{id}")
	public String showEditWorkoutForm(@PathVariable("id") Long workoutId, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {

		// Check if user is logged in
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		if (loggedInUser == null) {
			return "redirect:/login";
		}

		// Get workout by ID
		Optional<Workout> workoutOpt = workoutService.getWorkoutById(workoutId);

		if (workoutOpt.isPresent()) {
			Workout workout = workoutOpt.get();

			// Security check: Verify workout belongs to logged-in user
			if (!workout.getUser().getUserId().equals(loggedInUser.getUserId())) {
				redirectAttributes.addFlashAttribute("errorMessage",
						"⚠️ You don't have permission to edit this workout.");
				return "redirect:/workout/history";
			}

			// Add workout to model for form
			model.addAttribute("workout", workout);
			return "edit-workout";

		} else {
			// Workout not found
			redirectAttributes.addFlashAttribute("errorMessage", "❌ Workout not found.");
			return "redirect:/workout/history";
		}
	}

	// Handle workout update
	@PostMapping("/update/{id}")
	public String updateWorkout(@PathVariable("id") Long workoutId, @Valid @ModelAttribute("workout") Workout workout,
			BindingResult result, HttpSession session, Model model, RedirectAttributes redirectAttributes) {

		// Check if user is logged in
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		if (loggedInUser == null) {
			return "redirect:/login";
		}

		// Check for validation errors
		if (result.hasErrors()) {
			workout.setWorkoutId(workoutId); // Keep the ID for form
			return "edit-workout";
		}

		// Get existing workout from database
		Optional<Workout> existingWorkoutOpt = workoutService.getWorkoutById(workoutId);

		if (!existingWorkoutOpt.isPresent()) {
			redirectAttributes.addFlashAttribute("errorMessage", "❌ Workout not found.");
			return "redirect:/workout/history";
		}

		Workout existingWorkout = existingWorkoutOpt.get();

		// Security check: Verify workout belongs to logged-in user
		if (!existingWorkout.getUser().getUserId().equals(loggedInUser.getUserId())) {
			redirectAttributes.addFlashAttribute("errorMessage", "⚠️ You don't have permission to edit this workout.");
			return "redirect:/workout/history";
		}

		try {
			// Set the ID and user (preserve these from existing workout)
			workout.setWorkoutId(workoutId);
			workout.setUser(loggedInUser);
			workout.setCreatedAt(existingWorkout.getCreatedAt()); // Preserve creation time

			// Update workout
			workoutService.updateWorkout(workout);

			// Add success message
			redirectAttributes.addFlashAttribute("successMessage", "✅ Workout updated successfully!");

			return "redirect:/workout/view/" + workoutId;

		} catch (Exception e) {
			model.addAttribute("errorMessage", "❌ Failed to update workout. Please try again.");
			workout.setWorkoutId(workoutId);
			e.printStackTrace(); // For debugging
			return "edit-workout";
		}
	}

	// ==================== DELETE WORKOUT ====================

	// Delete workout
	@GetMapping("/delete/{id}")
	public String deleteWorkout(@PathVariable("id") Long workoutId, HttpSession session,
			RedirectAttributes redirectAttributes) {

		// Check if user is logged in
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		if (loggedInUser == null) {
			return "redirect:/login";
		}

		// Get workout by ID
		Optional<Workout> workoutOpt = workoutService.getWorkoutById(workoutId);

		if (workoutOpt.isPresent()) {
			Workout workout = workoutOpt.get();

			// Security check: Verify workout belongs to logged-in user
			if (!workout.getUser().getUserId().equals(loggedInUser.getUserId())) {
				redirectAttributes.addFlashAttribute("errorMessage",
						"⚠️ You don't have permission to delete this workout.");
				return "redirect:/workout/history";
			}

			try {
				// Delete workout
				workoutService.deleteWorkout(workoutId);

				// Add success message
				redirectAttributes.addFlashAttribute("successMessage", "✅ Workout deleted successfully!");

			} catch (Exception e) {
				redirectAttributes.addFlashAttribute("errorMessage", "❌ Failed to delete workout. Please try again.");
				e.printStackTrace(); // For debugging
			}

		} else {
			// Workout not found
			redirectAttributes.addFlashAttribute("errorMessage", "❌ Workout not found.");
		}

		return "redirect:/workout/history";
	}
}