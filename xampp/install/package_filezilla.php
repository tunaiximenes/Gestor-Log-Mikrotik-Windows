<?php
class register_filezilla
{
    public static $name     = 'FileZilla FTP Server';
    public static $relocate = true;
};

if (!class_exists('relocate_XAMPP')) {
    class relocate_XAMPP {}
}
class relocate_filezilla extends relocate_XAMPP
{
    private static $relocfiles = array(
        'normal' => array(
            'FileZillaFTP\FileZilla Server.xml'
        )
    );

    public static function Run()
    {
        echo 'relocate '.register_filezilla::$name.PHP_EOL;
        fflush(STDOUT);

        $filelist = array();
        $filelist = array_merge($filelist, self::findFiles(self::$relocfiles['normal']));

        foreach ($filelist as $filename) {
            $oldfileperm = fileperms($filename);
            if (!chmod($filename, 0666) && !is_writable($filename)) {
                throw new XAMPPException("File '{$filename}' is not writable.");
            }

            $filecontent = file_get_contents($filename);
            self::relocateString($filecontent);

            file_put_contents($filename, $filecontent);
            chmod($filename, $oldfileperm);
        }

        return;
    }
}
?>
