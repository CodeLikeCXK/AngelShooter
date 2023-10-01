class AAngelEnemyChracterBase : AAngelCharacterBase
{
    AAngelPlayerCharacterBaseLegacy PlayerRef;
    UPROPERTY(DefaultComponent)
    UAngelEnemyComponent AngelEnemyComponent;
    default AngelEnemyComponent.bHighLighted = false;

    UPROPERTY(BlueprintReadWrite)
    bool CanDealDamage;


    APawn player;

    default bUseControllerRotationYaw = true;

    

    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Enemy")
    USphereComponent PlayerCollisionDetection;
    default PlayerCollisionDetection.SphereRadius = 800.f;

    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Enemy")
    USphereComponent PlayerAttackCollisionDetection;

    UPROPERTY(DefaultComponent, EditAnywhere, Category = "Enemy", Attach = CharacterMesh0, AttachSocket = "WeaponHandSocket")
    UBoxComponent DamageDetection;

    AAngelEnemyControllerBase AngelEnemyController;

    FTimerHandle SeekPlayerTimerHandle;

    default bUseControllerRotationYaw = true;


    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        AngelEnemyController = Cast<AAngelEnemyControllerBase>(GetController());
        player = Gameplay::GetPlayerPawn(0);



    }

    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaSeconds)
    {

    }






}