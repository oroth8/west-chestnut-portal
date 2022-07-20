// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application";
// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
import Dropdown from 'stimulus-dropdown';

eagerLoadControllersFrom("controllers", application);

// ./bin/importmap pin stimulus-dropdown
application.register('dropdown', Dropdown)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
