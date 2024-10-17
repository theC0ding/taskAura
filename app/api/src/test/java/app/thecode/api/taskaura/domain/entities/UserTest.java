package app.thecode.api.taskaura.domain.entities;

import app.thecode.api.taskaura.domain.enums.Role;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

class UserTest {

    @Nested
    class UserCreation {

        @Test
        void shouldCreateUserWithConstructor() {
            UUID userId = UUID.randomUUID();
            User newUser = new User(userId, "user@example.com", "securePass", Role.ADMIN);

            assertEquals(userId, newUser.getId());
            assertEquals("user@example.com", newUser.email());
            assertEquals("securePass", newUser.password());
            assertEquals(Role.ADMIN, newUser.role());
        }

        @Test
        void shouldCreateUserWithFactoryMethod() {
            User createdUser = User.create("newuser@example.com", "newPassword", Role.USER);

            assertNotNull(createdUser.getId()); // Should have a non-null, random UUID
            assertEquals("newuser@example.com", createdUser.email());
            assertEquals("newPassword", createdUser.password());
            assertEquals(Role.USER, createdUser.role());
        }
    }

    @Nested
    class UserModification {

        private User user;

        @BeforeEach
        public void setup() {
            user = new User(UUID.randomUUID(), "test@example.com", "password123", Role.USER);
        }

        @Nested
        class EmailManagement {

            @Test
            void shouldChangeUserEmail() {
                String newEmail = "updated@example.com";
                user.changeEmail(newEmail);

                assertEquals(newEmail, user.email());
            }

            @Test
            void shouldVerifyIfEmailIsCorrect() {
                assertTrue(user.isEmailCorrect("test@example.com"));
                assertFalse(user.isEmailCorrect("wrong@example.com"));
            }
        }

        @Nested
        class PasswordManagement {

            @Test
            void shouldChangeUserPassword() {
                String newPassword = "newPassword123";
                user.changePassword(newPassword);

                assertEquals(newPassword, user.password());
            }

            @Test
            void shouldVerifyIfPasswordIsCorrect() {
                assertTrue(user.isPasswordCorrect("password123"));
                assertFalse(user.isPasswordCorrect("wrongPassword"));
            }
        }

        @Nested
        class RoleManagement {

            @Test
            void shouldChangeUserRole() {
                Role newRole = Role.ADMIN;
                user.changeRole(newRole);

                assertEquals(newRole, user.role());
            }
        }

        @Nested
        class UserInformation {

            @Test
            void shouldGenerateCorrectToStringRepresentation() {
                String userString = user.toString();

                assertTrue(userString.contains(user.getId().toString()));
                assertTrue(userString.contains("test@example.com"));
                assertTrue(userString.contains("password123"));
                assertTrue(userString.contains("USER"));
            }
        }
    }
}
