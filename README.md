# Coinstar iOS

## 1. Title & Description

Coinstar is a SwiftUI iOS application built with a feature-first Clean
Architecture. The codebase is structured for independent features,
testability, and future growth. Current reference feature:
**Onboarding**.


## 2. Tech Stack

-   Language: Swift
-   UI: SwiftUI
-   Observation: Swift Observation (`@Observable`)
-   Networking: Foundation / URLSession
-   Concurrency: Swift Concurrency (`async/await`)
-   Unit testing: Apple Swift Testing (`import Testing`)
-   Architecture support: Protocol-oriented abstractions + dependency
    injection

## 3. Architecture & Design Patterns

-   **Feature-first:** each feature owns Presentation, Domain, Data, and
    Builder.
-   **Clean Architecture:** Presentation → Domain; Data implements
    Domain contracts.
-   **MVVM:** View renders state; ViewModel owns UI state and UI
    actions.
-   **Repository Pattern:** Domain depends on repository protocols.
-   **Data Source Pattern:** local/remote providers are replaceable.
-   **Dependency Injection:** AppContainer provides shared
    infrastructure; feature Builders create feature-specific objects.
-   **Composition Root:** AppContainer and feature Builders control
    object creation.
-   **SOLID:** especially SRP, DIP, OCP, ISP, and LSP.
-   **OOP + POP:** composition, encapsulation, protocols, abstractions,
    and polymorphism.

## 4. New Feature Implementation Rules

1.  Create the feature under `Features/<FeatureName>/`.
2.  Use:
    -   `Presentation/`
    -   `Domain/`
    -   `Data/`
    -   `<FeatureName>Builder.swift`
3.  Keep SwiftUI code inside Presentation.
4.  Keep UI state and UI actions inside the ViewModel.
5.  Put business/application rules in UseCases.
6.  Define repository protocols in Domain.
7.  Put repository implementations in Data.
8.  Keep API/local models as DTOs; map DTOs to Domain models.
9.  Keep local and remote access behind DataSource protocols.
10. Reuse `Core` infrastructure instead of duplicating networking
    utilities.
11. Do not put feature-specific dependencies in `AppContainer`.
12. Do not create dependencies inside Views or ViewModels; inject them.
13. Prefer `async/await` for asynchronous work.
14. Protect UI state with `@MainActor` where required.
15. Model loading, success, and failure states explicitly.
16. Avoid unnecessary abstractions; add a UseCase when
    application/business behavior exists.
17. Add unit tests for every new Domain/Data/ViewModel behavior.
18. Prefer mocks through protocols; avoid real networking in unit tests.
19. Keep tests focused on behavior and architectural contracts, not
    implementation details.
20. Update documentation when adding shared infrastructure or changing
    architecture.

## 5. GitHub Branching Strategy

-   `main` --- stable/releasable code.
-   `develop` --- integration branch when the team uses a pre-release
    flow.
-   `feature/<name>` --- new feature work.
-   `bugfix/<name>` --- non-release bug fixes.
-   `hotfix/<name>` --- urgent production fixes.
-   Keep branches short-lived and focused.
-   Rebase/update from the target branch before opening the PR when
    appropriate.

## 6. GitHub Strategy

-   Every feature/bugfix goes through a Pull Request.
-   Keep one logical change per PR.
-   PR must include implementation + relevant unit tests.
-   Require code review before merging protected branches.
-   Do not commit secrets, credentials, generated build products, or
    local configuration.
-   Use clear commit messages and PR descriptions.
-   Prefer small, reviewable commits over large mixed changes.
-   Delete merged feature branches.

## 7. Images / Architecture

<img width="1536" height="1024" alt="Clean-MVVM" src="https://github.com/user-attachments/assets/febe72bb-11e8-4c27-a2ab-a9beba35fd95" />

## Quick Dependency Rule

`Presentation → Domain ← Data` `Core → shared infrastructure`
`AppContainer → shared dependencies`
`FeatureBuilder → feature object creation`

## Quick Ownership Rule

-   AppContainer owns app-wide infrastructure.
-   Feature Builder creates feature dependencies.
-   View owns/retains its ViewModel through SwiftUI state.
-   ViewModel owns its UseCase.
-   UseCase owns its repository abstraction.
-   Repository owns/uses its DataSource.

## Before Opening a PR

-   Build succeeds.
-   Swift Testing suite passes.
-   New behavior has tests.
-   No feature-specific dependency was added to AppContainer.
-   Architecture boundaries are preserved.
-   No unnecessary framework or abstraction was introduced.
