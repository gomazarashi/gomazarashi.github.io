const themeStorageKey = "gomazarashi-theme";
const darkTheme = "dark";
const lightTheme = "light";

function applyTheme(theme) {
  if (theme === darkTheme) {
    document.documentElement.setAttribute("data-theme", darkTheme);
  } else {
    document.documentElement.removeAttribute("data-theme");
  }
}

function syncToggle(button, theme) {
  const isDark = theme === darkTheme;
  button.textContent = isDark ? "Light" : "Dark";
  button.setAttribute("aria-pressed", String(isDark));
  button.setAttribute(
    "title",
    isDark ? "ライトモードに切り替え" : "ダークモードに切り替え"
  );
}

const savedTheme = localStorage.getItem(themeStorageKey);
const initialTheme = savedTheme === darkTheme ? darkTheme : lightTheme;
applyTheme(initialTheme);

document.addEventListener("DOMContentLoaded", () => {
  const button = document.getElementById("theme-toggle");
  if (!button) {
    return;
  }

  let currentTheme = document.documentElement.getAttribute("data-theme") === darkTheme
    ? darkTheme
    : lightTheme;

  syncToggle(button, currentTheme);

  button.addEventListener("click", () => {
    currentTheme = currentTheme === darkTheme ? lightTheme : darkTheme;
    applyTheme(currentTheme);
    localStorage.setItem(themeStorageKey, currentTheme);
    syncToggle(button, currentTheme);
  });
});
