// Import and register all your controllers from the importmap under controllers/*
import { application } from "controllers/application";
import NotificationController from './notification_controller';

// Eager load controllers from the specified directories
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";

eagerLoadControllersFrom("controllers", application);
// eagerLoadControllersFrom("components", application);

// Register controllers with the application
application.register("notification", NotificationController);
application.register("product", ProductController);
