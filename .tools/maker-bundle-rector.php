
<?php

use Rector\Config\RectorConfig;
use Rector\Set\ValueObject\LevelSetList;
use Rector\Set\ValueObject\SetList;

return static function (RectorConfig $config): void {
    $config->paths([
        'src/Test',
    ]);

    $config->bootstrapFiles([
        getenv('HOME').'/.composer/vendor/autoload.php',
        'vendor/autoload.php',
    ]);

    $config->sets([
        LevelSetList::UP_TO_PHP_81,
    ]);

    $config->skip([
        Rector\Php81\Rector\Property\ReadOnlyPropertyRector::class,
    ]);
};

