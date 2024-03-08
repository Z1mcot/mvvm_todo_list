1. Добавить <Android SDK Location>/sdk/platform-tools в PATH. Android SDK Location указан в Android Studio -> Настройки -> Languages & Frameworks -> Android SDK -> Android SDK Location
2. Запустить терминал и перейти в папку, в которую хотите сохранить бэкап приложения
3. В терминале прописать `adb shell pm list packages -f -3 | grep com.example`, чтобы получить нужный applicationId
4. Сделать бэкап с помощью `adb backup -noapk <applicationId>` (Например: `adb backup -noapk com.example.mvvm_todo_list`)
5. Подтвердить бэкап на устройстве, пароль лучше не вводить
6. Использовать одну из следующих команд для распаковки:
    i `dd if=backup.ab bs=24 skip=1|openssl zlib -d > backup.tar`
    ii `dd if=backup.ab bs=1 skip=24 | python3 -c "import zlib,sys;sys.stdout.buffer.write(zlib.decompress(sys.stdin.buffer.read()))" | tar -xvf -`
7. по пути `com.example.*/r/databases` найти файл БД